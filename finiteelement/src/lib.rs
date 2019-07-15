//! This module defines the trait `FiniteElement`, and provides methods to
//! solve finite element systems.
//!
//! # Example
//! ```
//! use finiteelement::*;
//!//Define a struct that implements the FiniteElement trait
//!
//!
//!#[derive(Clone)]
//!pub struct Spring {
//!    pub a: usize,
//!    pub b: usize,
//!    pub l: f64,
//!    pub k: f64,
//!}
//!
//!impl FiniteElement<f64> for Spring {
//!    fn forces(&self, positions: &[Point<f64>], forces: &mut [f64]) {
//!        // add to both a and b the force resulting from this spring.
//!        let ab = positions[self.b].clone() - positions[self.a].clone();
//!        let norm = ab.norm();
//!        forces[3 * self.a] += self.k * (norm - self.l) * ab.x / norm;
//!        forces[3 * self.a + 1] += self.k * (norm - self.l) * ab.y / norm;
//!        forces[3 * self.a + 2] += self.k * (norm - self.l) * ab.z / norm;
//!        forces[3 * self.b] -= self.k * (norm - self.l) * ab.x / norm;
//!        forces[3 * self.b + 1] -= self.k * (norm - self.l) * ab.y / norm;
//!        forces[3 * self.b + 2] -= self.k * (norm - self.l) * ab.z / norm;
//!    }
//!
//!    fn jacobian(&self, positions: &[Point<f64>], jacobian: &mut Sparse<f64>) {
//!        // add to both a and b the force resulting from this self.
//!        let ab = positions[self.b].clone() - positions[self.a].clone();
//!        let norm = ab.norm();
//!        let norm3 = norm * norm * norm;
//!        for u in 0..3 {
//!            for v in 0..3 {
//!                let j = if u == v {
//!                    self.k * (1. - self.l / norm + self.l * ab[u] * ab[u] / norm3)
//!                } else {
//!                    self.k * self.l * ab[u] * ab[v] / norm3
//!                };
//!                // Change in the force on B when moving B.
//!                jacobian[3 * self.b + u][3 * self.b + v] -= j;
//!                // Change in the force on A when moving B.
//!                jacobian[3 * self.a + u][3 * self.b + v] += j;
//!                // Change in the force on B when moving A.
//!                jacobian[3 * self.b + u][3 * self.a + v] += j;
//!                // Change in the force on A when moving A.
//!                jacobian[3 * self.a + u][3 * self.a + v] -= j;
//!            }
//!        }
//!    }
//!}
//!
//!let elts = [
//!    Spring {
//!        a: 0,
//!        b: 1,
//!        l: 1.,
//!        k: 1.,
//!    },
//!    Spring {
//!        a: 1,
//!        b: 2,
//!        l: 2.,
//!        k: 0.5,
//!    },
//!    Spring {
//!        a: 0,
//!        b: 2,
//!        l: 3.,
//!        k: 5.
//!    },
//!];
//!let system = (0..elts.len()).map(|i| {Box::new(elts[i].clone()) as Box<dyn FiniteElement<f64>>}).collect::<Vec<_>>();
//!let mut positions = vec![
//!  Point { x: 0., y: 0., z: 0. },
//!  Point {x : 1., y: 0., z: 0.},
//!  Point{x: 0., y: 1., z: 1.}];
//!
//!let mut ws = FesWorkspace::new(positions.len());
//!let epsilon_stop = 1e-4;
//!let gradient_switch = 1e-3;
//!let mut solved = false;
//!for i in (0..20) {
//!   solved = fes_one_step(&system, &mut positions, epsilon_stop, gradient_switch, &mut ws);
//!   if solved {
//!      break;
//!   }
//!}
//!assert!(solved);
//! ```
//!
//!# Use of the macro provided by finiteelement_macro
//!
//! To use one of the macro provided by `finiteelement_marco`, call it without parameter at the 
//! begining or your code. The piece of code surrounded by `//========` in the example above can be
//! replaced by a call to `finiteelement_macros::auto_impl_spring!{}`
//!
//!```
//! use finiteelement::*;
//! use std::borrow::Borrow;
//!auto_impl_spring!{}
//!pub fn main() {
//! let elts = [
//!     Spring {
//!         a: 0,
//!         b: 1,
//!         l: 1.,
//!         k: 1.,
//!     },
//!     Spring {
//!         a: 1,
//!         b: 2,
//!         l: 2.,
//!         k: 0.5,
//!     },
//!     Spring {
//!         a: 0,
//!         b: 2,
//!         l: 3.,
//!         k: 5.
//!     },
//! ];
//! let system = (0..elts.len()).map(|i| {Box::new(elts[i].clone()) as Box<dyn FiniteElement<f64>>}).collect::<Vec<_>>();
//! let mut positions = vec![
//!   Point { x: 0., y: 0., z: 0. },
//!   Point {x : 1., y: 0., z: 0.},
//!   Point{x: 0., y: 1., z: 1.}];
//! 
//! let mut ws = FesWorkspace::new(positions.len());
//! let epsilon_stop = 1e-4;
//! let gradient_switch = 1e-3;
//! let mut solved = false;
//! for i in (0..20) {
//!    solved = fes_one_step(&system, &mut positions, epsilon_stop, gradient_switch, &mut ws);
//!    if solved {
//!       break;
//!    }
//! }
//!assert!(solved);
//!}
//!```

