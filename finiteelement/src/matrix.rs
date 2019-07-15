use crate::Float;
use std::collections::HashMap;
use std::collections::hash_map;
use std::fmt;

const EPSILON: f32 = 1e-10;
const MAX_ITER: usize = 10000;

/// A data structure to represent sparse matrix.
///
/// A sparse matrix is represented as a `Vec` of rows, where each row is a `HashMap` whose keys
/// space is the set of columns. If a key does not exist in the HashMap but is smaller that the
/// number of column the corresponding value is 0. Attempt to access an out of bound value result
/// in a `panic`.
/// # Example
/// ```
/// extern crate finiteelement;
/// use finiteelement::Sparse;
/// let mut sprs = Sparse::new(3, 3);
/// sprs[1][2] = 3.;
/// assert_eq!(sprs[1][2], 3.);
/// assert_eq!(sprs[2][2], 0.);
/// let access_out_of_bound = std::panic::catch_unwind(|| sprs[1][3]);
/// assert!(access_out_of_bound.is_err());
/// ```
pub struct Sparse<F: Float> {
    p: Vec<SparseVec<F>>,
    nb_rows: usize,
    nb_columns: usize,
}

#[derive(Clone)]
pub struct SparseVec<F: Float> {
    internal: HashMap<usize, F>,
    zero: F,
    size: usize
}


impl<A: Float + Clone> Sparse<A> {
    /// Returns the number of column of `self`.
    pub fn nb_columns(&self) -> usize {
        self.nb_columns
    }

    /// Returns the number of rows of `self`.
    pub fn nb_rows(&self) -> usize {
        self.nb_rows
    }
    
    /// perform y <- y + self*x where * is a matrix/vector product
    pub fn mul_vec0(&self, x: &Vec<A>, y: &mut Vec<A>) {
        // We assume that self is sparse and x is not
        for row in 0..self.nb_rows() {
            for (col, val) in self.p[row].iter() {
                y[row] = y[row] + *val * x[*col]
            }
        }
    }

    /// perform x <- x + self^T * y where self^T is the transpose of self
    /// and * is a matrix/vector prouct
    pub fn mul_vec1(&self, x: &mut Vec<A>, y: & Vec<A>) {
        //We assume that self is sparse and y is not
        //Because of how we store self, we actually compute x^T * self
        for row in 0..self.nb_rows() {
            for (col, val) in self.p[row].iter() {
                x[*col] = x[*col] + *val * y[row]
            }
        }
    }

    /// Returns a `nb_rows` x `nb_columns` `Sparse` full of zeroes.
    pub fn new(nb_rows: usize, nb_columns: usize) -> Self {
        Sparse {
            p: vec![SparseVec::new(nb_columns); nb_rows],
            nb_rows,
            nb_columns,
        }
    }

    /// Set `self` to the null matrix, preserve the dimension.
    pub fn reset(&mut self) {
        for x in self.p.iter_mut() {
            *x = SparseVec::new(self.nb_columns)
        }
    }

    /// Returns a `String` representing `self`.
    pub fn pretty_print(&self) -> String {
        (0..self.nb_rows()).map(|i| {
            format!("[ {} ]", 
            (0..self.nb_columns()).map(|j| {
                format!("{:.3}", self[i][j].to_f64().unwrap())
            }).collect::<Vec<String>>().join(", "))
        }).collect::<Vec<String>>().join("\n")
    }
}

impl<A: Clone + Float> fmt::Display for Sparse<A> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.pretty_print())
    }
}

impl<A: Float> SparseVec<A> {
    pub fn new(size: usize) -> SparseVec<A> {
        SparseVec {
            internal: HashMap::new(),
            zero: A::zero(),
            size
        }
    }
    pub fn iter_mut(&mut self) -> hash_map::IterMut<usize, A> {
        self.internal.iter_mut()
    }
    pub fn iter(&self) -> hash_map::Iter<usize, A> {
        self.internal.iter()
    }

    pub fn max_abs(&self) -> A {
        let mut ret = A::zero();
        for x in self.internal.values().map(|f| f.abs()) {
            if x > ret {
                ret = x;
            }
        }
        ret
    }
}

impl<A: Float> std::ops::Index<usize> for Sparse<A> {
    type Output = SparseVec<A>;
    fn index(&self, row: usize) -> &Self::Output {
        &self.p[row]
    }
}

impl<A: Float> std::ops::IndexMut<usize> for Sparse<A> {
    fn index_mut(&mut self, row: usize) -> &mut Self::Output {
        &mut self.p[row]
    }
}

