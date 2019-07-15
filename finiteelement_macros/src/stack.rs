use crate::autoimplementable::AutoImplementable;
use crate::formal;
use crate::formal::{Float, Formal, FormalPoint, FormalVector};
use std::collections::HashMap;

/// Rotation spring
pub struct _Stack<F: Float> {
    // a and c are joined by a covalent bond, so are d and b.
    //
    // a-b: first base pair
    pub a: usize,
    pub b: usize,
    // c-d: second base pair
    pub c: usize,
    pub d: usize,

    pub angle0: F,
    pub strength: F,
}

impl<F: Float> AutoImplementable<F> for _Stack<F> {
    fn struct_name() -> String {
        String::from("Stack")
    }
    fn elt_list() -> Vec<String> {
        vec![
            String::from("a"),
            String::from("b"),
            String::from("c"),
            String::from("d"),
        ]
    }

    fn cst_list() -> Vec<String> {
        vec![String::from("angle0"), String::from("strength")]
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

        let point_c = FormalPoint {
            x: Formal::new_var(6),
            y: Formal::new_var(7),
            z: Formal::new_var(8),
        };

        let point_d = FormalPoint {
            x: Formal::new_var(9),
            y: Formal::new_var(10),
            z: Formal::new_var(11),
        };

        let cst_angle0 = Formal::new_var(12);
        let cst_strength = Formal::new_var(13);

        let middle1 = formal::middle(&point_a, &point_b, F::from(0.5).unwrap());
        let middle2 = formal::middle(&point_c, &point_d, F::from(0.5).unwrap());
        let axe = middle2.clone() - middle1.clone();
        let v1 = point_b.clone() - point_a.clone();

        let v2 = point_d.clone() - point_c.clone();

        let theta = formal::angle(&v1, &v2, &axe);
        let torque = cst_strength.clone() * (theta.clone() - cst_angle0);

        let mut ret = HashMap::new();

        ret.insert(
            String::from("a"),
            torque.clone() * formal::vector_product(&axe, &(middle1.clone() - point_a)),
        );
        ret.insert(
            String::from("b"),
            torque.clone() * formal::vector_product(&axe, &(middle1.clone() - point_b)),
        );

        ret.insert(
            String::from("c"),
            -torque.clone() * formal::vector_product(&axe, &(middle2.clone() - point_c)),
        );
        ret.insert(
            String::from("d"),
            -torque.clone() * formal::vector_product(&axe, &(middle2.clone() - point_d)),
        );

        ret
    }
}
