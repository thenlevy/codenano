use wasm_bindgen::prelude::*;
use wasm_bindgen::JsCast;
use web_sys::{WebGlProgram, WebGlRenderingContext, WebGlBuffer};
use super::*;
use std::f32::consts::PI;
use std::rc::Rc;
use finiteelement::{Point};
mod matrix;
use matrix::*;
mod helpers;
use helpers::*;

pub fn draw_gl() -> Result<Scene, JsValue> {
    let document = web_sys::window().unwrap().document().unwrap();
    let canvas = document.get_element_by_id("glcanvas").unwrap();
    let canvas: web_sys::HtmlCanvasElement = canvas.dyn_into::<web_sys::HtmlCanvasElement>()?;

    let context = canvas
        .get_context("webgl")?
        .unwrap()
        .dyn_into::<WebGlRenderingContext>()?;

    context.enable(WebGlRenderingContext::DEPTH_TEST);

    let buffer = context.create_buffer().ok_or("failed to create buffer")?;

    let vert_shader = compile_shader(
        &context,
        WebGlRenderingContext::VERTEX_SHADER,
        r#"
        attribute vec3 position;
        uniform mat4 model;
        void main() {
            gl_Position = model * vec4(position, 1.0);
        }
    "#,
    )?;
    let frag_shader = compile_shader(
        &context,
        WebGlRenderingContext::FRAGMENT_SHADER,
        r#"
        uniform mediump vec4 color;
        void main() {
            gl_FragColor = color;
        }
    "#,
    )?;
    let program = link_program(&context, &vert_shader, &frag_shader)?;
    context.use_program(Some(&program));

    Ok(Scene {
        canvas, context, program,
        model: Matrix::id(),
        model_: Matrix::id(),
        alpha: 0.,
        beta: 0.,
        scale: 1.,
        clicked: None,
        points: design::Points::default(),
        color: [1.; 4],
        step: 0,
        by_step: false,
        bases: Vec::new(),
        backbone: Vec::new(),
        buffer,
    })
}

pub struct Scene {
    pub canvas: web_sys::HtmlCanvasElement,
    pub context: WebGlRenderingContext,
    pub program: WebGlProgram,
    pub model: Matrix,
    pub model_: Matrix,
    pub color: [f32; 4],
    pub alpha: f32,
    pub beta: f32,
    pub scale: f32,
    pub bases: Vec<f32>,
    pub points: design::Points<f32>,
    pub step: usize,
    pub by_step: bool,
    pub backbone: Vec<f32>,
    pub clicked: Option<(f32, f32)>,
    pub buffer: WebGlBuffer,
}

