pub extern crate num_traits;
pub use num_traits::Float;
use std;
use std::collections::hash_set::HashSet;
use std::rc::Rc;

#[derive(Debug, Clone)]
/// The labbel of a formal
enum FormalEnum<F: Float> {
    Var(usize),
    Const(F),
    PolyF { pow: F, formal: Formal<F> },
    PolyI { pow: i32, formal: Formal<F> },
    Mult(Formal<F>, Formal<F>),
    Add(Formal<F>, Formal<F>),
    Neg(Formal<F>),
    Div(Formal<F>, Formal<F>),
    Cos(Formal<F>),
    Sin(Formal<F>),
    Acos(Formal<F>),
    Atan2(Formal<F>, Formal<F>),
}

#[derive(Debug)]
/// A `Rc` to a `FormalEnum`
pub struct Formal<F: Float>(Rc<FormalEnum<F>>);

impl<F: Float> AsRef<Formal<F>> for Formal<F> {
    fn as_ref(&self) -> &Self {
        self
    }
}

/// Clone self using the `Rc::clone` method
impl<F: Float> Clone for Formal<F> {
    fn clone(&self) -> Self {
        let Formal(rc) = self;
        Formal(rc.clone())
    }
}

impl<F: Float> Formal<F> {
    /// Returns a leaf labbeled by the variable `var_id`.
    pub fn new_var(var_id: usize) -> Formal<F> {
        Formal(Rc::new(FormalEnum::Var(var_id)))
    }

    /// Returns a leaf labbeled by the constant `x`.
    pub fn new_cst(x: F) -> Formal<F> {
        Formal(Rc::new(FormalEnum::Const(x)))
    }
}

impl<F: Float> std::ops::Add<Formal<F>> for Formal<F> {
    type Output = Self;
    fn add(self, b: Self) -> Self {
        let Formal(ref me) = self;
        let Formal(ref other) = b;
        match **me {
            FormalEnum::Const(x) if x == Float::neg_zero() => b.clone(),
            _ => match **other {
                FormalEnum::Const(x) if x == Float::neg_zero() => self,
                _ => Formal(Rc::new(FormalEnum::Add(self, b.clone()))),
            },
        }
    }
}

impl<F: Float> std::ops::Sub<Formal<F>> for Formal<F> {
    type Output = Self;
    fn sub(self, b: Self) -> Self {
        let Formal(ref me) = self;
        match **me {
            FormalEnum::Const(x) if x == Float::neg_zero() => self,
            _ => Formal(Rc::new(FormalEnum::Add(self, -b))),
        }
    }
}

impl<F: Float> std::ops::Neg for Formal<F> {
    type Output = Self;
    fn neg(self) -> Self {
        let Formal(ref me) = self;
        match &**me {
            FormalEnum::Const(x) => Formal::new_cst(x.neg()),
            FormalEnum::Add(a, b) => Formal(Rc::new(FormalEnum::Add(-a.clone(), -b.clone()))),

            FormalEnum::Mult(a, b) => Formal(Rc::new(FormalEnum::Mult(-a.clone(), b.clone()))),
            FormalEnum::Neg(x) => x.clone(),
            _ => Formal(Rc::new(FormalEnum::Neg(self))),
        }
    }
}

impl<F: Float> std::ops::Mul<Formal<F>> for Formal<F> {
    type Output = Self;
    fn mul(self, b: Self) -> Self {
        let Formal(ref me) = self;
        let Formal(ref other) = b;
        match **me {
            FormalEnum::Const(x) if x == F::one() => b.clone(),
            FormalEnum::Const(x) if x == F::one().neg() => -b.clone(),
            FormalEnum::Const(x) if x == F::zero() => Formal::new_cst(F::zero()),
            _ => match **other {
                FormalEnum::Const(x) if x == F::one() => self,
                FormalEnum::Const(x) if x == F::one().neg() => -self,
                FormalEnum::Const(x) if x == F::zero() => Formal::new_cst(F::zero()),
                _ => Formal(Rc::new(FormalEnum::Mult(self, b.clone()))),
            },
        }
    }
}

impl<F: Float> std::ops::Mul<F> for Formal<F> {
    type Output = Self;
    fn mul(self, b: F) -> Self {
        if b == F::zero() {
            Formal::new_cst(F::zero())
        } else if b == F::one() {
            self.clone()
        } else if b == F::one().neg() {
            -self
        } else {
            let rh = Formal(Rc::new(FormalEnum::Const(b)));
            Formal(Rc::new(FormalEnum::Mult(self, rh.clone())))
        }
    }
}

impl<F: Float> std::ops::Div<Formal<F>> for Formal<F> {
    type Output = Self;
    fn div(self, b: Self) -> Self {
        Formal(Rc::new(FormalEnum::Div(self, b.clone())))
    }
}

