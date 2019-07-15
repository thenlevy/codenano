use crate::autoimplementable::AutoImplementable;
use crate::formal::{Float, Formal, FormalPoint, FormalVector};

use std::collections::HashMap;

// A `Spring` likes it when `a` and `b` are at distance `l`, and
// exerts a force of `k.(|ab| - l)` to achieve this.
pub struct _Spring {}

impl<F: Float> AutoImplementable<F> for _Spring {
    fn elt_list() -> Vec<String> {
        vec![String::from("a"), String::from("b")]
    }

    fn cst_list() -> Vec<String> {
        vec![String::from("l"), String::from("k")]
    }

    fn formal_map() -> HashMap<String, FormalVector<F>> {
        let point_a = FormalPoint {
            x: Formal::new_var(0),
            y: Formal::new_var(1),
            z: Formal::new_var(2),
        };

        let point_b = FormalPoint {
            x: Formal::new_var(3),
            y: Formal::new_var(4),
            z: Formal::new_var(5),
        };

        let cst_l = Formal::new_var(6);
        let cst_k = Formal::new_var(7);

        let ab = point_b - point_a;
        let force_a: FormalVector<F> =
            (ab.clone().norm() - cst_l.clone()) * ab.clone() / ab.clone().norm() * cst_k.clone();
        let force_b = (ab.clone().norm() - cst_l.clone()) * ab.clone() / ab.clone().norm()
            * cst_k.clone()
            * Formal::new_cst(F::one().neg());
        let mut ret = HashMap::new();
        ret.insert(String::from("a"), force_a);
        ret.insert(String::from("b"), force_b);
        ret
    }

    fn struct_name() -> String {
        String::from("Spring")
    }
}