// const X_ANGLE: f32 = 0.01;
// const Y_ANGLE: f32 = 0.01;
pub fn set_handlers(state: Rc<RefCell<State>>) -> Result<(), JsValue> {
    let state0 = state.clone();
    let gl_mouse_move = Closure::wrap(Box::new(move |event: web_sys::MouseEvent| {
        let mut state = state0.borrow_mut();
        if let Some((x0, y0)) = state.scene.clicked {
            let w = state.scene.canvas.width() as f32;
            let h = state.scene.canvas.height() as f32;
            let r = w.max(h) / 2.;
            let x = (event.x() as f32 - x0) / (r * state.scene.scale);
            let y = (event.y() as f32 - y0) / (r * state.scene.scale);
            state.scene.model_ = Matrix::translate(x, -y, 0.);
            state.needs_redraw = true;
            state.draw().unwrap()
        }
    }) as Box<dyn FnMut(_)>);
    state.borrow_mut().scene.canvas.add_event_listener_with_callback("mousemove", gl_mouse_move.as_ref().unchecked_ref())?;
    gl_mouse_move.forget();

    let state0 = state.clone();
    let gl_mousedown = Closure::wrap(Box::new(move |event: web_sys::MouseEvent| {
        let mut state = state0.borrow_mut();
        state.scene.clicked = Some((event.x() as f32, event.y() as f32));
        state.needs_redraw = true;
        state.draw().unwrap()
    }) as Box<dyn FnMut(_)>);
    state.borrow_mut().scene.canvas.set_onmousedown(Some(gl_mousedown.as_ref().unchecked_ref()));
    gl_mousedown.forget();


    let state0 = state.clone();
    let gl_mouseup = Closure::wrap(Box::new(move |_: web_sys::MouseEvent| {
        let mut state = state0.borrow_mut();
        if let Some(_) = state.scene.clicked.take() {
            state.scene.model = state.scene.model_ * state.scene.model;
            state.scene.model_ = Matrix::id();
            state.needs_redraw = true;
            state.draw().unwrap()
        }
    }) as Box<dyn FnMut(_)>);
    state.borrow_mut().scene.canvas.set_onmouseup(Some(gl_mouseup.as_ref().unchecked_ref()));
    state.borrow_mut().scene.canvas.set_onmouseout(Some(gl_mouseup.as_ref().unchecked_ref()));
    gl_mouseup.forget();


    let state0 = state.clone();
    let gl_mouseout = Closure::wrap(Box::new(move |_: web_sys::MouseEvent| {
        let mut state = state0.borrow_mut();
        if let Some(_) = state.scene.clicked.take() {
            state.needs_redraw = true;
            state.draw().unwrap()
        }
    }) as Box<dyn FnMut(_)>);
    state.borrow_mut().scene.canvas.set_onmouseout(Some(gl_mouseout.as_ref().unchecked_ref()));
    gl_mouseout.forget();

    let state0 = state.clone();
    let gl_resize = Closure::wrap(Box::new(move |_: web_sys::Event| {
        let mut state = state0.borrow_mut();
        state.needs_redraw = true;
        state.draw().unwrap()
    }) as Box<dyn FnMut(_)>);

    state.borrow_mut().scene.canvas.set_onresize(Some(gl_resize.as_ref().unchecked_ref()));
    let window = web_sys::window().unwrap();
    window.set_onresize(Some(gl_resize.as_ref().unchecked_ref()));
    gl_resize.forget();


    let state0 = state.clone();
    let gl_wheel = Closure::wrap(Box::new(move |e: web_sys::WheelEvent| {
        let mut state = state0.borrow_mut();
        let s = 1.1;
        // log!("{:?}", state.scene.model);
        if e.delta_y() < 0. {
            state.scene.scale *= s
        } else if e.delta_y() > 0. {
            state.scene.scale /= s
        }
        let e: Event = e.into();
        e.stop_propagation();
        e.prevent_default();
        state.needs_redraw = true;
        state.draw().unwrap()
    }) as Box<dyn FnMut(_)>);
    state.borrow_mut().scene.canvas.set_onwheel(Some(gl_wheel.as_ref().unchecked_ref()));
    gl_wheel.forget();
    Ok(())
}

impl State {
    pub fn draw(&mut self) -> Result<(), JsValue> {
        if !self.needs_redraw {
            return Ok(())
        }
        let window = web_sys::window().unwrap();
        let document = window.document().unwrap();
        let gl = document.get_element_by_id("gl").unwrap();
        let rect = gl.get_bounding_client_rect();
        log!("{:?} {:?}", rect.height(), window.inner_height());
        let height = rect.height() - 8.;
        let width = rect.width();

        // let height = window.inner_height().unwrap().as_f64().unwrap() - 40.;
        self.scene.canvas.set_height(height as u32);
        self.scene.canvas.set_width(width as u32);
        self.scene.context.viewport(0, 0, width as i32, height as i32);
        let ratio = (width as f32) / (height as f32);
        let loc = self.scene.context.get_uniform_location(&self.scene.program, "model");
        let model =
            self.scene.model_
            * self.scene.model
            * Matrix::scale(self.scene.scale / ratio, self.scene.scale, self.scene.scale);
        self.scene.context.uniform_matrix4fv_with_f32_array(loc.as_ref(), false, &model.0);
        self.scene.context.clear_color(1.0, 1.0, 1.0, 1.0);
        self.scene.context.clear(WebGlRenderingContext::COLOR_BUFFER_BIT);

        self.draw_backbone()?;
        self.draw_bonds()?;
        self.needs_redraw = false;
        Ok(())
    }

