#[macro_use]
extern crate serde_derive;
use cfg_if::cfg_if;
use js_sys::Function;
use std::cell::RefCell;
use std::panic;
use std::rc::Rc;
use wasm_bindgen::prelude::*;
use wasm_bindgen::JsCast;
use web_sys::*;
use js_sys::Promise;
use wasm_bindgen_futures::future_to_promise;
use wasm_bindgen_futures::JsFuture;
use futures::{future, Future};
use finiteelement::{FiniteElement, FesWorkspace};
use finiteelement::{Point};

macro_rules! log {
    ($($e: expr), *) => {
        log_str(&format!($($e,)*))
    }
}

mod webgl;
use webgl::*;

cfg_if! {
    // When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
    // allocator.
    if #[cfg(feature = "wee_alloc")] {
        extern crate wee_alloc;
        #[global_allocator]
        static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;
    }
}

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log_str(s: &str);
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log(s: &JsValue);
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log_event(s: &MouseEvent);
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log_key(s: &KeyboardEvent);
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log_wheel(s: &WheelEvent);
    #[wasm_bindgen(js_namespace = console, js_name=log)]
    fn log_target(s: &EventTarget);

    pub type Editor;
    fn editor() -> Editor;
    #[wasm_bindgen(method, js_name=getValue)]
    fn get_value(s: &Editor) -> String;

    fn set_canvas_dim(w: i32, h: i32);
}

pub struct State {
    pub scene: webgl::Scene,
    pub editor: Editor,
    pub finite: Option<Finite>,
    pub needs_redraw: bool,
}

pub struct Finite {
    pub system: Vec<Box<dyn FiniteElement<f64>>>,
    pub workspace: FesWorkspace<f64>,
    pub nanostructure: design::Nanostructure,
    pub pairs: Vec<Option<usize>>,
    pub is_relaxing: bool,
}

#[wasm_bindgen(start)]
pub fn main() -> Result<(), JsValue> {
    panic::set_hook(Box::new(console_error_panic_hook::hook));

    let window = web_sys::window().unwrap();
    let document = window.document().unwrap();
    let state = Rc::new(RefCell::new(State {
        scene: draw_gl()?,
        editor: editor(),
        finite: None,
        needs_redraw: true,
    }));

    webgl::set_handlers(state.clone())?;

    set_reset_handler(&document, state.clone())?;
    set_relax_handler(&document, state.clone())?;
    set_export_handler(&document, state.clone())?;
    request_animation_frame(window, state.clone())?;
    Ok(())
}

fn set_reset_handler(document: &Document, state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let can: HtmlButtonElement = document
        .get_element_by_id("compile")
        .unwrap()
        .dyn_into()?;
    let handler = Closure::wrap(Box::new(move |_e: MouseEvent| {
        fetch_json(state.clone());
    }) as Box<dyn FnMut(web_sys::MouseEvent)>);
    can.set_onclick(handler.as_ref().dyn_ref());
    handler.forget();
    Ok(())
}

fn set_export_handler(document: &Document, state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let can: HtmlButtonElement = document
        .get_element_by_id("export")
        .unwrap()
        .dyn_into()?;
    let handler = Closure::wrap(Box::new(move |_e: MouseEvent| {
        let window = web_sys::window().unwrap();
        let document = window.document().unwrap();
        export_cadnano(&document, state.clone());
    }) as Box<dyn FnMut(web_sys::MouseEvent)>);
    can.set_onclick(handler.as_ref().dyn_ref());
    handler.forget();
    Ok(())
}

fn set_relax_handler(document: &Document, state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let state0 = state.clone();
    let can: HtmlButtonElement = document
        .get_element_by_id("relax")
        .unwrap()
        .dyn_into()?;
    let handler = Closure::wrap(Box::new(move |_e: MouseEvent| {

        let mut state = state0.borrow_mut();
        if let Some(ref mut finite) = state.finite {
            finite.is_relaxing = true
        }

    }) as Box<dyn FnMut(web_sys::MouseEvent)>);
    can.set_onclick(handler.as_ref().dyn_ref());
    handler.forget();

    let can: HtmlButtonElement = document
        .get_element_by_id("stop")
        .unwrap()
        .dyn_into()?;
    let handler = Closure::wrap(Box::new(move |_e: MouseEvent| {

        let mut state = state.borrow_mut();
        if let Some(ref mut finite) = state.finite {
            finite.is_relaxing = false
        }

    }) as Box<dyn FnMut(web_sys::MouseEvent)>);
    can.set_onclick(handler.as_ref().dyn_ref());
    handler.forget();
    Ok(())
}


