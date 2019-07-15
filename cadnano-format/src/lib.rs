//! Converter from the CaDNAno format to strands, and back.
extern crate palette;
extern crate serde;
extern crate serde_json;
#[macro_use]
extern crate serde_derive;

use palette::{Hsl, Srgb};
use std::collections::HashMap;
use std::collections::HashSet;
mod cadnano;
pub use cadnano::*;

#[derive(Debug)]
pub enum Error {
    IO(std::io::Error),
    Json(serde_json::Error),
}

impl std::convert::From<std::io::Error> for Error {
    fn from(e: std::io::Error) -> Self {
        Error::IO(e)
    }
}

impl std::convert::From<serde_json::Error> for Error {
    fn from(e: serde_json::Error) -> Self {
        Error::Json(e)
    }
}

pub fn color_rgb(y: usize, x: usize) -> Srgb {
    Hsl::new(((y * 31 + x * 3) % 360) as f32, 1., 0.4).into()
}

pub fn color(y: usize, x: usize) -> isize {
    let rgb = color_rgb(y, x);
    let (r, g, b) = rgb.into_components();
    let r = (r * 255.).round() as isize;
    let g = (g * 255.).round() as isize;
    let b = (b * 255.).round() as isize;
    (((r << 8) | g) << 8) | b
}

#[derive(Debug)]
pub struct Point {
    pub helix: isize,
    pub x: isize,
}

#[derive(Debug)]
pub struct Strand {
    pub path: Vec<Point>,
}

#[derive(Debug)]
pub struct Strands {
    pub scaffolds: Vec<Strand>,
    pub staples: Vec<Strand>,
    pub edits: Vec<(Point, isize)>,
}


pub enum Lattice {
    Square,
    Hexagonal,
}

impl Cadnano {

    fn follow_scaffold(
        &self,
        points: &mut HashSet<(isize, isize)>,
        nums: &HashMap<isize, usize>,
        helix0: isize,
        x0: isize,
    ) -> Strand {
        let mut path = Vec::new();
        let (mut helix, mut x) = (helix0, x0);
        // Follow backwards.
        while helix != -1 {
            let (a, b, _, _) = self.vstrands[*nums.get(&helix).unwrap() as usize].scaf[x as usize];
            let n = path.len();
            if n < 2 {
                path.push(Point { helix, x });
            } else {
                if path[n-1].helix == path[n-2].helix && path[n-1].helix == helix {
                    path.last_mut().unwrap().x = x
                } else {
                    path.push(Point { helix, x });
                }
            }
            points.remove(&(helix, x));
            helix = a;
            x = b;
        }
        path.reverse();
        path.pop();
        println!("scaffold reversed: {:?}", path);
        helix = helix0;
        x = x0;
        while helix != -1 {
            let (_, _, c, d) = self.vstrands[*nums.get(&helix).unwrap() as usize].scaf[x as usize];
            let n = path.len();
            if n < 2 {
                path.push(Point { helix, x });
            } else {
                if path[n-1].helix == path[n-2].helix && path[n-1].helix == helix {
                    path.last_mut().unwrap().x = x
                } else {
                    path.push(Point { helix, x });
                }
            }
            points.remove(&(helix, x));
            helix = c;
            x = d;
        }
        Strand {
            path
        }
    }

    fn follow_staple(
        &self,
        points: &mut HashSet<(isize, isize)>,
        nums: &HashMap<isize, usize>,
        helix0: isize,
        x0: isize,
    ) -> Strand {
        let mut path = Vec::new();
        let (mut helix, mut x) = (helix0, x0);
        // Follow backwards.
        while helix != -1 {
            let (a, b, _, _) = self.vstrands[*nums.get(&helix).unwrap() as usize].stap[x as usize];
            let n = path.len();
            if n < 2 {
                path.push(Point { helix, x });
            } else {
                if path[n-1].helix == path[n-2].helix && path[n-1].helix == helix {
                    path.last_mut().unwrap().x = x
                } else {
                    path.push(Point { helix, x });
                }
            }
            points.remove(&(helix, x));
            helix = a;
            x = b;
        }
        println!("reversed staple: {:?}", path);
        path.reverse();
        path.pop();
        helix = helix0;
        x = x0;
        while helix != -1 {
            let (_, _, c, d) = self.vstrands[*nums.get(&helix).unwrap() as usize].stap[x as usize];
            let n = path.len();
            if n < 2 {
                path.push(Point { helix, x });
            } else {
                if path[n-1].helix == path[n-2].helix && path[n-1].helix == helix {
                    path.last_mut().unwrap().x = x
                } else {
                    path.push(Point { helix, x });
                }
            }
            points.remove(&(helix, x));
            helix = c;
            x = d;
        }
        Strand {
            path
        }
    }