    fn draw_backbone(&mut self) -> Result<(), JsValue> {
        // Drawing the backbone for each strand.
        let mut last_vec_op: Option<Vector> = None;
        let finite = if let Some(ref finite) = self.finite {
            finite
        } else {
            return Ok(())
        };
        for p in finite.nanostructure.strands.iter() {
            self.scene.backbone.clear();
            // log!("{:?}", p);
            // let mut ww: Option<([f32;4], [f32;4])> = None;
            for (i, &base) in p.strand.iter().enumerate() {
                let position: Vector = finite.nanostructure.positions[base].into();
                // log!("position = {:?}", position);
                let vec_next = if i < p.strand.len()-1 {
                    let next = p.strand[i+1];
                    // log!("next = {:?} {:?} {:?}", i, base, next);
                    Vector::from(finite.nanostructure.positions[next]) - position
                } else {
                    let prev = p.strand[i-1];
                    position - Vector::from(finite.nanostructure.positions[prev])
                };
                // log!("vec_next = {:?}", vec_next);
                let vec_op = if let Some(b) = finite.pairs[base] {
                    Vector::from(finite.nanostructure.positions[b]) - position
                } else if let Some(last) = last_vec_op {
                    let mut v = Vector::random();
                    v = v * 0.1 / v.norm();
                    v
                } else {
                    loop {
                        let mut v = Vector::random();
                        let p = v.dot_product(&vec_next);
                        let v = v - p * vec_next / vec_next.norm();
                        if v.norm() >= 0.1 {
                            break v / v.norm()
                        }
                    }
                };
                last_vec_op = Some(vec_op.clone());
                for i in 0..3 {
                    self.scene.backbone.push(position.0[i]);
                }
            }
            self.scene.color[2] = (p.color & 0xff) as f32 / 255.;
            self.scene.color[1] = ((p.color >> 8) & 0xff) as f32 / 255.;
            self.scene.color[0] = ((p.color >> 16) & 0xff) as f32 / 255.;
            let loc_color = self.scene.context.get_uniform_location(&self.scene.program, "color");
            self.scene.context.uniform4fv_with_f32_array(loc_color.as_ref(), &self.scene.color);
            bind_attrib_array(&self.scene.context, &self.scene.program, &self.scene.buffer, &self.scene.backbone, 3, "position")?;
            self.scene.context.draw_arrays(
                WebGlRenderingContext::LINE_STRIP,
                0,
                self.scene.backbone.len() as i32 / 3,
            );
        }
        Ok(())
    }
    fn draw_bonds(&mut self) -> Result<(), JsValue> {

        let finite = if let Some(ref mut finite) = self.finite {
            finite
        } else {
            return Ok(())
        };
        self.scene.bases.clear();
        self.scene.bases.reserve(finite.nanostructure.positions.len() * 3);
        for (i, p) in finite.nanostructure.positions.iter().enumerate() {
            if let Some(j) = finite.pairs[i] {
                if j < i {
                    self.scene.bases.push(p.x as f32);
                    self.scene.bases.push(p.y as f32);
                    self.scene.bases.push(p.z as f32);
                    let q = finite.nanostructure.positions[j];
                    self.scene.bases.push(q.x as f32);
                    self.scene.bases.push(q.y as f32);
                    self.scene.bases.push(q.z as f32);
                }
            }
        }

        if !self.scene.bases.is_empty() {
            /*self.color[0] = 1.;
            self.color[1] = 1.;
            self.color[2] = 1.;
            self.color[3] = 1.;*/
            // log!("lens = {:?} {:?}", self.color.len(), self.backbone.len());
            // bind_attrib_array(&self.context, &self.program, &self.color, 4, "vertex_color")?;
            let loc_color = self.scene.context.get_uniform_location(&self.scene.program, "color");
            self.scene.context.uniform4fv_with_f32_array(loc_color.as_ref(), &self.scene.color);
            bind_attrib_array(&self.scene.context, &self.scene.program, &self.scene.buffer, &self.scene.bases, 3, "position")?;
            for i in 0..self.scene.bases.len()/6 {
                self.scene.context.draw_arrays(
                    WebGlRenderingContext::LINE_STRIP,
                    i as i32*2,
                    2,
                );
            }
        }
        Ok(())
    }
}
