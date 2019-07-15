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
