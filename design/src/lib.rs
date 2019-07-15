#[macro_use]extern crate serde_derive;
extern crate serde;

mod themes;
use finiteelement::geometry::{Point};
use finiteelement::Float;
use std::collections::{HashMap, HashSet};
use std::f64::consts::PI;
use themes::themes;

#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct Points<F: Float> {
    pub steps: Vec<Vec<Point<F>>>,
    pub strands: Vec<Strand>,
    pub pairs: Vec<Option<usize>>,
}

#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct Strand {
    pub strand: Vec<usize>,
    pub color: u32,
}

pub const LEN_STACK: f64 = 5. / 100.;
pub const LEN_H_BOUND: f64 = 10. / 100.;
pub const ANGLE_AOB: f64 = 11. * PI / 9.;
pub const ANGLE_AOC2: f64 = 2. * PI / 10.5;
pub const CADNANO_HELIX_SIZE: f64 = LEN_H_BOUND * 2.2;
pub const AUTO_COLOR: u32 = 0xABCDABCD;

pub const M13_7249: &'static str = include_str!("m13");
pub const M13_594: &'static str = include_str!("m13_594");

#[derive(Copy, Clone)]
pub struct DNAConst {
    len_stack: f64,
    len_h_bound: f64,
    nb_base_per_turn: f64,
    angle_groove: f64,
}

impl DNAConst {
    pub fn default() -> Self {
        DNAConst {
            len_stack: LEN_STACK,
            len_h_bound: LEN_H_BOUND,
            nb_base_per_turn: 10.5,
            angle_groove: ANGLE_AOB
        }
    }

    pub fn angle_aob(&self) -> f64 {
        self.angle_groove
    }

    pub fn angle_aoc2(&self) -> f64 {
        2. * PI / self.nb_base_per_turn
    }

    pub fn set_bpp(&mut self, bpp: f64) {
        self.nb_base_per_turn = bpp
    }

    pub fn set_groove(&mut self, groove: f64) {
        self.angle_groove = groove
    }

    fn angle_boc2(&self) -> f64 { self.angle_aob() - self.angle_aoc2() }

    fn angle_aod2(&self) -> f64 { self.angle_aob() + self.angle_aoc2() }
    pub fn ab(&self) -> f64 {
        (2. - 2. * self.angle_aob().cos()).powf(0.5) * self.len_h_bound
    }
    pub fn bc2(&self) -> f64 { 
        (2. - 2. * self.angle_boc2().cos()).powf(0.5) * self.len_h_bound
    }
    pub fn bc(&self) -> f64 {
        (self.bc2() * self.bc2() + self.len_stack * self.len_stack).powf(0.5)
    }
    pub fn ad2(&self) -> f64 {
        (2. - 2. * self.angle_aod2().cos()).powf(0.5) * self.len_h_bound
    }
    pub fn ad(&self) -> f64 {
        (self.ad2() * self.ad2() + self.len_stack * self.len_stack).powf(0.5)
    }
    pub fn ac2(&self) -> f64 {
        (2. - 2. * self.angle_aoc2().cos()).powf(0.5) * self.len_h_bound
    }
    pub fn ac(&self) -> f64 {
        (self.ac2() * self.ac2() + self.len_stack * self.len_stack).powf(0.5)
    }

}



#[derive(Serialize, Deserialize)]
pub struct Helix {
    origin: Point<f64>,

    // aka angle on x axis
    roll: f64,

    //aka angle on y axis
    yaw: f64,

    //aka angle on z axis
    pitch: f64,

}

impl Helix {
    // Angle on the circle
    fn theta(&self, n: isize, b: bool, cst: &DNAConst) -> f64 {
        let shift = if b { cst.angle_aob() } else { 0. };
        n as f64 * cst.angle_aoc2() + shift + self.roll
    }

    fn ry(point: Point<f64>, theta: f64) -> Point<f64> {
        Point {
            x: point.x * theta.cos() + point.z * theta.sin(),
            y: point.y,
            z: point.x * -theta.sin() + point.z * theta.cos(),
        }
    }

    fn rz(point: Point<f64>, theta: f64) -> Point<f64> {
        Point {
            x: point.x * theta.cos() + point.y * -theta.sin(),
            y: point.x * theta.sin() + point.y * theta.cos(),
            z: point.z,
        }
    }

