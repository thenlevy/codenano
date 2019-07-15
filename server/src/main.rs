#[macro_use] extern crate clap;
#[macro_use] extern crate log;
use futures::stream::Stream;
use futures::{Async, Future, Poll};
use hyper::header::CONTENT_TYPE;
use hyper::service::service_fn;
use hyper::StatusCode;
use hyper::{Body, Request, Response, Server};
use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use std::borrow::Cow;
use std::io::Write;
use std::path::Path;
use std::process::Command;
use std::time::SystemTime;

mod cadnano;

fn not_found(_req: Request<Body>) -> futures::Finished<hyper::Response<hyper::Body>, hyper::Error> {
    let body = "";
    futures::finished(
        Response::builder()
            .status(StatusCode::NOT_FOUND)
            .body(Body::from(body))
            .unwrap(),
    )
}

fn main() {
    env_logger::init();
    let matches = clap::App::new("Codenano server")
        .version(crate_version!())
        .author("P.E. Meunier")
        .arg(
            clap::Arg::with_name("path")
                .long("static")
                .help("Static path")
                .required(true)
                .takes_value(true),
        )
        .get_matches();
    let addr = ([127, 0, 0, 1], 4000).into();
    let base_path = std::fs::canonicalize(Path::new(matches.value_of("path").unwrap())).unwrap();
    hyper::rt::run(futures::lazy(move || {
        let new_svc = move || {
            let version_time = SystemTime::now();
            let version_time_str = httpdate::fmt_http_date(version_time);
            let path = base_path.clone();
            service_fn(
                move |req: Request<Body>| -> Box<
                    dyn Future<Item = hyper::Response<hyper::Body>, Error = hyper::Error> + Send,
                > {
                    let mut path = path.clone();
                    let req_path = req.uri().path();
                    let name: String = std::iter::once('z')
                        .chain(thread_rng().sample_iter(&Alphanumeric).take(30))
                        .collect();

                    if req_path == "/run" {
                        return Box::new(run(req, name));
                    } else if req_path == "/export-cadnano.json" {
                        return Box::new(export_cadnano(req, name));
                    }
                    path.push(req_path.split_at(1).1);
                    if let Ok(p) = std::fs::canonicalize(&path) {
                        if !p.starts_with(&path) {

                        }
                    }
                    if let Ok(m) = std::fs::metadata(&path) {
                        if m.is_dir() {
                            path.push("index.html")
                        }
                    }
                    debug!("serving {:?}", path);
                    if let Some(resp) = hyper_static::serve_static_path_ok(
                        version_time,
                        &version_time_str,
                        &req,
                        &path,
                    ) {
                        Box::new(futures::finished(resp))
                    } else {
                        Box::new(not_found(req))
                    }
                },
            )
        };

        Server::bind(&addr)
            .serve(new_svc)
            .map_err(|e| eprintln!("server error: {}", e))
    }))
}

fn run(
    req: Request<Body>,
    name: String,
) -> impl Future<Item = hyper::Response<hyper::Body>, Error = hyper::Error> {
    req.into_body().concat2().and_then(move |body| {
        let mut f = std::fs::File::create(&name).unwrap();
        f.write_all(&body).unwrap();
        (RunFuture { file: Some(name) }).then(|x| match x {
            Ok(x) => {
                let x = serde_json::to_string(&x).unwrap();
                futures::finished(
                    hyper::Response::builder()
                        .status(hyper::StatusCode::OK)
                        .body(x.into())
                        .unwrap(),
                )
            }
            Err(e) => futures::finished(
                hyper::Response::builder()
                    .status(hyper::StatusCode::INTERNAL_SERVER_ERROR)
                    .body(format!("{:?}", e).into())
                    .unwrap(),
            ),
        })
    })
}

pub(crate) struct RunFuture {
    file: Option<String>,
}

fn docker(name: &str) -> Result<design::Res, failure::Error> {
    Command::new("docker")
        .arg("run")
        .arg("--name")
        .arg(&name)
        .arg("--memory=200m")
        .arg("--cpus=1")
        .arg("--network")
        .arg("none")
        .arg("-td")
        .arg("codenano")
        .status()?;
    Command::new("docker")
        .arg("cp")
        .arg(&name)
        .arg(&format!("{}:appuser/src/main.rs", name))
        .status()?;

    let process = Command::new("docker")
        .arg("exec")
        .arg(&name)
        .arg("timeout")
        .arg("5s")
        .arg("sh")
        .arg("-c")
        .arg("cd appuser && cargo run -q")
        .output()?;
    debug!("{}", std::str::from_utf8(&process.stderr).unwrap());
    debug!("{}", std::str::from_utf8(&process.stdout).unwrap());
    let out = if process.status.success() {
        String::from_utf8(process.stdout)?
    } else {
        debug!("{}", std::str::from_utf8(&process.stderr).unwrap());
        "".to_string()
    };
    Command::new("docker").arg("kill").arg(&name).status()?;
    Command::new("docker").arg("rm").arg(&name).status()?;
    Ok(design::Res {
        out,
        err: String::from_utf8_lossy(&process.stderr).into_owned(),
    })
}

impl Future for RunFuture {
    type Item = design::Res;
    type Error = failure::Error;
    fn poll(&mut self) -> Poll<Self::Item, Self::Error> {
        match tokio_threadpool::blocking(|| {
            let name = self.file.take().unwrap();
            docker(&name)
        }) {
            Ok(Async::NotReady) => Ok(Async::NotReady),
            Ok(Async::Ready(x)) => Ok(Async::Ready(x?)),
            Err(e) => Err(e.into()),
        }
    }
}

fn export_cadnano(
    req: hyper::Request<hyper::Body>,
    name: String,
) -> impl Future<Item = hyper::Response<Body>, Error = hyper::Error> {
    req.into_body().concat2().and_then(move |body_| {
        let mut body: Cow<str> = "".into();
        for (k, v) in url::form_urlencoded::parse(&body_) {
            if k == "text" {
                body = v
            }
        }

        debug!("{:?}", body);

        let mut f = std::fs::File::create(&name).unwrap();
        f.write_all(body.as_bytes()).unwrap();

        (RunFuture { file: Some(name) })
            .and_then(|x| cadnano::to_cadnano(x.out.as_bytes()))
            .then(|x| match x {
                Ok(x) => futures::finished(
                    hyper::Response::builder()
                        .status(hyper::StatusCode::OK)
                        .header(CONTENT_TYPE, "application/octet-stream")
                        .body(x.into())
                        .unwrap(),
                ),
                Err(e) => futures::finished(
                    hyper::Response::builder()
                        .status(hyper::StatusCode::INTERNAL_SERVER_ERROR)
                        .body(format!("{:?}", e).into())
                        .unwrap(),
                ),
            })
    })
}
