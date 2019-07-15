
pub fn to_cadnano(x: &[u8]) -> Result<String, failure::Error> {
    let design = serde_json::from_slice::<design::JSONNanostructure>(x)?.into_nanostructure();
    let mut vstrands = Vec::new();

    let mut max_x = 0;
    let mut min_x = 0;
    let mut max_y = 0;
    for (k, _) in design.nucl_id.iter() {
        max_x = max_x.max(k.1);
        min_x = min_x.min(k.1);
        max_y = max_y.max(k.0);
    }

    max_x -= min_x;
    let max_x = ((1 + max_x / 32) * 32) as usize;

    let mut odd_num = 1;
    let mut even_num = 0;
    let mut helices = Vec::new();
    for (i, _h) in design.helices.iter().enumerate() {
        let num;
        if i % 2 == 0 {
            num = odd_num;
            odd_num += 2;
        } else {
            num = even_num;
            even_num += 2;
        };
        helices.push(num);
        vstrands.push(cadnano_format::VStrand {
            col: 1,
            loop_: vec![0; max_x],
            num: num as isize,
            row: (max_y-i) as isize,
            scaf: vec![(-1, -1, -1, -1); max_x],
            scaf_loop: vec![0; max_x],
            skip: vec![0; max_x],
            stap: vec![(-1, -1, -1, -1); max_x],
            stap_loop: vec![0; max_x],
            stap_colors: vec![],
        })
    }

    for nuc in design.nucleotides.iter() {
        let is_scaf = (nuc.helix_num % 2 == 0) ^ nuc.anti_sens;
        let x = (nuc.pos_on_helix - min_x) as usize;

        let mut result: (isize, isize, isize, isize) = (-1, -1, -1, -1);

        if nuc.pos_on_strand > 0 {
            let prev = design.strands[nuc.strand].strand[nuc.pos_on_strand - 1];
            let ref prev_nuc = design.nucleotides[prev];
            result.0 = helices[prev_nuc.helix_num] as isize;
            result.1 = prev_nuc.pos_on_helix - min_x;
        }
        if nuc.pos_on_strand < design.strands[nuc.strand].strand.len() - 1 {
            let next = design.strands[nuc.strand].strand[nuc.pos_on_strand + 1];
            let ref next_nuc = design.nucleotides[next];
            result.2 = helices[next_nuc.helix_num] as isize;
            result.3 = next_nuc.pos_on_helix - min_x;
        }
        // if is_scaf {
        std::mem::swap(&mut result.0, &mut result.2);
        std::mem::swap(&mut result.1, &mut result.3);
        // }

        if is_scaf {
            vstrands[nuc.helix_num].scaf[x] = result;
        } else {
            vstrands[nuc.helix_num].stap[x] = result;
        }
    }

    for st in design.strands.iter() {
        if !st.strand.is_empty() {
            let ref nuc = design.nucleotides[st.strand[0]];
            let is_scaf = (nuc.helix_num % 2 == 0) ^ nuc.anti_sens;
            if !is_scaf {
                let nuc = if nuc.anti_sens {
                    &design.nucleotides[*st.strand.last().unwrap()]
                } else {
                    &design.nucleotides[st.strand[0]]
                };
                vstrands[nuc.helix_num].stap_colors.push((nuc.pos_on_helix - min_x, st.color as isize));
            }
        }
    }

    let nano = cadnano_format::Cadnano {
        name: "name".to_string(),
        vstrands,
    };

    Ok(serde_json::to_string(&nano).unwrap())
}