    // Position in space
    pub fn space_pos(&self, n: isize, b: bool, cst: &DNAConst) -> Point<f64> {
        let theta = self.theta(n, b, cst);
        let mut ret = Point {
            x: n as f64 * cst.len_stack,
            y: -theta.cos() * cst.len_h_bound,
            z: -theta.sin() * cst.len_h_bound,
        };
        ret = Helix::ry(ret, self.yaw);
        ret = Helix::rz(ret, self.pitch);
        ret.x += self.origin.x;
        ret.y += self.origin.y;
        ret.z += self.origin.z;
        ret
    }

    pub fn from_grid(h: isize, v: isize) -> Helix {
        Helix {
            origin: Point {
                x: 0.,
                y: h as f64 * CADNANO_HELIX_SIZE,
                z: v as f64 * CADNANO_HELIX_SIZE,
            },
            roll: 0.,
            pitch: 0.,
            yaw: 0.,
        }
    }
}


pub struct RandomBases{}

impl Iterator for RandomBases {
    type Item = char;
    fn next(&mut self) -> Option<Self::Item> {
        use rand::Rng;
        let mut rng = rand::thread_rng();
        let between = rand::distributions::Uniform::from(0..4);
        Some(match rng.sample(&between) {
            0 => 'A',
            1 => 'C',
            2 => 'G',
            _ => 'T',
        })
    }
}

impl RandomBases {
    pub fn new() -> Self {
        RandomBases {}
    }
}

pub struct DefaultFilling {}

impl Iterator for DefaultFilling {
    type Item = char;
    fn next(&mut self) -> Option<Self::Item> {
        Some('*')
    }
}

#[derive(Serialize, Deserialize)]
pub struct Nucleotide {
    pub id: usize,
    pub helix_num: usize,
    pub pos_on_helix: isize,
    pub anti_sens: bool,
    pub strand: usize,
    pub pos_on_strand: usize,
    pub on_jump: bool,
    pub base: char,
}

#[derive(Debug, Serialize, Deserialize)]
struct Result<T> {
    result: T,
    stderr: String,
}

pub struct Nanostructure {
    pub helices: Vec<Helix>,

    //Maps (helix num, n, b) to a nucleotide identifier
    pub nucl_id: HashMap<(usize, isize, bool), usize>,

    pub nucleotides: Vec<Nucleotide>,

    //Idexed by nucleotides identifier, posisiton of each nucleotide
    pub positions: Vec<Point<f64>>,

    //The list of covalent bonds between nucleotides
    pub strands: Vec<Strand>,

    //Maps a nulc_id to a strand_id
    nucl_to_strand: HashMap<usize, usize>,

    //The list of h-bonds between nucleotides
    h_bonds: HashSet<(usize, usize)>,

    scaffold: usize,

    colors_idx: usize,

    // maps a strand identifier to the name of a group
    strand_group: Vec<String>,

    pub cst: DNAConst
}

#[derive(Serialize, Deserialize)]
pub struct JSONNanostructure {
    pub helices: Vec<Helix>,

    //Maps (helix num, n, b) to a nucleotide identifier
    pub nucl_id: Vec<((usize, isize, bool), usize)>,

    pub nucleotides: Vec<Nucleotide>,

    //Idexed by nucleotides identifier, posisiton of each nucleotide
    pub positions: Vec<Point<f64>>,

    //The list of covalent bonds between nucleotides
    pub strands: Vec<Strand>,

    //Maps a nulc_id to a strand_id
    pub nucl_to_strand: Vec<(usize, usize)>,

    //The list of h-bonds between nucleotides
    pub h_bonds: Vec<(usize, usize)>,

    pub scaffold: usize,

    pub err: String,
}

#[derive(Serialize, Deserialize)]
pub struct Res {
    pub out: String,
    pub err: String,
}

impl JSONNanostructure {
    pub fn into_nanostructure(self) -> Nanostructure {
        Nanostructure {
            helices: self.helices,
            nucl_id: self.nucl_id.into_iter().collect(),
            nucleotides: self.nucleotides,
            positions: self.positions,
            strand_group: vec!["Default".to_string(); self.strands.len()],
            strands: self.strands,
            nucl_to_strand: self.nucl_to_strand.into_iter().collect(),
            h_bonds: self.h_bonds.into_iter().collect(),
            scaffold: self.scaffold,
            colors_idx: 0,
            cst: DNAConst::default()
        }
    }
}