#![deny(missing_docs)]

mod matrix;
/// 3D Points and Vectors
pub mod geometry;
extern crate num_traits;
extern crate finiteelement_macros;

pub use crate::geometry::{Point, Vector};
pub use matrix::{Sparse};
use std::borrow::Borrow;
pub use num_traits::{Float};
pub use finiteelement_macros::{auto_impl_spring, auto_impl_stack};


/// A trait for updating the forces vector and its jacobian in a finite element system.
///
/// The piece of code that implements that trait can be generated by procedurals macros.
pub trait FiniteElement<F: Float> {
    /// Updates the force vector.
    ///
    /// For each points on which `&self` applies a force, the corresponding values in `forces` are
    /// incremented.
    fn forces(&self, positions: &[Point<F>], forces: &mut [F]);

    /// Updates the jacobian.
    ///
    /// For each pairs of points involved in the system, the value at the corresponding coordinates
    /// in `jacobian` is incremented.
    fn jacobian(&self, positions: &[Point<F>], jacobian: &mut Sparse<F>);
}

/// Workspace of the `fes_one_step` function.
pub struct FesWorkspace<F: Float> {
    pub(crate) forces: Vec<F>,
    pub(crate) jacobian: Sparse<F>,
    pub(crate) best_sol: Vec<Point<F>>,
    pub(crate) best_score: F,
    pub(crate) gradient: bool,
    pub(crate) rms_prop: F,
    nb_gradient: usize,
    /// number of gradient descent step performed before switiching back to newton's method
    pub max_nb_gradient: usize,
}

impl<F: Float> FesWorkspace<F> {
    /// Create a new `FesWorkspace`
    ///
    /// # Arguement: 
    ///  * nb_points, the number of point in the Finite Element System to be solved
    ///
    /// # Use:
    /// The returned `FesWorkspace` is ready to be used by `fes_one_step`. One may want to modify
    /// the value of `max_nb_gradient` before use (initial value is 5).
    pub fn new(nb_points: usize) -> Self {
        FesWorkspace {
            forces: vec![F::zero() ; 3 * nb_points],
            jacobian: Sparse::new(3 * nb_points, 3 * nb_points),
            best_sol: vec![Point {
                x: F::zero(),
                y: F::zero(),
                z: F::zero()
            }; nb_points],
            best_score: F::one().neg(),
            gradient: false,
            rms_prop: F::zero(),
            nb_gradient: 0,
            max_nb_gradient: 5,
        }
    }

}