#[doc(hidden)]
impl<F: Float> std::convert::From<F> for Formal<F> {
    fn from(e: F) -> Self {
        Formal(Rc::new(FormalEnum::Const(e)))
    }
}

#[doc(hidden)]
pub fn var<F: Float>(n: usize) -> Formal<F> {
    Formal(Rc::new(FormalEnum::Var(n)))
}

#[doc(hidden)]
fn var_to_string(n: usize) -> String {
    String::from("fv") + &n.to_string()
}

impl<F: Float> Formal<F> {
    /// Returns the Formal representing `x.powf(pow)` where `x` is the formula represented by
    /// `self`.
    pub fn powf(&self, pow: F) -> Self {
        let inside = FormalEnum::PolyF {
            pow,
            formal: self.clone(),
        };
        Formal(Rc::new(inside))
    }

    /// Returns the Formal representing `x.powi(pow)` where `x` is the formula represented by
    /// `self`.
    pub fn powi(&self, pow: i32) -> Self {
        let inside = FormalEnum::PolyI {
            pow,
            formal: self.clone(),
        };
        Formal(Rc::new(inside))
    }

    /// Returns the Formal representing `x.cos()` where `x` is the formula represented by
    /// `self`.
    pub fn cos(&self) -> Self {
        Formal(Rc::new(FormalEnum::Cos(self.clone())))
    }

    /// Returns the Formal representing `x.sin()` where `x` is the formula represented by
    /// `self`.
    pub fn sin(&self) -> Self {
        Formal(Rc::new(FormalEnum::Sin(self.clone())))
    }

    /// Returns the Formal representing `x.acos()` where `x` is the formula represented by
    /// `self`.
    pub fn acos(&self) -> Self {
        Formal(Rc::new(FormalEnum::Acos(self.clone())))
    }

    #[doc(hidden)]
    pub fn eval(&self, var: &[F]) -> F {
        let Formal(ref me) = *self;
        match **me {
            FormalEnum::Var(n) => var[n],
            FormalEnum::Const(x) => x,
            FormalEnum::Mult(ref a, ref b) => a.eval(var) * b.eval(var),
            FormalEnum::Div(ref a, ref b) => a.eval(var) / b.eval(var),
            FormalEnum::Add(ref a, ref b) => a.eval(var) + b.eval(var),
            FormalEnum::PolyF { pow, ref formal } => formal.eval(var).powf(pow),
            FormalEnum::PolyI { pow, ref formal } => formal.eval(var).powi(pow),
            FormalEnum::Sin(ref x) => x.eval(var).sin(),
            FormalEnum::Cos(ref x) => x.eval(var).cos(),
            FormalEnum::Acos(ref x) => x.eval(var).acos(),
            FormalEnum::Neg(ref x) => -x.eval(var),
            FormalEnum::Atan2(ref a, ref b) => a.eval(var).atan2(b.eval(var)),
        }
    }

    /// Returns the Formal representing `df/d(var[n])` where `f` is the formula represented by
    /// `self`.
    pub fn derivative(&self, n: usize) -> Self {
        let Formal(ref me) = *self;
        match **me {
            FormalEnum::Var(m) if n == m => Formal(Rc::new(FormalEnum::Const(F::one()))),

            FormalEnum::Cos(ref m) => m.derivative(n) * -m.sin(),

            FormalEnum::Sin(ref m) => m.derivative(n) * m.cos(),

            FormalEnum::Var(_) | FormalEnum::Const(_) => {
                Formal(Rc::new(FormalEnum::Const(F::zero())))
            }

            FormalEnum::PolyF { pow, ref formal } => {
                Formal(Rc::new(FormalEnum::PolyF {
                    pow: pow - F::one(),
                    formal: formal.clone(),
                })) * formal.derivative(n)
                    * pow
            }

            FormalEnum::PolyI { pow, ref formal } => {
                Formal(Rc::new(FormalEnum::PolyI {
                    pow: pow - 1,
                    formal: formal.clone(),
                })) * formal.derivative(n)
                    * (F::from(pow).unwrap())
            }

            FormalEnum::Mult(ref a, ref b) => {
                a.derivative(n) * b.clone() + b.derivative(n) * a.clone()
            }

            FormalEnum::Div(ref a, ref b) => Formal(Rc::new(FormalEnum::Div(
                a.derivative(n) * b.clone() - a.clone() * b.derivative(n),
                b.clone().powi(2),
            ))),

            FormalEnum::Add(ref a, ref b) => a.derivative(n) + b.derivative(n),

            FormalEnum::Acos(ref m) => {
                -m.derivative(n)
                    * (-m.clone().powi(2) + Formal::new_cst(F::one())).powf(F::from(0.5).unwrap())
            }
            FormalEnum::Neg(ref a) => -a.derivative(n),
            FormalEnum::Atan2(ref a, ref b) => {
                (a.clone() / (a.powi(2) + b.powi(2))) * a.derivative(n)
                    - (b.clone() / (a.powi(2) + b.powi(2))) * b.derivative(n)
            }
        }
    }