    pub fn to_strands(&self) -> Strands {
        let mut scaf_points = HashSet::new();
        let mut stap_points = HashSet::new();
        let mut nums = HashMap::new();
        for (vs, vstrand) in self.vstrands.iter().enumerate() {
            nums.insert(vstrand.num, vs);
            for (x, st) in vstrand.scaf.iter().enumerate() {
                if *st != (-1, -1, -1, -1) {
                    scaf_points.insert((vstrand.num, x as isize));
                }
            }
            for (x, st) in vstrand.stap.iter().enumerate() {
                if *st != (-1, -1, -1, -1) {
                    stap_points.insert((vstrand.num, x as isize));
                }
            }
        }
        let mut scaffolds = Vec::new();
        loop {
            let (num, x) = {
                let mut it = scaf_points.iter();
                if let Some(&(num, x)) = it.next() {
                    (num, x)
                } else {
                    break
                }
            };
            scaffolds.push(self.follow_scaffold(&mut scaf_points, &nums, num, x))
        }
        let mut staples = Vec::new();
        loop {
            let (num, x) = {
                let mut it = stap_points.iter();
                if let Some(&(num, x)) = it.next() {
                    (num, x)
                } else {
                    break
                }
            };
            staples.push(self.follow_staple(&mut stap_points, &nums, num, x))
        }
        let mut edits = Vec::new();
        for (h, vs) in self.vstrands.iter().enumerate() {
            for &x in vs.skip.iter().chain(vs.loop_.iter()) {
                if x != 0 {
                    edits.push((
                        Point { helix: h as isize, x: x as isize },
                        x
                    ))
                }
            }
        }
        Strands {
            scaffolds,
            staples,
            edits,
        }
    }

