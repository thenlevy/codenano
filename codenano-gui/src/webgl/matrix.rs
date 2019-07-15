use rand::Rng;
use finiteelement::{Point};

#[derive(Debug, Copy, Clone)]
pub struct Matrix(pub [f32; 16]);
#[derive(Debug, Copy, Clone)]
pub struct Vector(pub [f32; 4]);

impl std::convert::From<Point<f32>> for Vector {
    fn from(v: Point<f32>) -> Self {
        Vector([
            v.x,
            v.y,
            v.z,
            1.
        ])
    }
}

impl std::convert::From<Point<f64>> for Vector {
    fn from(v: Point<f64>) -> Self {
        Vector([
            v.x as f32,
            v.y as f32,
            v.z as f32,
            1.
        ])
    }
}

impl Vector {
    pub fn vect_product(&self, b: &Self) -> Self {
        Vector([
            self.0[0]*b.0[1] - self.0[1]*b.0[0],
            self.0[1]*b.0[2] - self.0[2]*b.0[1],
            self.0[2]*b.0[0] - self.0[0]*b.0[2],
            1.,
        ])
    }
    pub fn dot_product(&self, b: &Self) -> f32 {
        self.0[0] * b.0[0]
            + self.0[1] * b.0[1]
            + self.0[2] * b.0[2]
    }
    pub fn norm(&self) -> f32 {
        (self.0[0]*self.0[0]
            +self.0[1]*self.0[1]
            +self.0[2]*self.0[2]
            +self.0[3]*self.0[3]).sqrt()
    }
    pub fn random() -> Self {
        let mut rng = rand::thread_rng();
        let x = rng.gen();
        let y = rng.gen();
        let z = rng.gen();
        Vector([
            x,
            y,
            z,
            1.
        ])
    }
}


impl Matrix {
    pub fn id() -> Self {
        Matrix([
            1., 0., 0., 0.,
            0., 1., 0., 0.,
            0., 0., 1., 0.,
            0., 0., 0., 1.
        ])
    }
    pub fn rotate_x(a: f32) -> Self {
        let cosa = a.cos();
        let sina = a.sin();
        Matrix([
            1., 0., 0., 0.,
            0., cosa, -sina, 0.,
            0., sina, cosa, 0.,
            0., 0., 0., 1.
        ])
    }

    pub fn rotate_y(a: f32) -> Self {
        let cosa = a.cos();
        let sina = a.sin();
        Matrix([
            cosa, 0., sina, 0.,
            0., 1., 0., 0.,
            -sina, 0., cosa, 0.,
            0., 0., 0., 1.
        ])
    }

    pub fn rotate_z(a: f32) -> Self {
        let cosa = a.cos();
        let sina = a.sin();
        Matrix([
            cosa, -sina, 0., 0.,
            sina, cosa, 0., 0.,
            0., 0., 1., 0.,
            0., 0., 0., 1.
        ])
    }

    pub fn rotate(x: f32, y: f32, z: f32, a: f32) -> Self {
        let cosa = a.cos();
        let sina = a.sin();
        Matrix([
            cosa + x*x*(1.-cosa), x*y*(1.-cosa) - z*sina, x*z*(1.-cosa) + y*sina, 0.,
            y*x*(1.-cosa) + z*sina, cosa + y*y*(1.-cosa), y*z*(1.-cosa) - x*sina, 0.,
            z*x*(1.-cosa) + y*sina, z*y*(1.-cosa) + x*sina, cosa + z*z*(1.-cosa), 0.,
            0., 0., 0., 1.,
        ])
    }

    pub fn translate(x: f32, y: f32, z: f32) -> Self {
        Matrix([
            1., 0., 0., 0.,
            0., 1., 0., 0.,
            0., 0., 1., 0.,
            x, y, z, 1.
        ])
    }

    pub fn scale(x: f32, y: f32, z: f32) -> Self {
        Matrix([
            x, 0., 0., 0.,
            0., y, 0., 0.,
            0., 0., z, 0.,
            0., 0., 0., 1.
        ])
    }
}

impl std::ops::Mul<Matrix> for Matrix {
    type Output = Matrix;
    fn mul(self, b: Matrix) -> Matrix {
        let mut result = [0.; 16];
        for i in 0..4 {
            for j in 0..4 {
                for k in 0..4 {
                    result[i*4 + j] += self.0[i * 4 + k] * b.0[k*4 + j];
                }
            }
        }
        Matrix(result)
    }
}

impl std::ops::MulAssign<Matrix> for Matrix {
    fn mul_assign(&mut self, b: Matrix) {
        *self = *self * b
    }
}

impl std::ops::Mul<Vector> for Matrix {
    type Output = Vector;
    fn mul(self, b: Vector) -> Vector {
        let mut result = [0.; 4];
        for i in 0..4 {
            for j in 0..4 {
                result[i] += self.0[i * 4 + j] * b.0[j];
            }
        }
        Vector(result)
    }
}

impl std::ops::Add<Vector> for Vector {
    type Output = Vector;
    fn add(self, b: Vector) -> Vector {
        Vector([
            self.0[0] + b.0[0],
            self.0[1] + b.0[1],
            self.0[2] + b.0[2],
            1.
        ])
    }
}

impl std::ops::Sub<Vector> for Vector {
    type Output = Vector;
    fn sub(self, b: Vector) -> Vector {
        Vector([
            self.0[0] - b.0[0],
            self.0[1] - b.0[1],
            self.0[2] - b.0[2],
            1.
        ])
    }
}

impl std::ops::Div<f32> for Vector {
    type Output = Vector;
    fn div(self, b: f32) -> Vector {
        Vector([
            self.0[0]/b,
            self.0[1]/b,
            self.0[2]/b,
            1.
        ])
    }
}

impl std::ops::Mul<f32> for Vector {
    type Output = Vector;
    fn mul(self, b: f32) -> Vector {
        Vector([
            self.0[0]*b,
            self.0[1]*b,
            self.0[2]*b,
            1.
        ])
    }
}

impl std::ops::Mul<Vector> for f32 {
    type Output = Vector;
    fn mul(self, b: Vector) -> Vector {
        Vector([
            b.0[0]*self,
            b.0[1]*self,
            b.0[2]*self,
            1.
        ])
    }
}