/// Solve a system of finite element.
///
/// Arguments:
///  * `system` is a slice of finite elements. 
///  * `posistions` is the initial vector of positions of the points of the system, it is
///     updated at each step of the optimization
///  * `nb_iter` maximum number of optimization step (see below)
///  * `epsilon_stop` threshold at witch the optimization is considered finished (see below)
///  * `gradient_swith` threshold for switching to gradient descent (see below)
///  * `nb_gradient_steps` number of gradient descent steps before switching back to Newton's
///     method (see below).
///  * `snapshot_step` number of optimization between each snapshot (see below). 
///
/// Optimization steps are performed untill one of the following happens
///  * `nb_iter` steps have been performed
///  * There is no point in the system on which an acceleration of norm greater than `epsilon_stop` is 
///    applied
///
/// The method used here is an hybrid between Newton's method
/// and gradient descent. In the first iterations, Newton's method will be used.
/// More precesily, it will perform the following opperation: 
/// `for i in 0..posistions.len() { positions[i] += delta[i]}` where delta is a solution
/// to the equation J*delta = F where F and J are respectively the acceleration vector
/// and its Jacobian.
/// 
/// If during one step of Newton's method the norm of `delta` is smaller than `gradient_switch`,
/// `nb_gradient_steps` steps of gradient descent are performed. Each gradient step do the
/// following opperation:
/// `for i in 0..positions.len() { positions[i] -= rate * force[i] }` where `rate` is a parameter
/// that is updated using the rms prop heuristic. Once these gradient descent steps have been
/// done, the next steps are Newton's method steps.
///
/// Every `snapshot_step` steps, the current value of `positions` is pushed in a `Vec` that will be
/// returned by this function. If `snapshot_step` is set to 0, snapshots are never made and an
/// empty vector will be returned.
///
/// A value of about 5 is recommended for `nb_gradient_steps`.
pub fn solve_fes<'a, F: Float + 'a, B: FiniteElement<F>>(
    system: &[B],
    positions: &mut [Point<F>],
    nb_iter: usize,
    epsilon_stop: F,
    gradient_switch: F,
    nb_gradient_steps: usize,
    snapshot_steps: usize
) -> Vec<Vec<Point<F>>> {
    let mut ret = Vec::new();
    let n_point = positions.len();

    //println!("position {:?}\n", positions);
    let mut ws = FesWorkspace::new(n_point);
    ws.max_nb_gradient = nb_gradient_steps;
    for i in 0..nb_iter {

        if snapshot_steps > 0 && i % snapshot_steps == 0 {
            ret.push(positions.iter().map(|p| p.clone()).collect());
        }
            
        if fes_one_step(
            system,
            positions,
            epsilon_stop,
            gradient_switch,
            &mut ws
        ) {
            return ret
        } 
    }
    ret
}

impl<'a, F: Float + 'a, B: Borrow<dyn FiniteElement<F>>> FiniteElement<F> for B {
    fn forces(&self, positions: &[Point<F>], forces: &mut [F]) {
        self.borrow().forces(positions, forces)
    }
    fn jacobian(&self, positions: &[Point<F>], jacobian: &mut Sparse<F>) {
        self.borrow().jacobian(positions, jacobian)
    }
}

