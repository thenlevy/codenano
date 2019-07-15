with import <nixpkgs> {};

let rustOverlay = import ("${builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz}/rust-overlay.nix") pkgs pkgs;
    rust = (rustOverlay.rustChannelOf {
       channel = "nightly";
       date = "2019-07-08";
    })
      .rust
      .override({ targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-gnu" ]; });
    webpack_ = nodePackages_10_x.webpack-cli.override { propagatedBuildInputs = with nodePackages_10_x; [ webpack ]; };

    wasm-bindgen = (callPackage ./wasm-bindgen/Cargo.nix {
      cratesIO = callPackage ./wasm-bindgen/crates-io.nix {};
    }).wasm_bindgen_cli {};
in

stdenv.mkDerivation {
  name = "cadnano-server";
  buildInputs =
   [ openssl pkgconfig rust webpack_ wasm-bindgen ];
  NODE_PATH="${nodePackages_10_x.webpack.out}/lib/node_modules"; # :${nodePackages_10_x.copy-webpack-plugin.out}/lib/node_modules";

}
