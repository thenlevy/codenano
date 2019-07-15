use crate::formal::{Float, FormalVector};
use proc_macro::TokenStream;
use std::collections::HashMap;

pub trait AutoImplementable<F: Float> {
    ///The list of the element's attributes that correspond to a point
    ///of the system. For example, if the element involves two points that are called `A` and `B`
    ///then `elt_list()` must return `["A", "B"]`.
    fn elt_list() -> Vec<String>;

    ///The list of the element's attribut that correspond to parameters
    ///of the element. In the case of a spring, these attributes are the characteristic length l0 and
    ///the spring constant k. In this case `cst_list()` must return `["l0", "k"]`.
 fn cst_list() -> Vec<String>;

    ///A mapping of the members of `elt_list()`
    ///to `FormalVector`. If `p: String` is the name of an element then `formal_map()[p]` is a
    ///`FormalVector` that represents the force applied on `p`. For example, the force applied on
    ///for `_Spring`.
    fn formal_map() -> HashMap<String, FormalVector<F>>;

    ///The name of the `struct` that the macro will generate. 
    ///For example in the case of a spring, it could be `Spring`
    fn struct_name() -> String;
}

#[doc(hidden)]
fn struct_def<F: Float, T: AutoImplementable<F>>() -> String {
    let elt = T::elt_list()
        .iter()
        .map(|s| format!("pub {}: usize,", s))
        .collect::<Vec<String>>()
        .join("\n");
    let cst = T::cst_list()
        .iter()
        .map(|s| format!("pub {}: F,", s))
        .collect::<Vec<String>>()
        .join("\n");
    format!(
        "#[derive(Clone)] \n\
         pub struct {0}<F: Float> {{ \n\
         {1} \n\
         {2} \n\
         }}",
        T::struct_name(),
        elt,
        cst
    )
}

#[doc(hidden)]
fn appl_force(struct_name: String, point_name: String, arg_list: String) -> String {
    vec![("x", "0"), ("y", "1"), ("z", "2")]
        .iter()
        .map(|(s, s_)| {
            format!(
                "forces[3 * self.{0} + {3}] = forces[3 * self.{0} + {3}] + {4}_force_{0}_{1}({2});",
                point_name, s, arg_list, s_, struct_name
            )
        })
        .collect::<Vec<String>>()
        .join("\n")
}

#[doc(hidden)]
fn define_jacobian<F: Float>(
    struct_name: &String,
    wrp_name: &String,
    wrp_idx: usize,
    point_name: &String,
    force_vect: &FormalVector<F>,
    nb_vars: usize,
) -> String {
    let mut jacobians: Vec<String> = Vec::new();
    for (c, i) in vec![("x", 0), ("y", 1), ("z", 2)] {
        let diff_vector = force_vect.differentiate(3 * wrp_idx + i);
        jacobians.push(diff_vector.rust_code(
            format!(
                "{}_jacobian_wrp_{}_{}_{}",
                struct_name, wrp_name, c, point_name
            ),
            nb_vars,
        ));
    }
    jacobians.join("\n")
}

#[doc(hidden)]
fn appl_jacobian(
    struct_name: String,
    point_name: String,
    wrp_name: String,
    arg_list: String,
) -> String {
    let mut applications: Vec<String> = Vec::new();
    let coordonates = vec![("x", "0"), ("y", "1"), ("z", "2")];
    for (i, n) in coordonates.clone() {
        for (j, m) in coordonates.clone() {
            applications.push(
                format!("jacobian[3 * self.{0} + {1}][3 * self.{2} + {3}] =\
                        jacobian[3 * self.{0} + {1}][3 * self.{2} + {3}] + {7}_jacobian_wrp_{2}_{4}_{0}_{5}({6});",
                        point_name,
                        n,
                        wrp_name,
                        m, i, j,
                        arg_list, struct_name)
                );
        }
    }
    applications.join("\n")
}

#[doc(hidden)]
fn auto_code<F: Float, T: AutoImplementable<F>>() -> String {
    let formal_map = T::formal_map();
    let elt_list = T::elt_list();
    let cst_list = T::cst_list();

    let nb_vars = 3 * elt_list.len() + cst_list.len();

    // arguments that will be passed to the formal fuction
    let arg_list = {
        let elt_iter = elt_list.iter().map(|s| {
            format!(
                "positions[self.{0}].borrow().x,\
                 positions[self.{0}].borrow().y,\
                 positions[self.{0}].borrow().z",
                s
            )
        });

        let cst_iter = cst_list.iter().map(|s| format!("self.{}", s));

        elt_iter.chain(cst_iter).collect::<Vec<String>>().join(",")
    };

    // Define all the forces using the formals
    let forces_decl = T::elt_list()
        .iter()
        .map(|s| {
            formal_map
                .get(s)
                .unwrap()
                .rust_code(format!("{}_force_{}", T::struct_name(), s), nb_vars)
        })
        .collect::<Vec<String>>()
        .join("\n");

    let forces_applications = T::elt_list()
        .iter()
        .map(|s| appl_force(T::struct_name(), s.to_string(), arg_list.clone()))
        .collect::<Vec<String>>()
        .join("\n");

    //let jacobian_decl = T::elt_list().iter().map
    // For each element e1:
    //   For each coordonate c1:
    //      For each element e2:
    //          For each coordonate c2:
    //              compute jacobian_wrp_e1_c1_e2_c2
    //              the derivative of force_e2_c2 wrp to e1.c1
    //
    let n = T::elt_list().len();
    let jacobian_decl = (0..n)
        .map(|i| {
            (0..n)
                .map(|j| {
                    //let elt_list = T::elt_list();
                    define_jacobian(
                        &T::struct_name(),
                        &elt_list[i],
                        i,
                        &elt_list[j],
                        T::formal_map().get(&elt_list[j]).unwrap(),
                        nb_vars,
                    )
                })
                .collect::<Vec<String>>()
                .join("\n")
        })
        .collect::<Vec<String>>()
        .join("\n");

    let jacobian_applications = T::elt_list()
        .iter()
        .map(|point| {
            T::elt_list()
                .iter()
                .map(|wrp| {
                    appl_jacobian(
                        T::struct_name(),
                        point.to_string(),
                        wrp.to_string(),
                        arg_list.clone(),
                    )
                })
                .collect::<Vec<String>>()
                .join("\n")
        })
        .collect::<Vec<String>>()
        .join("\n");

    let generated_code = format!(
        "{0} \n\
         {1} \n\
        
         impl<F: Float> finiteelement::FiniteElement<F> for {3}<F> {{ \n\
         fn forces(&self, positions: &[Point<F>], forces: &mut [F]) {{ \n\
         {2} \n\
         }} \n\
          fn jacobian(&self, positions: &[Point<F>], jacobian: &mut Sparse<F>) {{ {4} }}
         }}",
        forces_decl,
        jacobian_decl,
        forces_applications,
        T::struct_name(),
        jacobian_applications
    );

    generated_code
}

/// Returns a `TokenStream` that defines the type `T::struct_name()` and implement the trait
/// `FiniteElement` for it.
/// This function is meant to be called inside the definition of a `proc_macro`.
pub fn macro_def<F: Float, T: AutoImplementable<F>>() -> TokenStream {
    format!("{}\n {}", struct_def::<F, T>(), auto_code::<F, T>())
        .parse()
        .unwrap()
}