/// Perform one iteration of Newton's method.
///
/// Argument:
///  * `system`: A system of finite element
///  * `posistions`: The positions of the points of the system. It is updated using either newton's
///     method (if `ws.gradient == false`) or gradient descent (if `ws.gradient == true`)
///  *  `epsilon`: If on all points of the system the acceleration that is applied has a norm less
///     that `epsilon` the finite element system is considered to be solved.
///  *  `gradient_switch`: threshold that determines wether the next optimization step should be a
///     gradient descent or a newton's method step
///  * ws: The workspace of the function, it will be updated.
pub fn fes_one_step<'a, F: Float + 'a, B: FiniteElement<F>>(
    system: &[B],
    positions: &mut [Point<F>],
    epsilon: F,
    gradient_switch: F,
    ws: &mut FesWorkspace<F>
) -> bool {

    if ws.gradient && ws.nb_gradient == ws.max_nb_gradient {
        ws.gradient = false;
        ws.nb_gradient = 0;
    } else if ws.gradient {
        ws.nb_gradient += 1;
    }


    let n_point = positions.len();
    let forces = &mut ws.forces;
    let best_score = &mut ws.best_score;
    let best_sol = &mut ws.best_sol;
    let gradient = &mut ws.gradient;
    let rms_prop = &mut ws.rms_prop;
    let jacobian = &mut ws.jacobian;
    forces.clear();
    forces.extend(std::iter::repeat(F::zero()).take(3 * n_point));
    compute_forces(&system, &positions, &mut forces[..]);

    let mut max_norm: F = F::zero();
    for i in 0..(forces.len() / 3) {
        max_norm = max_norm.max(
            Vector {
                x: forces[3 * i],
                y: forces[3 * i + 1],
                z: forces[3 * i + 2],
            }
            .norm(),
        )
    }
    println!("max norm {}", max_norm.to_f64().unwrap());
        //println!("max norm {}, forces, [{}]",max_norm.to_f64().unwrap(), forces.iter().map(|f| format!("{:.0e}", f.to_f64().unwrap())).collect::<Vec<String>>().join(", "));
        //println!("max norm {}", max_norm.to_f64().unwrap());
    if max_norm < *best_score || *best_score < F::zero() {
        *best_sol = positions.iter().map(|p| p.clone()).collect();
        *best_score = max_norm;
    }

    if max_norm < epsilon {
        return true;
    }
    else if *gradient {
        let eta = F::from(0.00001).unwrap();
        let epsilon_grad = F::from(1e-8).unwrap();

        *rms_prop = if *rms_prop == F::zero() {
            F::from(forces.iter().map(|f| f.to_f64().unwrap().powi(2)).sum::<f64>()).unwrap()
                / (F::from(positions.len() as f32).unwrap())
        } else {
            F::from(0.9).unwrap() * *rms_prop + F::from(0.1).unwrap() 
                * F::from(forces.iter().map(|f| f.to_f64().unwrap().powi(2)).sum::<f64>()).unwrap() 
                / (F::from(positions.len() as f32).unwrap())
        };

        let rate = eta / (*rms_prop + epsilon_grad).sqrt();
        for i in 0..positions.len() {
            positions[i].x = positions[i].x + forces[3 * i] * F::from(rate).unwrap();
            positions[i].y = positions[i].y + forces[3 * i + 1] * F::from(rate).unwrap();
            positions[i].z = positions[i].z + forces[3 * i + 2] * F::from(rate).unwrap();
        }
        let origin = positions[0];
        for i in 0..positions.len() {
            positions[i].x = positions[i].x - origin.x;
            positions[i].y = positions[i].y - origin.y;
            positions[i].z = positions[i].z - origin.z;
        }
    } else {
        compute_jacobian(&system, &positions, jacobian);
        *forces = matrix::lsqr(jacobian, forces, F::from(2e-4).unwrap()); 
        
        max_norm = F::zero();
        for i in 0..(forces.len() / 3) {
            max_norm = max_norm.max(
                Vector {
                    x: forces[3 * i],
                    y: forces[3 * i + 1],
                    z: forces[3 * i + 2],
                }
                .norm(),
            )
        }
        println!("max norm {}", max_norm.to_f64().unwrap());
        if max_norm < gradient_switch {
            *gradient = true;
        }
        
        for i in 0..positions.len() {
            positions[i].x = positions[i].x - forces[3 * i];
            positions[i].y = positions[i].y - forces[3 * i + 1];
            positions[i].z = positions[i].z - forces[3 * i + 2];
        }

        let origin = positions[0];
        for i in 0..positions.len() {
            positions[i].x = positions[i].x - origin.x;
            positions[i].y = positions[i].y - origin.y;
            positions[i].z = positions[i].z - origin.z;
        }

        forces.clear();
        forces.extend(std::iter::repeat(F::zero()).take(3 * n_point));
        compute_forces(&system, &positions, &mut forces[..]);

    }
    false
}

fn compute_forces<'a, F: Float + 'a, B: FiniteElement<F>>(
    system: &[B],
    positions: &[Point<F>],
    forces: &mut [F],
) {
    for x in forces.iter_mut() {
        *x = F::zero()
    }
    for spring in system.into_iter() {
        spring.borrow().forces(positions, forces)
    }
}

fn compute_jacobian<'a, F: Float + 'a, B: FiniteElement<F>>(
    system: &[B],
    positions: &[Point<F>],
    jacobian: &mut Sparse<F>,
) {
    // The matrix is of size 3 * |system|.
    jacobian.reset();
    for spring in system.into_iter() {
        spring.borrow().jacobian(positions, jacobian)
    }
}