impl<A: Float> std::ops::Index<(usize, usize)> for Sparse<A> {
    type Output = A;
    fn index(&self, (row, col): (usize, usize)) -> &Self::Output {
        &self.p[row][col]
    }
}

impl<A: Float> std::ops::IndexMut<(usize, usize)> for Sparse<A> {
    fn index_mut(&mut self, (row, col): (usize, usize)) -> &mut Self::Output {
        if col >= self.nb_columns {
            panic!("accessing  {} column in sparse of dimension {}x{}", col, self.nb_rows, self.nb_columns) };
        &mut self.p[row][col]
    }

}

impl<A: Float> std::ops::Index<usize> for SparseVec<A> {
    type Output = A;
    fn index(&self, col: usize) -> &Self::Output {
        if col >= self.size {
            panic!("Out of bound: Attempt to access column {} of a sparse matrix that has {} columns", col, self.size) 
        }
        &self.internal.get(&col).unwrap_or(&self.zero)
    }
}

impl<A: Float> std::ops::IndexMut<usize> for SparseVec<A> {
    fn index_mut(&mut self, col: usize) -> &mut Self::Output {
        if col >= self.size {
            panic!("Out of bound: Attempt to access column {} of a sparse matrix that has {} columns", col, self.size) 
        }
        self.internal.entry(col).or_insert(A::zero())
    }
}

fn norm2<F: Float>(x: &Vec<F>) -> F {
    let mut ret = F::zero();
    for val in x {
        ret = ret + *val * *val;
    }
    F::from(ret.powf(F::from(0.5).unwrap())).unwrap()
}

fn rescale<F: Float>(x: &mut Vec<F>, scal: F) {
    for val in x {
        *val = *val * scal
    }
}

pub fn lsqr<F: Float>(mat: &Sparse<F>, rhs_vec: &mut Vec<F>, rcond: F) -> Vec<F> {
    let f_epsilon = F::from(EPSILON).unwrap();
    let m = mat.nb_columns();

    let mut cs2 = -F::one();
    let mut sn2 = F::zero();
    let mut zeta = F::zero();
    let mut zetabar: F;
    let mut alpha: F;
    let mut beta: F;
    let mut rho: F;
    let mut cs: F;
    let mut sn: F;
    let mut theta: F;
    let mut delta: F;
    let mut gammabar: F;
    let mut gamma: F;
    let mut tau: F;
    let mut xxnorm = F::zero();
    let mut ddnorm = F::zero();
    let mut bbnorm = F::zero();

    let mut stop_crit = vec![F::zero(); 3];

    beta = norm2(rhs_vec);
    rescale(rhs_vec, F::one()/beta);

    let mut sol_vec = vec![F::zero(); m];
    let mut sol_norm: F;
    let mut std_err_vec = vec![F::zero(); m];
    let mut bidiag_wrk_vec = vec![F::zero(); m];
    mat.mul_vec1(&mut bidiag_wrk_vec, rhs_vec);
    alpha = norm2(&bidiag_wrk_vec);
    rescale(&mut bidiag_wrk_vec, F::one()/alpha);

    let mut srch_dir_vec = bidiag_wrk_vec.clone();
    let mut mat_resid_norm: F;
    let mut resid_norm = beta;
    let bnorm = beta;
    let mut frob_mat_norm: F;
    let mut mat_cond_num: F;

    let mut rhobar = alpha;
    let mut phibar = beta;
    let mut phi;

    let mut nb_iter = 0;

    loop {
        nb_iter += 1;

        rescale(rhs_vec, -alpha);
        mat.mul_vec0(& bidiag_wrk_vec, rhs_vec);
        beta  = norm2(rhs_vec);
        bbnorm = bbnorm + alpha * alpha + beta * beta;
        rescale(rhs_vec, F::one()/beta);

        rescale(&mut bidiag_wrk_vec, -beta);
        mat.mul_vec1(&mut bidiag_wrk_vec, rhs_vec);
        alpha = norm2(&bidiag_wrk_vec);
        rescale(&mut bidiag_wrk_vec, F::one()/alpha);

        /*
        cs1 = 1.;
        sn1 = 0.;
        phibar = phibar;
        psi = 0.
        */
        rho = (rhobar * rhobar + beta * beta).powf(F::from(0.5).unwrap());
        cs = rhobar / rho;
        sn = beta / rho;

        theta = sn * alpha;
        rhobar = -cs * alpha;
        phi = cs * phibar;
        phibar = sn * phibar;
        tau = sn * phi;
        
        //Update solution and direction
        for i in 0..m {
            sol_vec[i] = sol_vec[i] + (phi / rho) * srch_dir_vec[i];
            let to_add = (srch_dir_vec[i] / rho)  * (srch_dir_vec[i] / rho);
            std_err_vec[i] = std_err_vec[i] + to_add;
            ddnorm = ddnorm + to_add;
            
            srch_dir_vec[i] = bidiag_wrk_vec[i] - (theta / rho) * srch_dir_vec[i];
        }

        delta = sn2 * rho;
        gammabar = -cs2 * rho;
        zetabar = (phi - delta * zeta) / gammabar;

        sol_norm = (xxnorm + zetabar).powf(F::from(0.5).unwrap());

        gamma = (gammabar * gammabar + theta * theta).powf(F::from(0.5).unwrap());
        cs2 = gammabar / gamma;
        sn2 = theta / gamma;
        zeta = (phi - delta * zeta) / gamma;

        xxnorm = xxnorm + zeta * zeta;

        frob_mat_norm = bbnorm.powf(F::from(0.5).unwrap());
        mat_cond_num = frob_mat_norm * ddnorm.powf(F::from(0.5).unwrap());

        //res += psi * psi;
        resid_norm = resid_norm + phibar;

        mat_resid_norm = alpha * tau.abs();

        stop_crit[0] = resid_norm/bnorm;

        stop_crit[1] = if resid_norm > F::zero() {
            mat_resid_norm / (frob_mat_norm * resid_norm)
        } else { F::zero() };

        stop_crit[2] = F::one() / mat_cond_num;

        let resid_tol = f_epsilon + f_epsilon * frob_mat_norm * sol_norm / bnorm;

        if nb_iter > MAX_ITER {
            println!("Warning: too many iteration");
            return sol_vec;
        }

        if stop_crit[2] < f_epsilon || stop_crit[1] < f_epsilon || stop_crit[0] < resid_tol {
            println!("Warning lack of precisison");
            return sol_vec;
        }

        if stop_crit[2] < rcond {
            return sol_vec;
        }
    }
}