impl Nanostructure {
    pub fn new() -> Self {
        Nanostructure {
            helices: Vec::new(),
            nucl_id: HashMap::new(),
            nucleotides: Vec::new(),
            positions: Vec::new(),
            strands: Vec::new(),
            nucl_to_strand: HashMap::new(),
            h_bonds: HashSet::new(),
            scaffold: 0,
            colors_idx: 0,
            strand_group: Vec::new(),
            cst: DNAConst::default()
        }
    }

    pub fn with_constant(cst: DNAConst) -> Self {
        Nanostructure {
            cst,
            .. Nanostructure::new()
        }
    }


    fn into_json(self) -> JSONNanostructure {
        JSONNanostructure {
            helices: self.helices,
            nucl_id: self.nucl_id.into_iter().collect(),
            nucleotides: self.nucleotides,
            positions: self.positions,
            strands: self.strands,
            nucl_to_strand: self.nucl_to_strand.into_iter().collect(),
            h_bonds: self.h_bonds.into_iter().collect(),
            scaffold: self.scaffold,
            err: String::new(),
        }
    }

    pub fn finish(mut self) {
        self.make_h_bonds();
        serde_json::to_writer(std::io::stdout(), &self.into_json()).unwrap()
    }

    pub fn add_grid_helix(&mut self, h: isize, v: isize) -> usize {
        self.helices.push(Helix::from_grid(h, v));
        self.helices.len() - 1
    }

    pub fn add_helix(&mut self, x: f64, y: f64, z: f64, roll: f64, pitch: f64, yaw: f64) -> usize {
        self.helices.push(Helix {
            origin: Point { x, y, z },
            roll,
            pitch,
            yaw,
        });
        self.helices.len() - 1
    }

    pub fn add_nucl(
        &mut self,
        helix_id: usize,
        n: isize,
        b: bool,
        strand: usize,
        pos: usize,
    ) -> usize {
        if self.nucl_id.contains_key(&(helix_id, n, b)) {
            self.nucl_id[&(helix_id, n, b)]
        } else {
            let new_nucl = self.helices[helix_id].space_pos(n, b, &self.cst);
            let nucl_id = self.positions.len();
            self.positions.push(new_nucl);
            self.nucleotides.push(Nucleotide {
                id: nucl_id,
                helix_num: helix_id,
                pos_on_helix: n,
                anti_sens: b,
                strand,
                pos_on_strand: pos,
                on_jump: false,
                base: '*',
            });
            self.nucl_id.insert((helix_id, n, b), nucl_id);
            nucl_id
        }
    }

    pub fn add_strand(&mut self, color: u32) -> usize {
        let strand_id = self.strands.len();
        self.strands.push(Strand {
            strand: Vec::new(),
            color: color,
        });
        self.strand_group.push("Default".to_string());
        strand_id
    }

    pub fn draw_strand(
        &mut self,
        helix_id: usize,
        anti_sens: bool,
        begin: isize,
        end: isize,
        color: u32,
    ) {
        let first = if begin < end { begin } else { end };
        let last = if begin > end { begin } else { end };
        for i in first..(last + 1) {
            if self.nucl_id.contains_key(&(helix_id, i, anti_sens)) {
                return;
            }
        }

        let color_strand = if color == AUTO_COLOR {
            let t = themes("".to_string());
            let c = t[self.colors_idx % t.len()];
            self.colors_idx += 1;
            c
        } else { color };


        let strand_id = self.add_strand(color_strand);

        let (mut i, j, step) = if anti_sens {
            (last, first, -1)
        } else {
            (first, last, 1)
        };
        loop {
            let pos = if anti_sens { last - i } else { i - first };
            let c = self.add_nucl(helix_id, i, anti_sens, strand_id, pos as usize);
            self.strands[strand_id].strand.push(c);
            self.nucl_to_strand.insert(c, strand_id);
            if i == j {
                break
            }
            i += step;
        }
    }

    pub fn get_nucl(&self, helix_id: usize, nucl: isize, antisens: bool) -> usize {
        *self.nucl_id.get(&(helix_id, nucl, antisens)).unwrap()
    }