    pub fn from_strands(
        name: String,
        lattice: Lattice,
        scaffolds: &[Strand],
        staples: &[Strand],
        edits: &[(Point, isize)],
    ) -> Cadnano {
        let ref p0 = scaffolds[0].path[0];
        let (min_x, max_x, min_y, max_y) = scaffolds
            .iter().flat_map(|s| s.path.iter())
            .chain(staples.iter().flat_map(|s| s.path.iter()))
            .fold(
                (p0.x, p0.x, p0.helix, p0.helix),
                |(min_x, max_x, min_y, max_y), p| {
                    (
                        std::cmp::min(min_x, p.x),
                        std::cmp::max(max_x, p.x),
                        std::cmp::min(min_y, p.helix),
                        std::cmp::max(max_y, p.helix),
                    )
                },
            );
        let min_x = min_x;
        let columns = (max_x - min_x + 1) as usize;
        let mut vstrands = Vec::new();

        // Now convert that to VStrand.
        let columns = match lattice {
            Lattice::Square => {
                let mut cols = (columns / 32) * 32;
                while cols % 21 == 0 || cols < columns {
                    cols += 32
                }
                cols
            }
            Lattice::Hexagonal => {
                let mut cols = (columns / 21) * 21;
                while cols % 32 == 0 || cols < columns {
                    cols += 21
                }
                cols
            }
        };
        for y in min_y..=max_y {
            // (num, (h, row)) in helices.iter().zip(events_.iter()).enumerate() {
            let num = y - min_y;
            let stap: Vec<(isize, isize, isize, isize)> = vec![(-1, -1, -1, -1); columns];
            let scaf = stap.clone();

            vstrands.push(VStrand {
                stap_colors: vec![],
                num,
                scaf_loop: vec![],
                stap,
                skip: vec![0; columns as usize],
                scaf,
                stap_loop: vec![],
                col: 1,
                loop_: vec![0; columns as usize],
                row: num as isize + 1,
            })
        }

        for (is_scaffold, path) in
            scaffolds.iter().map(|x| (true, x))
            .chain(staples.iter().map(|x| (false, x)))
        {
            let (mut x0, mut y0): (isize, isize) = (-1, -1);
            let it0 = path.path.iter().map(|p| Point {
                helix: p.helix - min_y,
                x: p.x - min_x,
            });
            let mut it1 = path.path.iter().map(|p| Point {
                helix: p.helix - min_y,
                x: p.x - min_x,
            });
            it1.next();
            for (p0, p1) in it0.zip(it1) {
                if p0.helix == p1.helix {
                    if p0.x < p1.x {
                        for x in p0.x..p1.x {
                            if is_scaffold {
                                vstrands[p0.helix as usize].scaf[x as usize] =
                                    (y0, x0, p0.helix, x + 1);
                            } else {
                                vstrands[p0.helix as usize].stap[x as usize] =
                                    (y0, x0, p0.helix, x + 1);
                            }
                            y0 = p0.helix;
                            x0 = x;
                        }
                        if is_scaffold {
                            vstrands[p1.helix as usize].scaf[p1.x as usize] = (y0, x0, -1, -1);
                        } else {
                            vstrands[p1.helix as usize].stap[p1.x as usize] = (y0, x0, -1, -1);
                        }
                    } else {
                        for x in ((p1.x + 1)..=p0.x).rev() {
                            if is_scaffold {
                                vstrands[p0.helix as usize].scaf[x as usize] =
                                    (y0, x0, p1.helix, x - 1);
                            } else {
                                vstrands[p0.helix as usize].stap[x as usize] =
                                    (y0, x0, p1.helix, x - 1);
                            }
                            y0 = p0.helix;
                            x0 = x;
                        }
                        if is_scaffold {
                            vstrands[p1.helix as usize].scaf[p1.x as usize] = (y0, x0, -1, -1);
                        } else {
                            vstrands[p1.helix as usize].stap[p1.x as usize] = (y0, x0, -1, -1);
                        }
                    }
                } else {
                    // Helix change.
                    if is_scaffold {
                        vstrands[p0.helix as usize].scaf[p0.x as usize] = (y0, x0, p1.helix, p1.x);
                    } else {
                        vstrands[p0.helix as usize].stap[p0.x as usize] = (y0, x0, p1.helix, p1.x);
                    }
                    x0 = p0.x;
                    y0 = p0.helix;
                }
            }
        }

        for &(ref p, ref n) in edits.iter() {
            println!("{:?}", p);
            if *n > 0 {
                vstrands[p.helix as usize].loop_[p.x as usize] = *n
            } else if *n < 0 {
                vstrands[p.helix as usize].skip[p.x as usize] = *n
            }
        }
        Cadnano { name, vstrands }
    }
}

#[test]
fn test_cad() {
    let scaf = vec![Strand {
        path: vec![
            Point { x: 0, helix: 0 },
            Point { x: 20, helix: 0 },
            Point { x: 20, helix: 1 },
            Point { x: 0, helix: 1 },
        ],
    }];
    let staples = vec![Strand {
        path: vec![
            Point { x: 20, helix: 0 },
            Point { x: 0, helix: 0 },
            Point { x: 0, helix: 1 },
            Point { x: 20, helix: 1 },
        ],
    }];
    let cad = Cadnano::from_strands("blabla".to_string(), Lattice::Square, &scaf, &staples, &[(Point { x: 4, helix: 0 }, 1), (Point { x: 4, helix: 1 }, -1)]);
    cad.to_file("/tmp/test.json").unwrap();
    println!("{:?}", cad.to_strands());
}