fn fetch_json(state: Rc<RefCell<State>>) -> Promise {
    let mut opts = RequestInit::new();
    opts.method("POST");
    opts.mode(RequestMode::Cors);
    {
        let state = state.borrow();
        opts.body(Some(&JsValue::from_str(&state.editor.get_value())));
    }
    let request = Request::new_with_str_and_init(
        "/run",
        &opts,
    )
        .unwrap();

    request
        .headers()
        .set("Accept", "application/json")
        .unwrap();

    let window = web_sys::window().unwrap();
    let request_promise = window.fetch_with_request(&request);

    let future = JsFuture::from(request_promise)
        .and_then(|resp_value| {
            // `resp_value` is a `Response` object.
            assert!(resp_value.is_instance_of::<Response>());
            let resp: Response = resp_value.dyn_into().unwrap();
            resp.json()
        })
        .and_then(|json_value: Promise| {
            // Convert this other `Promise` into a rust `Future`.
            JsFuture::from(json_value)
        })
        .and_then(move |json| {
            // Send the `Branch` struct back to JS as an `Object`.
            let json: design::Res = json.into_serde::<design::Res>().unwrap();
            if !json.err.is_empty() {
                log!("{}", json.err);
            }
            if let Ok(json) = js_sys::JSON::parse(&json.out) {
                match json.into_serde::<design::JSONNanostructure>() {
                    Ok(nanostructure) => {
                        log!("json decoded");
                        let nanostructure = nanostructure.into_nanostructure();
                        let mut state = state.borrow_mut();
                        state.finite = Some(Finite {
                            system: nanostructure::make_system(&nanostructure),
                            workspace: FesWorkspace::new(nanostructure.positions.len()),
                            pairs: nanostructure.make_pairs(),
                            is_relaxing: false,
                            nanostructure,
                        });
                        state.needs_redraw = true;
                        log!("redraw");
                        state.draw().unwrap();
                    }
                    Err(e) => log!("Error: {:?}", e)
                }
            }
            future::ok(JsValue::from_serde(&()).unwrap())
        });

    // Convert this Rust `Future` back into a JS `Promise`.
    future_to_promise(future)
}

fn export_cadnano(document: &Document, state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let state = state.borrow();
    let text: HtmlInputElement = document
        .get_element_by_id("text")
        .unwrap()
        .dyn_into()?;
    text.set_value(&state.editor.get_value());
    Ok(())
}

fn request_animation_frame(window: Window, state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let handler: Rc<RefCell<Option<Closure<dyn FnMut()>>>> = Rc::new(RefCell::new(None));
    let h = handler.clone();
    let window_ = window.clone();
    let closure = Closure::wrap(Box::new(move || {
        let mut state = state.borrow_mut();
        if let Some(ref mut finite) = state.finite {
            if finite.is_relaxing {
                log!("one step");
                let done = finiteelement::fes_one_step(
                    &finite.system,
                    &mut finite.nanostructure.positions,
                    1e-1,
                    1e-5,
                    &mut finite.workspace
                );
                if done {
                    finite.is_relaxing = false
                }
                state.needs_redraw = true;
            }
        }
        state.draw().unwrap();
        let mut handler = h.borrow_mut();
        if let Some(ref h) = *handler {
            window_
                .request_animation_frame(h.as_ref().unchecked_ref())
                .unwrap();
        }
    }) as Box<dyn FnMut()>);
    window.request_animation_frame(closure.as_ref().unchecked_ref())?;
    let mut h = handler.borrow_mut();
    *h = Some(closure);
    Ok(())
}
