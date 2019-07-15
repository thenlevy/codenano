extern crate serde;
extern crate num_traits;
use num_traits::Float;
use serde::{Serialize, Deserialize};

/// Represents 3D coordinates of the point of a finite element system
#[derive(Debug, Clone, Copy, Serialize, Deserialize)]
#[repr(C)]
pub struct Point<F: Float> {
    /// x coordinate
    pub x: F,
    /// y coordinate
    pub y: F,
    /// z coordinate
    pub z: F,
}

/// Represents the difference between two `Point`s
#[derive(Debug, Clone, Copy, Serialize, Deserialize)]
#[repr(C)]
pub struct Vector<F: Float> {
    /// x coordinate
    pub x: F,
    /// y coordinate
    pub y: F,
    /// z coordinate
    pub z: F,
}

impl<F: Float> std::ops::Index<usize> for Vector<F> {
    type Output = F;
    fn index(&self, i: usize) -> &F {
        unsafe { &*(self as *const Vector<F> as *const [F; 3]) }.index(i)
    }
}

impl<F: Float> std::ops::IndexMut<usize> for Vector<F> {
    fn index_mut(&mut self, i: usize) -> &mut F {
        unsafe { &mut *(self as *mut Vector<F> as *mut [F; 3]) }.index_mut(i)
    }
}

impl<F: Float> Vector<F> {
    /// Returns the Euclidian norm of `self`.
    pub fn norm(&self) -> F {
        self.norm2().sqrt()
    }

    /// Returns the square of the Euclidian norm of `self`.
    pub fn norm2(&self) -> F {
        self.x * self.x + self.y * self.y + self.z * self.z
    }
}

impl<F: Float> std::ops::Sub<Point<F>> for Point<F> {
    type Output = Vector<F>;
    fn sub(self, b: Point<F>) -> Self::Output {
        Vector {
            x: self.x - b.x,
            y: self.y - b.y,
            z: self.z - b.z,
        }
    }
}

impl<F: Float> std::ops::Add<Vector<F>> for Point<F> {
    type Output = Point<F>;
    fn add(self, b: Vector<F>) -> Self::Output {
        Point {
            x: self.x + b.x,
            y: self.y + b.y,
            z: self.z + b.z,
        }
    }
}
impl<F: Float> std::ops::AddAssign<Vector<F>> for Point<F> {
    fn add_assign(&mut self, b: Vector<F>) {
        self.x = b.x + self.x;
        self.y = b.y + self.y;
        self.z = b.z + self.z;
    }
}

impl<F: Float> std::ops::Sub<Vector<F>> for Vector<F> {
    type Output = Vector<F>;
    fn sub(self, b: Vector<F>) -> Self::Output {
        Vector {
            x: self.x - b.x,
            y: self.y - b.y,
            z: self.z - b.z,
        }
    }
}

impl<F: Float> std::ops::Neg for Vector<F> {
    type Output = Vector<F>;
    fn neg(self) -> Self::Output {
        Vector {
            x: -self.x,
            y: -self.y,
            z: -self.z,
        }
    }
}

impl<F: Float> std::ops::Add<Vector<F>> for Vector<F> {
    type Output = Vector<F>;
    fn add(self, b: Vector<F>) -> Self::Output {
        Vector {
            x: self.x + b.x,
            y: self.y + b.y,
            z: self.z + b.z,
        }
    }
}

impl<F: Float> std::ops::SubAssign<Vector<F>> for Vector<F> {
    fn sub_assign(&mut self, b: Vector<F>) {
        self.x = b.x - self.x;
        self.y = b.y - self.y;
        self.z = b.z - self.z;
    }
}

impl<F: Float> std::ops::AddAssign<Vector<F>> for Vector<F> {
    fn add_assign(&mut self, b: Vector<F>) {
        self.x = b.x + self.x;
        self.y = b.y + self.y;
        self.z = b.z + self.z;
    }
}

impl<F: Float> std::ops::Mul<Vector<F>> for f32 {
    type Output = Vector<F>;
    fn mul(self, b: Vector<F>) -> Self::Output {
        Vector {
            x: b.x * F::from(self).unwrap(),
            y: b.y * F::from(self).unwrap(),
            z: b.z * F::from(self).unwrap(),
        }
    }
}

impl<F: Float> std::ops::Mul<Vector<F>> for f64 {
    type Output = Vector<F>;
    fn mul(self, b: Vector<F>) -> Self::Output {
        Vector {
            x: b.x * F::from(self).unwrap(),
            y: b.y * F::from(self).unwrap(),
            z: b.z * F::from(self).unwrap(),
        }
    }
}

impl<F: Float> std::ops::Mul<F> for Vector<F> {
    type Output = Vector<F>;
    fn mul(self, b: F) -> Self::Output {
        Vector {
            x: self.x * b,
            y: self.y * b,
            z: self.z * b,
        }
    }
}

impl<F: Float> std::ops::Div<F> for Vector<F> {
    type Output = Vector<F>;
    fn div(self, b: F) -> Self::Output {
        Vector {
            x: self.x / b,
            y: self.y / b,
            z: self.z / b,
        }
    }
}
