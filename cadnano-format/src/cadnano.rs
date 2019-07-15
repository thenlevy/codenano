use serde_json;
use std::path::Path;
use Error;
use std::fs::{File};

#[derive(Serialize, Deserialize, Debug, PartialEq, Eq)]
pub struct Cadnano {
    pub name: String,
    pub vstrands: Vec<VStrand>,
}

#[derive(Serialize, Deserialize, Debug, PartialEq, Eq, Clone)]
pub struct VStrand {
    pub col: isize,

    // Position of insertions
    #[serde(rename = "loop")]
    pub loop_: Vec<isize>,
    pub num: isize,
    pub row: isize,
    pub scaf: Vec<(isize, isize, isize, isize)>,
    #[serde(rename = "scafLoop")]
    pub scaf_loop: Vec<isize>,
    pub skip: Vec<isize>,
    // Each element is a corner (helix number, position, helix number,
    // position).
    pub stap: Vec<(isize, isize, isize, isize)>,
    #[serde(rename = "stapLoop")]
    pub stap_loop: Vec<isize>,
    pub stap_colors: Vec<(isize, isize)>
}

impl Cadnano {
    pub fn from_file<P:AsRef<Path>>(file: P) -> Result<Self, Error> {
        let f = File::open(file)?;
        Ok(serde_json::from_reader(&f)?)
    }

    pub fn to_file<P:AsRef<Path>>(&self, file: P) -> Result<(), Error> {
        let f = File::create(file)?;
        serde_json::to_writer(&f, self)?;
        Ok(())
    }

}