    #[doc(hidden)]
    pub fn body(&self) -> String {
        let Formal(ref me) = *self;
        match **me {
            FormalEnum::Const(x) => format!("F::from({:e}).unwrap()", x.to_f64().unwrap()),
            FormalEnum::Var(n) => var_to_string(n),
            FormalEnum::Add(ref a, ref b) => {
                String::from("(")
                    + &a.body()
                    + &String::from(" + ")
                    + &b.body()
                    + &String::from(")")
            }
            FormalEnum::Mult(ref a, ref b) => {
                String::from("(")
                    + &a.body()
                    + &String::from(" * ")
                    + &b.body()
                    + &String::from(")")
            }
            FormalEnum::Div(ref a, ref b) => {
                String::from("(")
                    + &a.body()
                    + &String::from(") / (")
                    + &b.body()
                    + &String::from(")")
            }
            FormalEnum::PolyF { pow, ref formal } => format!(
                "({}).powf(F::from({}).unwrap())",
                formal.body(),
                pow.to_f64().unwrap()
            ),
            FormalEnum::PolyI { pow, ref formal } => format!("({}).powi({})", formal.body(), pow),
            FormalEnum::Cos(ref a) => format!("({}).cos()", a.body()),
            FormalEnum::Sin(ref a) => format!("({}).sin()", a.body()),
            FormalEnum::Acos(ref a) => format!("({}).acos()", a.body()),
            FormalEnum::Neg(ref a) => format!("-({})", a.body()),
            FormalEnum::Atan2(ref a, ref b) => format!("({}).atan2({})", a.body(), b.body()),
        }
    }

    #[doc(hidden)]
    fn set_of_vars(&self) -> HashSet<usize> {
        let Formal(ref me) = *self;
        match **me {
            FormalEnum::Const(_) => HashSet::new(),
            FormalEnum::Var(n) => {
                let mut temp = HashSet::new();
                temp.insert(n);
                temp
            }

            FormalEnum::Add(ref a, ref b)
            | FormalEnum::Mult(ref a, ref b)
            | FormalEnum::Div(ref a, ref b)
            | FormalEnum::Atan2(ref a, ref b) => {
                let mut ret = HashSet::new();
                for v in a.set_of_vars() {
                    ret.insert(v);
                }
                for v in b.set_of_vars() {
                    ret.insert(v);
                }
                ret
            }

            FormalEnum::PolyF { ref formal, .. } => formal.set_of_vars(),
            FormalEnum::PolyI { ref formal, .. } => formal.set_of_vars(),

            FormalEnum::Cos(ref a)
            | FormalEnum::Sin(ref a)
            | FormalEnum::Acos(ref a)
            | FormalEnum::Neg(ref a) => a.set_of_vars(),
        }
    }

    #[doc(hidden)]
    pub fn rust_code(&self, fun_name: String, nb_var: usize) -> String {
        let vars = self.set_of_vars();
        let n = if nb_var == 0 { vars.len() } else { nb_var };
        let arg_list = (0..n)
            .map(|i| var_to_string(i) + &String::from(" :F"))
            .collect::<Vec<String>>()
            .join(",");

        String::from("pub fn ")
            + &fun_name
            + &String::from("<F: Float>")
            + &String::from("(")
            + &arg_list
            + &String::from(")-> F")
            + &String::from(" {\n")
            + &self.body()
            + &String::from("\n}")
    }
}

/// A 3D points with `Formal` coordinates
#[derive(Debug, Clone)]
pub struct FormalPoint<F: Float> {
    pub x: Formal<F>,
    pub y: Formal<F>,
    pub z: Formal<F>,
}

/// The difference between two `FormalPoint`
#[derive(Debug, Clone)]
pub struct FormalVector<F: Float> {
    pub x: Formal<F>,
    pub y: Formal<F>,
    pub z: Formal<F>,
}

impl<F: Float> FormalVector<F> {
    /// Returns the formal representing the norm the vector represented by `self`
    pub fn norm(&self) -> Formal<F> {
        self.norm2().powf(F::from(0.5).unwrap())
    }

    /// Return `dot_product(self, self)`
    pub fn norm2(&self) -> Formal<F> {
        dot_product(self, self)
    }