#[test]
fn test_mat_vec() {
    let mut diag: Sparse<f32> = Sparse::new(3, 3);
    diag[(0, 0)] += 5.;
    diag[(0, 0)] -= 2.;
    diag[(1, 0)] = 2.;
    diag[(1, 1)] += 1.;
    diag[(2, 2)] = 1.;
    let mut y = vec![0.; 3];
    let mut x = vec![2., -2., 1.];

    diag.mul_vec0(&x, &mut y);
    assert_eq!((y[0], y[1], y[2]),  (6., 2., 1.));

    let mut sprs = Sparse::new(3, 3);
    sprs[(1,2)] = 3.;
    assert_eq!(sprs[(1,2)], 3.);
    assert_eq!(sprs[(2,2)], 0.);

    sprs[(0, 0)] = 1.;
    sprs[(0, 1)] = 3.;
    sprs[(0, 2)] = 2.;
    sprs[(1, 0)] = 3.;
    sprs[(1,1)] = 5.;
    sprs[(1,2)] = 4.;
    sprs[(2, 0)] = -2.;
    sprs[(2, 1)] = 6.;
    sprs[(2, 2)] = 3.;

    x = vec![0.; 3];
    y = vec![-15., 8., 2.];
    sprs.mul_vec1(&mut x, & y);
    assert_eq!((x[0], x[1], x[2]), (5., 7., 8.));
}


#[test]
fn test_sparse() {
    let mut sprs = Sparse::new(3, 3);
    sprs[(1,2)] = 3.;
    assert_eq!(sprs[(1,2)], 3.);
    assert_eq!(sprs[(2,2)], 0.);

    sprs[(0, 0)] = 1.;
    sprs[(0, 1)] = 3.;
    sprs[(0, 2)] = -2.;
    sprs[(1, 0)] = 3.;
    sprs[(1,1)] = 5.;
    sprs[(1,2)] = 6.;
    sprs[(2, 0)] = 2.;
    sprs[(2, 1)] = 4.;
    sprs[(2, 2)] = 3.;
    let mut diag: Sparse<f32> = Sparse::new(3, 3);
    diag[(0, 0)] += 5.;
    diag[(0, 0)] -= 2.;
    diag[(1, 0)] = 2.;
    diag[(1, 1)] += 1.;
    diag[(2, 2)] = 1.;
    let mut v2 = vec![6., 2., 1.];
    let v = lsqr(&diag, &mut v2, 1e-9);
    let solved = v[0] - 2. < 1e-3 && v[1] - -2. < 1e-3 && v[2] - 1. < 1e-3;
    assert!(solved);
}

