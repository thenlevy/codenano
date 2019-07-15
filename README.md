Codenano
========

Install
--------
Don't forget to clone the content of the submodules as well `git clone https://github.com/thenlevy/codenano.git --recursive`.

### Requirement
 - You will need [Docker](https://www.docker.com/) to build the user space. This tutorial assumes that you know how to build a docker image from an existing `Dockerfile`
 - The easiest way to install Codenano is to use the [Nix package manager](https://nixos.org/nix/).
 
Run `nix-shell` at the root of the repository. Once you have a nix-shell running, run `make`. If everything goes well, this will display a generated `.json` file on `stdout`. 

Build the docker image and tag it as `codenano` to prepare the user space `docker build . -t codenano`.

You are now ready to lanch the server `cd` to `server` and run `cargo r -- --static ../static &`. Codenano is now running on `localhost:4000`. 

Designing Nanostructures
--------

### Getting started

You can copy and paste this code to generate a double cross-over


    use design::*;


    pub fn main() {
        let mut ori = Nanostructure::new();
        let id_0 = ori.add_grid_helix(0, 0);
        let id_1 = ori.add_grid_helix(1, 0);

        ori.draw_strand(id_0, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_0, true, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, true, 0, 20, AUTO_COLOR);

        ori.make_jump(ori.get_nucl(id_1, 11, false), ori.get_nucl(id_0, 11, true));
        ori.make_jump(ori.get_nucl(id_0, 12, true), ori.get_nucl(id_1, 12, false));


        ori.finish();
    }

### Helices, Strands and Nucleotides

In `Codenano`, designs are made by drawing `strands` on `helices` and
making `jumps` between those strands. Helices can be seen as bi-infinite
double axes with integers coordinates. Helices serves as support for the
nucleotides. On each helix there is a "sense" axe on which strand go
from 5' to 3' by increasing their coordinates, and an "antisense" axe on
which strands go from 5' to 3' by decreasing their coordinates. Each
nucleotide is identified by 3 values:

-   The identifier of the helix it is on (an integer)
-   Its coordinate on the axe (an integer)
-   A boolean saying if the nucleotide is on the antisense axe (true) or
    on the sense axe (false)

Helices created by specifying a point in space that is their origin, and
3 angles specifing their [roll, yaw, and pitch][]

There is also a simple version to create helices. The function
`add_grid_helix(i, j)` create an helix whose origin is at the square
`(i,j)` of a grid. All the helices created by this function are
parallel, and have a pitch, yaw and roll of 0.

When they are created, helices have no nucleotides on them. To add
nucleotides use the function
`draw_strand(id, antisense, begin, end, color)` where

-   `id` is an helix identifier
-   `antisense` is a boolean saying on which axe of the helix we are
    drawing (false for sense, true for antisense)
-   `begin` and `end` are the first and last (inclusive) coordinates of
    the axes on which nucleotides are to be added
-   `color` is the color of the strand to be drawn. One can either
    specify a color using hexadecimal RGB or use `AUTO_COLOR` when
    feeling uninspired.

&nbsp;

    use design::*;


    pub fn main() {
        let mut ori = Nanostructure::new();
        let id_0 = ori.add_grid_helix(0, 0);

        let id_1 = ori.add_helix(0., 0.2, 0., 0., 0., 0.); 
        // ^ This helix is parallel to id_0

        let id_2 = ori.add_helix(0., 0.5, -1., 0., 3.14/4., 3.14/6.);
        // ^ This helix has different orientation

        ori.draw_strand(id_0, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_0, true, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, true, 0, 20, AUTO_COLOR);

        // green strand
        ori.draw_strand(id_2, false, 0, 40, 0x00FF00);

        // blue strand
        ori.draw_strand(id_2, true, 0, 40, 0x0000FF);

        ori.finish();
    }

### Jumps

Strands determine where the covalent bounds between nucleotides are.
There is a covalent bound between two adjacent nucleotides if they are
on the same strand. It is also possible to create a covalent bound
between two nucleotides by creating a `jump` between them. Doing the
from one nucleotide on strand `s1` to one other on strand `s2` has the
following effect

-   The 5' end of s1 and the 3' end of s2 are merged into one strand
-   The 3' end of s1 becomes a new independent strand
-   The 5' end of s2 becomes a new independent strand

&nbsp;

    use design::*;

    pub fn main() {
        let mut ori = Nanostructure::new();
        let id_0 = ori.add_grid_helix(0, 0);

        let id_1 = ori.add_helix(0., 0.2, 0., 0., 0., 0.); 
        // ^ This helix is parallel to id_0

        ori.draw_strand(id_0, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_0, true, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, true, 0, 20, AUTO_COLOR);

        ori.make_jump(ori.get_nucl(id_0, 11, false), ori.get_nucl(id_1, 11, false));
        ori.finish();
    }

Example
-------

### Double cross-over


    use design::*;


    pub fn main() {
        let colors: Vec<u32> =vec![0x1f1f1f, 0xf81118,0xecba0f,0x2a84d2,
                                   0x4e5ab7, 0xd6dbe5, 0x1dd361, 0x0f7ddb];


        let mut ori = Nanostructure::new();
        let id_0 = ori.add_grid_helix(0, 0);
        let id_1 = ori.add_grid_helix(1, 0);

        ori.draw_strand(id_0, false, 0, 20, colors[6]);
        ori.draw_strand(id_0, true, 0, 20, colors[1]);
        ori.draw_strand(id_1, false, 0, 20, colors[2]);
        ori.draw_strand(id_1, true, 0, 20, colors[3]);

        ori.make_jump(ori.get_nucl(id_1, 11, false), ori.get_nucl(id_0, 11, true));
        ori.make_jump(ori.get_nucl(id_0, 12, true), ori.get_nucl(id_1, 12, false));


        ori.finish();
    }

### single stranded tile


    use design::*;

    const tile_length:isize = 11; 



    static mut colornum:usize = 0;

    pub fn add_sst(ori: &mut Nanostructure, helix_id: usize, helix_pos: isize) {
            let colors: Vec<u32> =vec![0x1f1f1f, 0xf81118,0xecba0f,0x2a84d2,
                                       0x4e5ab7, 0xd6dbe5, 0x1dd361, 0x0f7ddb];
            let mut color = 0;
            unsafe {
            color = colors[ (1 * colornum) % colors.len()];
            colornum += 1; }
            ori.draw_strand(helix_id, false, helix_pos, helix_pos + tile_length, color);
            ori.draw_strand(helix_id + 1, true, helix_pos + tile_length, helix_pos, color);
            ori.make_jump(ori.get_nucl(helix_id, helix_pos +tile_length, false),
                          ori.get_nucl(helix_id + 1, helix_pos + tile_length, true));
    }


    pub fn main() {

        let mut ori = Nanostructure::new();
        let id_0 = ori.add_grid_helix(0, 0);
        let id_1 = ori.add_grid_helix(1, 0);
        let id_2 = ori.add_grid_helix(2, 0);
        let id_3 = ori.add_grid_helix(3, 0);
        let id_4 = ori.add_grid_helix(4, 0);
        let id_5 = ori.add_grid_helix(5, 0);
        let id_6 = ori.add_grid_helix(6, 0);

        for i in 0isize..5 {
            for j in 0usize..3 {
                add_sst(&mut ori, j * 2, i * tile_length + i);
                add_sst(&mut ori, j * 2 + 1, i * tile_length + i + tile_length/2);
            }
        }
        ori.finish();
    }

Features for advanced users
===========================

Changing constants
------------------

There are two constants that can be changed. The first one is the number
of base pair per turns, the second one is the angle between two opposite
pairs.

By default the number of base pair per turn is 10.4, and the angle
between two opposite pairs is 220 degree (and not 180 degree, this is
why there is a major/minor groove). To change that you must create a
`DNAConst` object, modify its value and pass it as an argument to the
constructor of the `Nanostructure` object.


    use design::*;


    pub fn main() {

        let mut cst = DNAConst::default();
        cst.set_bpp(10.7); // number of base pair per turn
        cst.set_groove(3.14); // pi angle => no minor/major groove
        let mut ori = Nanostructure::with_constant(cst);
        let id_0 = ori.add_grid_helix(0, 0);
        let id_1 = ori.add_grid_helix(1, 0);

        ori.draw_strand(id_0, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_0, true, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, false, 0, 20, AUTO_COLOR);
        ori.draw_strand(id_1, true, 0, 20, AUTO_COLOR);

        ori.make_jump(ori.get_nucl(id_1, 11, false), ori.get_nucl(id_0, 11, true));
        ori.make_jump(ori.get_nucl(id_0, 12, true), ori.get_nucl(id_1, 12, false));


        ori.finish();
    }

  [roll, yaw, and pitch]: https://en.wikipedia.org/wiki/Aircraft_principal_axes

License
--------
Codenano is distributed under the terms of both the MIT license and the Apache License (Version 2.0)
