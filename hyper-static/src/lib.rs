extern crate httpdate;
extern crate hyper;
extern crate mime_guess;
#[macro_use]
extern crate log;
use std::time::SystemTime;
use std::path::Path;

pub fn serve_static_path_ok<P:AsRef<Path>>(
    version_time: SystemTime,
    version_time_str: &str,
    req: &hyper::Request<hyper::Body>,
    path: P,
) -> Option<hyper::Response<hyper::Body>> {
    use hyper::header::*;
    use hyper::StatusCode;
    use std::io::Read;
    let path = path.as_ref();
    let mime = {
        let mime = mime_guess::guess_mime_type(path);
        format!("{}", mime)
    };

    let need_resend = if let Some(ifmodified) = req
        .headers()
        .get(IF_MODIFIED_SINCE)
        .and_then(|ifmodified| ifmodified.to_str().ok())
        .and_then(|ifmodified| httpdate::parse_http_date(ifmodified).ok())
    {
        version_time > ifmodified
    } else {
        true
    };

    let now = std::time::SystemTime::now();
    Some(if need_resend || cfg!(debug_assertions) {
        debug!("file has changed, needs to resend");

        let mut buf = Vec::new();
        let mut file = if let Ok(file) = std::fs::File::open(path) {
            file
        } else {
            return None
        };
        file.read_to_end(&mut buf).unwrap();
        hyper::Response::builder()
            .status(StatusCode::OK)
            .header(CACHE_CONTROL, "public")
            .header(CONTENT_TYPE, mime.as_str())
            .header(LAST_MODIFIED, version_time_str)
            .header(DATE, httpdate::fmt_http_date(now))
            .body(buf.into()).unwrap()
    } else {
        hyper::Response::builder()
            .status(StatusCode::NOT_MODIFIED)
            .header(CACHE_CONTROL, "public")
            .header(CONTENT_TYPE, mime.as_str())
            .header(LAST_MODIFIED, version_time_str)
            .header(DATE, httpdate::fmt_http_date(now))
            .body(hyper::Body::empty()).unwrap()
    })
}