    pub fn break_strand(&mut self, nucl_id: usize) {
        unsafe {
            let nucl = self
                .nucleotides
                .as_mut_ptr()
                .offset(nucl_id as isize)
                .as_mut()
                .unwrap();
            let new_strand = self.add_strand(0);
            let old_strand = self
                .strands
                .as_mut_ptr()
                .offset(nucl.strand as isize)
                .as_mut()
                .unwrap();
            let new_5 = nucl.pos_on_strand;
            for i in 0..(old_strand.strand.len() - new_5) {
                let n = old_strand.strand[i + new_5];
                self.strands[new_strand].strand.push(n);
                self.nucleotides[n].pos_on_strand = i;
                self.nucleotides[n].strand = new_strand;
            }
            old_strand.strand.resize(new_5, 0);
        }
    }

    pub fn make_jump(&mut self, origin_id: usize, end_id: usize) {
        let new_color = {
            let t = themes("".to_string());
            let c = t[self.colors_idx % t.len()];
            self.colors_idx += 1;
            c
        };
        unsafe {
            // origin and end stay valid because self.nucleotides is never moved
            let origin = self
                .nucleotides
                .as_mut_ptr()
                .offset(origin_id as isize)
                .as_mut()
                .unwrap();
            let end = self
                .nucleotides
                .as_mut_ptr()
                .offset(end_id as isize)
                .as_mut()
                .unwrap();
            //println!("origin {:?}, end {:?}", self.strands[origin.strand], self.strands[end.strand]);

            if origin.strand == end.strand {
                if origin.pos_on_strand < end.pos_on_strand {
                    let new_strand = self.add_strand(new_color);
                    let old_strand = self
                        .strands
                        .as_mut_ptr()
                        .offset(origin.strand as isize)
                        .as_mut()
                        .unwrap();
                    let end_3 = origin.pos_on_strand.max(end.pos_on_strand);
                    let end_5 = origin.pos_on_strand.min(end.pos_on_strand);

                    for nucl_id in &old_strand.strand[end_5 + 1..end_3] {
                        self.strands[new_strand].strand.push(*nucl_id);
                        let ref mut nucl = self.nucleotides[*nucl_id];
                        nucl.strand = new_strand;
                        nucl.pos_on_strand -= end_5 + 1;
                    }

                    let diff = end_3 - end_5 - 1;
                    let last_pos = old_strand.strand.len() - diff;
                    for i in (end_5 + 1)..last_pos {
                        old_strand.strand[i] = old_strand.strand[i + diff];
                        let nucl_id = old_strand.strand[i];
                        let ref mut nucl = self.nucleotides[nucl_id];
                        nucl.pos_on_strand = i;
                    }
                    old_strand.strand.resize(last_pos, 0);
                } else {
                    panic!("ATTEMPT TO CREATE A LOOP ! THIS IS NOT ACCEPTABLE");
                    //println!("same strand");
                }
                return;
            }


            if origin.pos_on_strand < self.strands[origin.strand].strand.len() {
                // We must create a new strand with the nucleotides remaining on the 3' end

                let new_strand_3_id = self.add_strand(new_color);

                //origin_strand and end_strand remain valid, self.strands will not move
                let origin_strand = self
                    .strands
                    .as_mut_ptr()
                    .offset(origin.strand as isize)
                    .as_mut()
                    .unwrap();
                for nucl_id in &origin_strand.strand[origin.pos_on_strand + 1..] {
                    self.strands[new_strand_3_id].strand.push(*nucl_id);
                    let ref mut nucl = self.nucleotides[*nucl_id];
                    nucl.strand = new_strand_3_id;
                    nucl.pos_on_strand -= origin.pos_on_strand + 1;
                }
            }

            if end.pos_on_strand > 0 {
                // We must create a new strand with the nucleotides remaining on the 5' end
                let new_strand_5_id = self.add_strand(new_color);
                let end_strand = self
                    .strands
                    .as_mut_ptr()
                    .offset(end.strand as isize)
                    .as_mut()
                    .unwrap();
                for nucl_id in &end_strand.strand[..end.pos_on_strand] {
                    self.strands[new_strand_5_id].strand.push(*nucl_id);
                    let ref mut nucl = self.nucleotides[*nucl_id];
                    nucl.strand = new_strand_5_id;
                    //no need to modify nucl.pos_on_strand
                }
            }

            // Concatenate origin and end
            let origin_strand = self
                .strands
                .as_mut_ptr()
                .offset(origin.strand as isize)
                .as_mut()
                .unwrap();
            let end_strand = self
                .strands
                .as_mut_ptr()
                .offset(end.strand as isize)
                .as_mut()
                .unwrap();
            origin_strand.strand.resize(origin.pos_on_strand + 1, 0);
            let mut pos = origin.pos_on_strand + 1;
            for nucl_id in &end_strand.strand[end.pos_on_strand..] {
                origin_strand.strand.push(*nucl_id);
                let ref mut nucl = self.nucleotides[*nucl_id];
                nucl.strand = origin.strand;
                nucl.pos_on_strand = pos;
                pos += 1;
            }
            end_strand.strand.resize(0, 0);
        }

    }