    /// Return a string containing 3 the `rust_code` of all the `Formal` of `self`.
    pub fn rust_code(&self, vec_name: String, nb_var: usize) -> String {
        format!(
            "{}\n {}\n {}",
            self.x.rust_code(format!("{}_x", vec_name.clone()), nb_var),
            self.y.rust_code(format!("{}_y", vec_name.clone()), nb_var),
            self.z.rust_code(format!("{}_z", vec_name.clone()), nb_var)
        )
    }

    /// Return the `FormalVector` whose coordonates are the derivatives of the coordonates of
    /// `self` with respect to the variable `wrp`
    pub fn differentiate(&self, wrp: usize) -> FormalVector<F> {
        FormalVector {
            x: self.x.derivative(wrp),
            y: self.y.derivative(wrp),
            z: self.z.derivative(wrp),
        }
    }
}

/// Returns a `Formal` representing the argument of the complex number b + ai
pub fn atan2<F: Float>(a: Formal<F>, b: Formal<F>) -> Formal<F> {
    Formal(Rc::new(FormalEnum::Atan2(a, b)))
}

/// Returns a `FormalVector` representing the vector product of `a` and `b`
pub fn vector_product<F: Float>(a: &FormalVector<F>, b: &FormalVector<F>) -> FormalVector<F> {
    FormalVector {
        x: a.y.clone() * b.z.clone() - a.z.clone() * b.y.clone(),
        y: a.z.clone() * b.x.clone() - a.x.clone() * b.z.clone(),
        z: a.x.clone() * b.y.clone() - a.y.clone() * b.x.clone(),
    }
}

/// Returns a `Formal` representing the dot product of `a` and `b`
pub fn dot_product<F: Float>(a: &FormalVector<F>, b: &FormalVector<F>) -> Formal<F> {
    a.x.clone() * b.x.clone() + a.y.clone() * b.y.clone() + a.z.clone() * b.z.clone()
}

///Return the angle between `a` and `b` with normalizing vector `axe`
pub fn angle<F: Float>(
    a: &FormalVector<F>,
    b: &FormalVector<F>,
    axe: &FormalVector<F>,
) -> Formal<F> {
    //atan2(sin, cos)
    atan2(dot_product(&vector_product(b, a), axe), dot_product(a, b))
}

impl<F: Float> std::ops::Sub<FormalPoint<F>> for FormalPoint<F> {
    type Output = FormalVector<F>;
    fn sub(self, b: FormalPoint<F>) -> Self::Output {
        FormalVector {
            x: self.x - b.x,
            y: self.y - b.y,
            z: self.z - b.z,
        }
    }
}

impl<F: Float> std::ops::Mul<FormalVector<F>> for Formal<F> {
    type Output = FormalVector<F>;
    fn mul(self, b: FormalVector<F>) -> Self::Output {
        FormalVector {
            x: b.x * self.clone(),
            y: b.y * self.clone(),
            z: b.z * self.clone(),
        }
    }
}

impl<F: Float> std::ops::Sub<FormalVector<F>> for FormalVector<F> {
    type Output = FormalVector<F>;
    fn sub(self, b: FormalVector<F>) -> Self::Output {
        FormalVector {
            x: self.x - b.x,
            y: self.y - b.y,
            z: self.z - b.z,
        }
    }
}

impl<F: Float> std::ops::Add<FormalVector<F>> for FormalVector<F> {
    type Output = FormalVector<F>;
    fn add(self, b: FormalVector<F>) -> Self::Output {
        FormalVector {
            x: self.x + b.x,
            y: self.y + b.y,
            z: self.z + b.z,
        }
    }
}

impl<F: Float> std::ops::Mul<Formal<F>> for FormalVector<F> {
    type Output = FormalVector<F>;
    fn mul(self, b: Formal<F>) -> Self::Output {
        FormalVector {
            x: self.x * b.clone(),
            y: self.y * b.clone(),
            z: self.z * b.clone(),
        }
    }
}

impl<F: Float> std::ops::Div<Formal<F>> for FormalVector<F> {
    type Output = FormalVector<F>;
    fn div(self, b: Formal<F>) -> Self::Output {
        FormalVector {
            x: self.x / b.clone(),
            y: self.y / b.clone(),
            z: self.z / b.clone(),
        }
    }
}

///Return the middle of the segment [`a`, `b`]
pub fn middle<F: Float>(a: &FormalPoint<F>, b: &FormalPoint<F>, lambda: F) -> FormalPoint<F> {
    FormalPoint {
        x: (a.x.clone() * lambda + b.x.clone() * (F::one() - lambda)),
        y: (a.y.clone() * lambda + b.y.clone() * (F::one() - lambda)),
        z: (a.z.clone() * lambda + b.z.clone() * (F::one() - lambda)),
    }
}
