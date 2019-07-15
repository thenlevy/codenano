use finiteelement::*;
pub use design::Nanostructure;
pub const K_SPRING: f64 = 10000.;
pub const K_STACK: f64 = K_SPRING / 100.;
mod autoimplemented;
use autoimplemented::*;

pub fn make_system(nst: &design::Nanostructure) -> Vec<Box<dyn FiniteElement<f64>>> {
    let mut system = Vec::new();
    make_h_bonds(nst, &mut system);
    make_covalent_bonds(nst, &mut system);
    system
}

fn make_h_bonds(nst: &design::Nanostructure, system: &mut Vec<Box<dyn FiniteElement<f64>>>) {
    let len = &nst.cst;
    for ref nucl_a in &nst.nucleotides {
        if nucl_a.anti_sens || nucl_a.on_jump {
            // the h_bounds are made by the nucleotides on the sens strand
            continue;
        }

        if let Some(id_b) = nst.nucl_id.get(&(nucl_a.helix_num, nucl_a.pos_on_helix, true)) {
            let ref nucl_b = nst.nucleotides[*id_b];
            if nucl_b.on_jump {
                continue;
            }
            // Create h-bound between nucl_a and nucl_b
            system.push(Box::new(Spring {
                a: nucl_a.id,
                b: nucl_b.id,
                l: len.ab(),
                k: K_SPRING
            }));
            if let Some(id_c) = nst.nucl_id.get(&(nucl_a.helix_num, nucl_a.pos_on_helix + 1, false)) {
                if let Some(id_d) = nst.nucl_id.get(&(nucl_a.helix_num, nucl_a.pos_on_helix + 1, true)) {
                    let ref nucl_c = nst.nucleotides[*id_c];
                    let ref nucl_d = nst.nucleotides[*id_d];
                    if nucl_c.on_jump || nucl_d.on_jump {
                        continue;
                    }

                    system.push(Box::new(Stack {
                        a: nucl_a.id,
                        b: nucl_b.id,
                        c: nucl_c.id,
                        d: nucl_d.id,
                        angle0: len.angle_aoc2(),
                        strength: K_STACK
                    }));

                    system.push(Box::new(Spring {
                        a: nucl_a.id,
                        b: nucl_d.id,
                        l: len.ad(),
                        k: K_SPRING
                    }));

                    system.push(Box::new(Spring {
                        a: nucl_b.id,
                        b: nucl_c.id,
                        l: len.bc(),
                        k: K_SPRING
                    }));

                }
            }
        }
    }
}

fn make_covalent_bonds(nst: &design::Nanostructure, system: &mut Vec<Box<dyn FiniteElement<f64>>>) {
    let len = &nst.cst;
    for s in &nst.strands {
        for i in 1..s.strand.len() {
            let ref nucl_a = nst.nucleotides[s.strand[i - 1]];
            let ref nucl_c = nst.nucleotides[s.strand[i]];
            system.push(Box::new(Spring {
                a: nucl_a.id,
                b: nucl_c.id,
                l: len.ac(),
                k: K_SPRING
            }));
        }
    }
}