    pub fn set_scafold(&mut self, nucl_id: usize, scaffold: &str) {
        let nucl = &self.nucleotides[nucl_id];
        self.scaffold = nucl.strand;
        let scaf = &self.strands[self.scaffold].strand;

        for (&s, c) in scaf.iter().rev().zip(scaffold.chars()) {
            self.nucleotides[s].base = c;
        }
    }

    pub fn set_color(&mut self, nucl_id: usize, color: u32) {
        let nucl = &self.nucleotides[nucl_id];
        self.strands[nucl.strand].color = color;
    }

    pub fn auto_color(&mut self, theme: &str) {
        let colors = themes(theme.to_string());
        let mut color = 0;
        for i in 0..self.strands.len() {
            if !self.strands[i].strand.is_empty() {
                self.strands[i].color = colors[color % colors.len()];
                color += 1;
            }
        }
    }

    pub fn sequences<I: Iterator<Item = char>>(&self, mut fillings: I) -> String {
        let mut seq_vec: Vec<String> = Vec::new();
        let mut idxs: Vec<usize> = (0..self.strands.len()).collect();
        idxs.sort_by(|i, j| self.strand_group[*i].cmp(&self.strand_group[*j]));
        for i in idxs {
            if i != self.scaffold && !self.strands[i].strand.is_empty() {
                seq_vec.push(format!("{}, {}",
                                     self.strand_sequence(&self.strands[i], &mut fillings),
                                     self.strand_group[i]))
            }
        }
        seq_vec.join("\n")
    }

    pub fn make_pairs(&self) -> Vec<Option<usize>> {
        let n = self.positions.len();
        let mut ret = vec![None; n];
        for (a, b) in self.h_bonds.iter() {
            ret[*a] = Some(*b);
            ret[*b] = Some(*a);
        }
        ret
    }

    pub fn set_group(&mut self, nucl_id:usize, group: &str) {
        let strand = self.nucleotides[nucl_id].strand;
        self.strand_group[strand] = group.to_string();
    }

    pub fn make_h_bonds(&mut self) {
        for ref nucl_a in &self.nucleotides {
            if nucl_a.anti_sens || nucl_a.on_jump {
                // the h_bonds are made by the nucleotides on the sens strand
                continue;
            }
            if let Some(id_b) = self.nucl_id.get(&(nucl_a.helix_num, nucl_a.pos_on_helix, true)) {
                let ref nucl_b = self.nucleotides[*id_b];
                if !nucl_b.on_jump {
                    // Create h-bond between nucl_a and nucl_b
                    self.h_bonds.insert((nucl_a.id, nucl_b.id));
                }
            }
        }
    }

    fn strand_sequence<I: Iterator<Item = char>>(&self, strand: &Strand, mut fillings: I) -> String {
        let mut seq = String::new();
        for nucl_id in strand.strand.iter().rev() {
            let nucl = &self.nucleotides[*nucl_id];
            let letter = if let Some(compl) =
                self.nucl_id
                .get(&(nucl.helix_num, nucl.pos_on_helix, !nucl.anti_sens))
            {
                base_compl(self.nucleotides[*compl].base)
            }
            else {
                fillings.next().unwrap()
            };
            seq.push(letter);
        }
        seq
    }

}


fn base_compl(base: char) -> char {
    match base {
        'A' => 'T',
        'T' => 'A',
        'C' => 'G',
        'G' => 'C',
        '*' => '*',
        _ => {
            panic!("unexpected character");
        }
    }
}
/*
 * Typical use:
 * 1) create Helices, with an origin, orientation and roll
 * 2) create strands
 * 3) create 'section' of double strand
 */

