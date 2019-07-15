//! This library is used to define types that implement the trait  `FiniteElement`
//!  
//! The types are defined by procedural macros. To create a new type, one must first define an
//! unit-like Structure and implement the trait `AutoImplementable` for it. Once the trait
//! `AutoImplementable` has been implemented it is possible to define a proc macro that will
//! generate the deffinition of a new type and an implementation of the trait `FiniteElement` for
//! it.
//!
//! # Creation of a new macro
//!
//! To create a new macro, one must first define a Zero-Sized `struct`, and implement the trait
//! `AutoImplementable` for it. For example if we want to create an element representing a spring,
//! we first create a zero-sized `struct`: `pub struct _Spring{}` and the implement the trait
//! `Autotimplementable` for it.
//!
//! The types that implement the trait `AutoImplementable` can be passed as type argument to the
//! function `macro_def<F: Float, T: AutoImplementable<F>>() -> TokenStream`. This function
//! can be used to define a procedural macro that will generate the code defining the
//! corresponding structure and its implementation of the trait `FiniteElement`. 
//! Complete example
//! (copied-pasted from `spring.rs`)
//! ```
//!
//!use crate::formal::{Formal, FormalVector, FormalPoint, Float};
//!use crate::autoimplementable::AutoImplementable;
//!
//!use std::collections::HashMap;
//!
//!// A `Spring` likes it when `a` and `b` are at distance `l`, and
//!// exerts a force of `k.(|ab| - l)` to achieve this.
//!pub struct _Spring{}
//!
//!impl<F: Float> AutoImplementable<F> for _Spring {
//!    fn struct_name() -> String {
//!        String::from("Spring")
//!    }
//!
//!    fn elt_list() -> Vec<String> {
//!        vec![String::from("a"), String::from("b")]
//!    }
//!
//!    fn cst_list() -> Vec<String> {
//!        vec![String::from("l"), String::from("k")]
//!    }
//!
//!    fn formal_map() -> HashMap<String, FormalVector<F>> {
//!    //Create a `Formal` for each element coordiate and each constants
//!        let point_a = FormalPoint {
//!            x: Formal::new_var(0),
//!            y: Formal::new_var(1),
//!            z: Formal::new_var(2)
//!        };
//!
//!        let point_b = FormalPoint {
//!            x: Formal::new_var(3),
//!            y: Formal::new_var(4),
//!            z: Formal::new_var(5)
//!        };
//!
//!        let cst_l = Formal::new_var(6);
//!        let cst_k = Formal::new_var(7);
//!
//!        // The force applied on point a is k(|ab| - l) * ab/|ab|
//!        let ab = point_b - point_a;
//!        let force_a: FormalVector<F> = (ab.clone().norm() - cst_l.clone()) * ab.clone()/ab.clone().norm() * cst_k.clone();
//!
//!        // The force applied on point b is k(|ba| - l) * ba/|ba|
//!        let force_b = (ab.clone().norm() - cst_l.clone()) * ab.clone()/ab.clone().norm() * cst_k.clone() * Formal::new_cst(F::one().neg());
//!        let mut ret = HashMap::new();
//!        ret.insert(String::from("a"), force_a);
//!        ret.insert(String::from("b"), force_b);
//!        ret
//!    }
//!
//!}
//!
//!// Once the trait is implemented, we can write a procedural macro
//!#[proc_macro]
//!pub fn auto_impl_spring(_item: TokenStream) -> TokenStream {
//!    macro_def::<f32, _Spring>()
//!}
//! ```
//!
//!
//!

extern crate proc_macro;



/// Defines the trait `AutoImplementable`
mod autoimplementable;
/// Defines a type to represent mathematical formulas whose derivatives can be computed
/// automatically
mod formal;
#[doc(hidden)]
mod spring;
#[doc(hidden)]
mod stack;

pub (crate) use autoimplementable::*;
use proc_macro::TokenStream;
use spring::_Spring;
use stack::_Stack;

/// A `Spring` likes it when `a` and `b` are at distance `l`, and
/// exerts a force of `k.(|ab| - l)` to achieve this.
#[proc_macro]
pub fn auto_impl_spring(_item: TokenStream) -> TokenStream {
    macro_def::<f32, _Spring>()
}

/// A `Stack` likes it when the angle between `ab` and `cd` is equal to `theta0`, and
/// exerts a torque of `k.(theta - theta0)` to achieve this.
#[proc_macro]
pub fn auto_impl_stack(_item: TokenStream) -> TokenStream {
    macro_def::<f32, _Stack<f32>>()
}
