{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# aho-corasick-0.7.3

  crates.aho_corasick."0.7.3" = deps: { features?(features_."aho_corasick"."0.7.3" deps {}) }: buildRustCrate {
    crateName = "aho-corasick";
    version = "0.7.3";
    description = "Fast multiple substring searching.";
    homepage = "https://github.com/BurntSushi/aho-corasick";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0dn42fbdms4brigqphxrvzbjd1s4knyjlzky30kgvpnrcl4sqqdv";
    libName = "aho_corasick";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."aho_corasick"."0.7.3"."memchr"}" deps)
    ]);
    features = mkFeatures (features."aho_corasick"."0.7.3" or {});
  };
  features_."aho_corasick"."0.7.3" = deps: f: updateFeatures f (rec {
    aho_corasick = fold recursiveUpdate {} [
      { "0.7.3"."std" =
        (f.aho_corasick."0.7.3"."std" or false) ||
        (f.aho_corasick."0.7.3"."default" or false) ||
        (aho_corasick."0.7.3"."default" or false); }
      { "0.7.3".default = (f.aho_corasick."0.7.3".default or true); }
    ];
    memchr = fold recursiveUpdate {} [
      { "${deps.aho_corasick."0.7.3".memchr}"."use_std" =
        (f.memchr."${deps.aho_corasick."0.7.3".memchr}"."use_std" or false) ||
        (aho_corasick."0.7.3"."std" or false) ||
        (f."aho_corasick"."0.7.3"."std" or false); }
      { "${deps.aho_corasick."0.7.3".memchr}".default = (f.memchr."${deps.aho_corasick."0.7.3".memchr}".default or false); }
    ];
  }) [
    (if deps."aho_corasick"."0.7.3" ? "memchr" then features_.memchr."${deps."aho_corasick"."0.7.3"."memchr" or ""}" deps else {})
  ];


# end
# argon2rs-0.2.5

  crates.argon2rs."0.2.5" = deps: { features?(features_."argon2rs"."0.2.5" deps {}) }: buildRustCrate {
    crateName = "argon2rs";
    version = "0.2.5";
    description = "The pure Rust password hashing library that runs on Argon2.";
    authors = [ "bryant <bryant@defrag.in>" ];
    sha256 = "1byl9b3wwyrarn8qack21v5fi2qsnn3y5clvikk2apskhmnih1rw";
    dependencies = mapFeatures features ([
      (crates."blake2_rfc"."${deps."argon2rs"."0.2.5"."blake2_rfc"}" deps)
      (crates."scoped_threadpool"."${deps."argon2rs"."0.2.5"."scoped_threadpool"}" deps)
    ]);
    features = mkFeatures (features."argon2rs"."0.2.5" or {});
  };
  features_."argon2rs"."0.2.5" = deps: f: updateFeatures f (rec {
    argon2rs."0.2.5".default = (f.argon2rs."0.2.5".default or true);
    blake2_rfc = fold recursiveUpdate {} [
      { "${deps.argon2rs."0.2.5".blake2_rfc}"."simd_asm" =
        (f.blake2_rfc."${deps.argon2rs."0.2.5".blake2_rfc}"."simd_asm" or false) ||
        (argon2rs."0.2.5"."simd" or false) ||
        (f."argon2rs"."0.2.5"."simd" or false); }
      { "${deps.argon2rs."0.2.5".blake2_rfc}".default = true; }
    ];
    scoped_threadpool."${deps.argon2rs."0.2.5".scoped_threadpool}".default = true;
  }) [
    (if deps."argon2rs"."0.2.5" ? "blake2_rfc" then features_.blake2_rfc."${deps."argon2rs"."0.2.5"."blake2_rfc" or ""}" deps else {})
    (if deps."argon2rs"."0.2.5" ? "scoped_threadpool" then features_.scoped_threadpool."${deps."argon2rs"."0.2.5"."scoped_threadpool" or ""}" deps else {})
  ];


# end
# arrayvec-0.4.10

  crates.arrayvec."0.4.10" = deps: { features?(features_."arrayvec"."0.4.10" deps {}) }: buildRustCrate {
    crateName = "arrayvec";
    version = "0.4.10";
    description = "A vector with fixed capacity, backed by an array (it can be stored on the stack too). Implements fixed capacity ArrayVec and ArrayString.";
    authors = [ "bluss" ];
    sha256 = "0qbh825i59w5wfdysqdkiwbwkrsy7lgbd4pwbyb8pxx8wc36iny8";
    dependencies = mapFeatures features ([
      (crates."nodrop"."${deps."arrayvec"."0.4.10"."nodrop"}" deps)
    ]);
    features = mkFeatures (features."arrayvec"."0.4.10" or {});
  };
  features_."arrayvec"."0.4.10" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "0.4.10"."serde" =
        (f.arrayvec."0.4.10"."serde" or false) ||
        (f.arrayvec."0.4.10"."serde-1" or false) ||
        (arrayvec."0.4.10"."serde-1" or false); }
      { "0.4.10"."std" =
        (f.arrayvec."0.4.10"."std" or false) ||
        (f.arrayvec."0.4.10"."default" or false) ||
        (arrayvec."0.4.10"."default" or false); }
      { "0.4.10".default = (f.arrayvec."0.4.10".default or true); }
    ];
    nodrop."${deps.arrayvec."0.4.10".nodrop}".default = (f.nodrop."${deps.arrayvec."0.4.10".nodrop}".default or false);
  }) [
    (if deps."arrayvec"."0.4.10" ? "nodrop" then features_.nodrop."${deps."arrayvec"."0.4.10"."nodrop" or ""}" deps else {})
  ];


# end
# ascii-0.8.7

  crates.ascii."0.8.7" = deps: { features?(features_."ascii"."0.8.7" deps {}) }: buildRustCrate {
    crateName = "ascii";
    version = "0.8.7";
    description = "ASCII-only equivalents to `char`, `str` and `String`.";
    authors = [ "Thomas Bahn <thomas@thomas-bahn.net>" "Torbjørn Birch Moltu <t.b.moltu@lyse.net>" "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "1dwcfl0dhcmdf2m85hdkxqdxqaizy3gb0k5p10z2yc1pgma5kwm3";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."ascii"."0.8.7" or {});
  };
  features_."ascii"."0.8.7" = deps: f: updateFeatures f (rec {
    ascii = fold recursiveUpdate {} [
      { "0.8.7"."std" =
        (f.ascii."0.8.7"."std" or false) ||
        (f.ascii."0.8.7"."default" or false) ||
        (ascii."0.8.7"."default" or false); }
      { "0.8.7".default = (f.ascii."0.8.7".default or true); }
    ];
  }) [];


# end
# assert_cmd-0.11.1

  crates.assert_cmd."0.11.1" = deps: { features?(features_."assert_cmd"."0.11.1" deps {}) }: buildRustCrate {
    crateName = "assert_cmd";
    version = "0.11.1";
    description = "Test CLI Applications.";
    homepage = "https://github.com/assert-rs/assert_cmd";
    authors = [ "Pascal Hertleif <killercup@gmail.com>" "Ed Page <eopage@gmail.com>" ];
    sha256 = "09azlmwyg1hxcgfx7xwdgl863n07ssdq50a8cg4fmrmbmaadgxvw";
    crateBin =
      [{  name = "bin_fixture"; }];
    dependencies = mapFeatures features ([
      (crates."escargot"."${deps."assert_cmd"."0.11.1"."escargot"}" deps)
      (crates."predicates"."${deps."assert_cmd"."0.11.1"."predicates"}" deps)
      (crates."predicates_core"."${deps."assert_cmd"."0.11.1"."predicates_core"}" deps)
      (crates."predicates_tree"."${deps."assert_cmd"."0.11.1"."predicates_tree"}" deps)
    ]);
  };
  features_."assert_cmd"."0.11.1" = deps: f: updateFeatures f (rec {
    assert_cmd."0.11.1".default = (f.assert_cmd."0.11.1".default or true);
    escargot."${deps.assert_cmd."0.11.1".escargot}".default = true;
    predicates = fold recursiveUpdate {} [
      { "${deps.assert_cmd."0.11.1".predicates}"."difference" = true; }
      { "${deps.assert_cmd."0.11.1".predicates}".default = (f.predicates."${deps.assert_cmd."0.11.1".predicates}".default or false); }
    ];
    predicates_core."${deps.assert_cmd."0.11.1".predicates_core}".default = true;
    predicates_tree."${deps.assert_cmd."0.11.1".predicates_tree}".default = true;
  }) [
    (if deps."assert_cmd"."0.11.1" ? "escargot" then features_.escargot."${deps."assert_cmd"."0.11.1"."escargot" or ""}" deps else {})
    (if deps."assert_cmd"."0.11.1" ? "predicates" then features_.predicates."${deps."assert_cmd"."0.11.1"."predicates" or ""}" deps else {})
    (if deps."assert_cmd"."0.11.1" ? "predicates_core" then features_.predicates_core."${deps."assert_cmd"."0.11.1"."predicates_core" or ""}" deps else {})
    (if deps."assert_cmd"."0.11.1" ? "predicates_tree" then features_.predicates_tree."${deps."assert_cmd"."0.11.1"."predicates_tree" or ""}" deps else {})
  ];


# end
# atty-0.2.11

  crates.atty."0.2.11" = deps: { features?(features_."atty"."0.2.11" deps {}) }: buildRustCrate {
    crateName = "atty";
    version = "0.2.11";
    description = "A simple interface for querying atty";
    homepage = "https://github.com/softprops/atty";
    authors = [ "softprops <d.tangren@gmail.com>" ];
    sha256 = "0by1bj2km9jxi4i4g76zzi76fc2rcm9934jpnyrqd95zw344pb20";
    dependencies = (if kernel == "redox" then mapFeatures features ([
      (crates."termion"."${deps."atty"."0.2.11"."termion"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."atty"."0.2.11"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."atty"."0.2.11"."winapi"}" deps)
    ]) else []);
  };
  features_."atty"."0.2.11" = deps: f: updateFeatures f (rec {
    atty."0.2.11".default = (f.atty."0.2.11".default or true);
    libc."${deps.atty."0.2.11".libc}".default = (f.libc."${deps.atty."0.2.11".libc}".default or false);
    termion."${deps.atty."0.2.11".termion}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.atty."0.2.11".winapi}"."consoleapi" = true; }
      { "${deps.atty."0.2.11".winapi}"."minwinbase" = true; }
      { "${deps.atty."0.2.11".winapi}"."minwindef" = true; }
      { "${deps.atty."0.2.11".winapi}"."processenv" = true; }
      { "${deps.atty."0.2.11".winapi}"."winbase" = true; }
      { "${deps.atty."0.2.11".winapi}".default = true; }
    ];
  }) [
    (if deps."atty"."0.2.11" ? "termion" then features_.termion."${deps."atty"."0.2.11"."termion" or ""}" deps else {})
    (if deps."atty"."0.2.11" ? "libc" then features_.libc."${deps."atty"."0.2.11"."libc" or ""}" deps else {})
    (if deps."atty"."0.2.11" ? "winapi" then features_.winapi."${deps."atty"."0.2.11"."winapi" or ""}" deps else {})
  ];


# end
# autocfg-0.1.2

  crates.autocfg."0.1.2" = deps: { features?(features_."autocfg"."0.1.2" deps {}) }: buildRustCrate {
    crateName = "autocfg";
    version = "0.1.2";
    description = "Automatic cfg for Rust compiler features";
    authors = [ "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "0dv81dwnp1al3j4ffz007yrjv4w1c7hw09gnf0xs3icxiw6qqfs3";
  };
  features_."autocfg"."0.1.2" = deps: f: updateFeatures f (rec {
    autocfg."0.1.2".default = (f.autocfg."0.1.2".default or true);
  }) [];


# end
# backtrace-0.3.15

  crates.backtrace."0.3.15" = deps: { features?(features_."backtrace"."0.3.15" deps {}) }: buildRustCrate {
    crateName = "backtrace";
    version = "0.3.15";
    description = "A library to acquire a stack trace (backtrace) at runtime in a Rust program.
";
    homepage = "https://github.com/alexcrichton/backtrace-rs";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "The Rust Project Developers" ];
    sha256 = "0qgbc07aq9kfixv29s60xx666lmdpgmf27a78fwjlhnfzhqvkn0p";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."backtrace"."0.3.15"."cfg_if"}" deps)
      (crates."rustc_demangle"."${deps."backtrace"."0.3.15"."rustc_demangle"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") && !(kernel == "fuchsia") && !(kernel == "emscripten") && !(kernel == "darwin") && !(kernel == "ios") then mapFeatures features ([
    ]
      ++ (if features.backtrace."0.3.15".backtrace-sys or false then [ (crates.backtrace_sys."${deps."backtrace"."0.3.15".backtrace_sys}" deps) ] else [])) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") || abi == "sgx" then mapFeatures features ([
      (crates."libc"."${deps."backtrace"."0.3.15"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."backtrace"."0.3.15"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."backtrace"."0.3.15"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."backtrace"."0.3.15" or {});
  };
  features_."backtrace"."0.3.15" = deps: f: updateFeatures f (rec {
    autocfg."${deps.backtrace."0.3.15".autocfg}".default = true;
    backtrace = fold recursiveUpdate {} [
      { "0.3.15"."addr2line" =
        (f.backtrace."0.3.15"."addr2line" or false) ||
        (f.backtrace."0.3.15"."gimli-symbolize" or false) ||
        (backtrace."0.3.15"."gimli-symbolize" or false); }
      { "0.3.15"."backtrace-sys" =
        (f.backtrace."0.3.15"."backtrace-sys" or false) ||
        (f.backtrace."0.3.15"."libbacktrace" or false) ||
        (backtrace."0.3.15"."libbacktrace" or false); }
      { "0.3.15"."coresymbolication" =
        (f.backtrace."0.3.15"."coresymbolication" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false); }
      { "0.3.15"."dbghelp" =
        (f.backtrace."0.3.15"."dbghelp" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false); }
      { "0.3.15"."dladdr" =
        (f.backtrace."0.3.15"."dladdr" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false); }
      { "0.3.15"."findshlibs" =
        (f.backtrace."0.3.15"."findshlibs" or false) ||
        (f.backtrace."0.3.15"."gimli-symbolize" or false) ||
        (backtrace."0.3.15"."gimli-symbolize" or false); }
      { "0.3.15"."gimli" =
        (f.backtrace."0.3.15"."gimli" or false) ||
        (f.backtrace."0.3.15"."gimli-symbolize" or false) ||
        (backtrace."0.3.15"."gimli-symbolize" or false); }
      { "0.3.15"."libbacktrace" =
        (f.backtrace."0.3.15"."libbacktrace" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false); }
      { "0.3.15"."libunwind" =
        (f.backtrace."0.3.15"."libunwind" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false); }
      { "0.3.15"."memmap" =
        (f.backtrace."0.3.15"."memmap" or false) ||
        (f.backtrace."0.3.15"."gimli-symbolize" or false) ||
        (backtrace."0.3.15"."gimli-symbolize" or false); }
      { "0.3.15"."object" =
        (f.backtrace."0.3.15"."object" or false) ||
        (f.backtrace."0.3.15"."gimli-symbolize" or false) ||
        (backtrace."0.3.15"."gimli-symbolize" or false); }
      { "0.3.15"."rustc-serialize" =
        (f.backtrace."0.3.15"."rustc-serialize" or false) ||
        (f.backtrace."0.3.15"."serialize-rustc" or false) ||
        (backtrace."0.3.15"."serialize-rustc" or false); }
      { "0.3.15"."serde" =
        (f.backtrace."0.3.15"."serde" or false) ||
        (f.backtrace."0.3.15"."serialize-serde" or false) ||
        (backtrace."0.3.15"."serialize-serde" or false); }
      { "0.3.15"."serde_derive" =
        (f.backtrace."0.3.15"."serde_derive" or false) ||
        (f.backtrace."0.3.15"."serialize-serde" or false) ||
        (backtrace."0.3.15"."serialize-serde" or false); }
      { "0.3.15"."std" =
        (f.backtrace."0.3.15"."std" or false) ||
        (f.backtrace."0.3.15"."default" or false) ||
        (backtrace."0.3.15"."default" or false) ||
        (f.backtrace."0.3.15"."libbacktrace" or false) ||
        (backtrace."0.3.15"."libbacktrace" or false); }
      { "0.3.15".default = (f.backtrace."0.3.15".default or true); }
    ];
    cfg_if."${deps.backtrace."0.3.15".cfg_if}".default = true;
    libc."${deps.backtrace."0.3.15".libc}".default = (f.libc."${deps.backtrace."0.3.15".libc}".default or false);
    rustc_demangle."${deps.backtrace."0.3.15".rustc_demangle}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.backtrace."0.3.15".winapi}"."dbghelp" = true; }
      { "${deps.backtrace."0.3.15".winapi}"."minwindef" = true; }
      { "${deps.backtrace."0.3.15".winapi}"."processthreadsapi" = true; }
      { "${deps.backtrace."0.3.15".winapi}"."winnt" = true; }
      { "${deps.backtrace."0.3.15".winapi}".default = true; }
    ];
  }) [
    (f: if deps."backtrace"."0.3.15" ? "backtrace_sys" then recursiveUpdate f { backtrace_sys."${deps."backtrace"."0.3.15"."backtrace_sys"}"."default" = true; } else f)
    (if deps."backtrace"."0.3.15" ? "cfg_if" then features_.cfg_if."${deps."backtrace"."0.3.15"."cfg_if" or ""}" deps else {})
    (if deps."backtrace"."0.3.15" ? "rustc_demangle" then features_.rustc_demangle."${deps."backtrace"."0.3.15"."rustc_demangle" or ""}" deps else {})
    (if deps."backtrace"."0.3.15" ? "autocfg" then features_.autocfg."${deps."backtrace"."0.3.15"."autocfg" or ""}" deps else {})
    (if deps."backtrace"."0.3.15" ? "backtrace_sys" then features_.backtrace_sys."${deps."backtrace"."0.3.15"."backtrace_sys" or ""}" deps else {})
    (if deps."backtrace"."0.3.15" ? "libc" then features_.libc."${deps."backtrace"."0.3.15"."libc" or ""}" deps else {})
    (if deps."backtrace"."0.3.15" ? "winapi" then features_.winapi."${deps."backtrace"."0.3.15"."winapi" or ""}" deps else {})
  ];


# end
# backtrace-sys-0.1.28

  crates.backtrace_sys."0.1.28" = deps: { features?(features_."backtrace_sys"."0.1.28" deps {}) }: buildRustCrate {
    crateName = "backtrace-sys";
    version = "0.1.28";
    description = "Bindings to the libbacktrace gcc library
";
    homepage = "https://github.com/alexcrichton/backtrace-rs";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1bbw8chs0wskxwzz7f3yy7mjqhyqj8lslq8pcjw1rbd2g23c34xl";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."backtrace_sys"."0.1.28"."libc"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."backtrace_sys"."0.1.28"."cc"}" deps)
    ]);
  };
  features_."backtrace_sys"."0.1.28" = deps: f: updateFeatures f (rec {
    backtrace_sys."0.1.28".default = (f.backtrace_sys."0.1.28".default or true);
    cc."${deps.backtrace_sys."0.1.28".cc}".default = true;
    libc."${deps.backtrace_sys."0.1.28".libc}".default = (f.libc."${deps.backtrace_sys."0.1.28".libc}".default or false);
  }) [
    (if deps."backtrace_sys"."0.1.28" ? "libc" then features_.libc."${deps."backtrace_sys"."0.1.28"."libc" or ""}" deps else {})
    (if deps."backtrace_sys"."0.1.28" ? "cc" then features_.cc."${deps."backtrace_sys"."0.1.28"."cc" or ""}" deps else {})
  ];


# end
# base64-0.9.3

  crates.base64."0.9.3" = deps: { features?(features_."base64"."0.9.3" deps {}) }: buildRustCrate {
    crateName = "base64";
    version = "0.9.3";
    description = "encodes and decodes base64 as bytes or utf8";
    authors = [ "Alice Maz <alice@alicemaz.com>" "Marshall Pierce <marshall@mpierce.org>" ];
    sha256 = "11hhz8ln4zbpn2h2gm9fbbb9j254wrd4fpmddlyah2rrnqsmmqkd";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."base64"."0.9.3"."byteorder"}" deps)
      (crates."safemem"."${deps."base64"."0.9.3"."safemem"}" deps)
    ]);
  };
  features_."base64"."0.9.3" = deps: f: updateFeatures f (rec {
    base64."0.9.3".default = (f.base64."0.9.3".default or true);
    byteorder."${deps.base64."0.9.3".byteorder}".default = true;
    safemem."${deps.base64."0.9.3".safemem}".default = true;
  }) [
    (if deps."base64"."0.9.3" ? "byteorder" then features_.byteorder."${deps."base64"."0.9.3"."byteorder" or ""}" deps else {})
    (if deps."base64"."0.9.3" ? "safemem" then features_.safemem."${deps."base64"."0.9.3"."safemem" or ""}" deps else {})
  ];


# end
# bitflags-1.0.5

  crates.bitflags."1.0.5" = deps: { features?(features_."bitflags"."1.0.5" deps {}) }: buildRustCrate {
    crateName = "bitflags";
    version = "1.0.5";
    description = "A macro to generate structures which behave like bitflags.
";
    homepage = "https://github.com/bitflags/bitflags";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0brvi70yflsqa8q6myqjpqmmqa0ng00mi4hpnfinc2y52sv76cwg";
    build = "build.rs";
    features = mkFeatures (features."bitflags"."1.0.5" or {});
  };
  features_."bitflags"."1.0.5" = deps: f: updateFeatures f (rec {
    bitflags."1.0.5".default = (f.bitflags."1.0.5".default or true);
  }) [];


# end
# blake2-rfc-0.2.18

  crates.blake2_rfc."0.2.18" = deps: { features?(features_."blake2_rfc"."0.2.18" deps {}) }: buildRustCrate {
    crateName = "blake2-rfc";
    version = "0.2.18";
    description = "A pure Rust implementation of BLAKE2 based on RFC 7693.";
    authors = [ "Cesar Eduardo Barros <cesarb@cesarb.eti.br>" ];
    sha256 = "0pyqrik4471ljk16prs0iwb2sam39z0z6axyyjxlqxdmf4wprf0l";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."blake2_rfc"."0.2.18"."arrayvec"}" deps)
      (crates."constant_time_eq"."${deps."blake2_rfc"."0.2.18"."constant_time_eq"}" deps)
    ]);
    features = mkFeatures (features."blake2_rfc"."0.2.18" or {});
  };
  features_."blake2_rfc"."0.2.18" = deps: f: updateFeatures f (rec {
    arrayvec."${deps.blake2_rfc."0.2.18".arrayvec}".default = (f.arrayvec."${deps.blake2_rfc."0.2.18".arrayvec}".default or false);
    blake2_rfc = fold recursiveUpdate {} [
      { "0.2.18"."simd" =
        (f.blake2_rfc."0.2.18"."simd" or false) ||
        (f.blake2_rfc."0.2.18"."simd_opt" or false) ||
        (blake2_rfc."0.2.18"."simd_opt" or false); }
      { "0.2.18"."simd_opt" =
        (f.blake2_rfc."0.2.18"."simd_opt" or false) ||
        (f.blake2_rfc."0.2.18"."simd_asm" or false) ||
        (blake2_rfc."0.2.18"."simd_asm" or false); }
      { "0.2.18"."std" =
        (f.blake2_rfc."0.2.18"."std" or false) ||
        (f.blake2_rfc."0.2.18"."default" or false) ||
        (blake2_rfc."0.2.18"."default" or false); }
      { "0.2.18".default = (f.blake2_rfc."0.2.18".default or true); }
    ];
    constant_time_eq."${deps.blake2_rfc."0.2.18".constant_time_eq}".default = true;
  }) [
    (if deps."blake2_rfc"."0.2.18" ? "arrayvec" then features_.arrayvec."${deps."blake2_rfc"."0.2.18"."arrayvec" or ""}" deps else {})
    (if deps."blake2_rfc"."0.2.18" ? "constant_time_eq" then features_.constant_time_eq."${deps."blake2_rfc"."0.2.18"."constant_time_eq" or ""}" deps else {})
  ];


# end
# buf_redux-0.8.1

  crates.buf_redux."0.8.1" = deps: { features?(features_."buf_redux"."0.8.1" deps {}) }: buildRustCrate {
    crateName = "buf_redux";
    version = "0.8.1";
    description = "Drop-in replacements for buffered I/O in `std::io` with extra features.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "01fa9k1nf34nc921z1ii1748h4i2ch0n1s2x9km4jzvdssfqrpw9";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."buf_redux"."0.8.1"."memchr"}" deps)
      (crates."safemem"."${deps."buf_redux"."0.8.1"."safemem"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") || kernel == "windows" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."buf_redux"."0.8.1" or {});
  };
  features_."buf_redux"."0.8.1" = deps: f: updateFeatures f (rec {
    buf_redux = fold recursiveUpdate {} [
      { "0.8.1"."slice-deque" =
        (f.buf_redux."0.8.1"."slice-deque" or false) ||
        (f.buf_redux."0.8.1"."default" or false) ||
        (buf_redux."0.8.1"."default" or false); }
      { "0.8.1".default = (f.buf_redux."0.8.1".default or true); }
    ];
    memchr."${deps.buf_redux."0.8.1".memchr}".default = true;
    safemem."${deps.buf_redux."0.8.1".safemem}".default = true;
  }) [
    (if deps."buf_redux"."0.8.1" ? "memchr" then features_.memchr."${deps."buf_redux"."0.8.1"."memchr" or ""}" deps else {})
    (if deps."buf_redux"."0.8.1" ? "safemem" then features_.safemem."${deps."buf_redux"."0.8.1"."safemem" or ""}" deps else {})
  ];


# end
# byteorder-1.3.1

  crates.byteorder."1.3.1" = deps: { features?(features_."byteorder"."1.3.1" deps {}) }: buildRustCrate {
    crateName = "byteorder";
    version = "1.3.1";
    description = "Library for reading/writing numbers in big-endian and little-endian.";
    homepage = "https://github.com/BurntSushi/byteorder";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1dd46l7fvmxfq90kh6ip1ghsxzzcdybac8f0mh2jivsdv9vy8k4w";
    build = "build.rs";
    features = mkFeatures (features."byteorder"."1.3.1" or {});
  };
  features_."byteorder"."1.3.1" = deps: f: updateFeatures f (rec {
    byteorder = fold recursiveUpdate {} [
      { "1.3.1"."std" =
        (f.byteorder."1.3.1"."std" or false) ||
        (f.byteorder."1.3.1"."default" or false) ||
        (byteorder."1.3.1"."default" or false); }
      { "1.3.1".default = (f.byteorder."1.3.1".default or true); }
    ];
  }) [];


# end
# cc-1.0.36

  crates.cc."1.0.36" = deps: { features?(features_."cc"."1.0.36" deps {}) }: buildRustCrate {
    crateName = "cc";
    version = "1.0.36";
    description = "A build-time dependency for Cargo build scripts to assist in invoking the native
C compiler to compile native C code into a static archive to be linked into Rust
code.
";
    homepage = "https://github.com/alexcrichton/cc-rs";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0yk9f8fcsp9qk00qbj8idsnjv29v5arp3w5awgggf5kg571djjx7";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cc"."1.0.36" or {});
  };
  features_."cc"."1.0.36" = deps: f: updateFeatures f (rec {
    cc = fold recursiveUpdate {} [
      { "1.0.36"."rayon" =
        (f.cc."1.0.36"."rayon" or false) ||
        (f.cc."1.0.36"."parallel" or false) ||
        (cc."1.0.36"."parallel" or false); }
      { "1.0.36".default = (f.cc."1.0.36".default or true); }
    ];
  }) [];


# end
# cfg-if-0.1.7

  crates.cfg_if."0.1.7" = deps: { features?(features_."cfg_if"."0.1.7" deps {}) }: buildRustCrate {
    crateName = "cfg-if";
    version = "0.1.7";
    description = "A macro to ergonomically define an item depending on a large number of #[cfg]
parameters. Structured like an if-else chain, the first matching branch is the
item that gets emitted.
";
    homepage = "https://github.com/alexcrichton/cfg-if";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "13gvcx1dxjq4mpmpj26hpg3yc97qffkx2zi58ykr1dwr8q2biiig";
  };
  features_."cfg_if"."0.1.7" = deps: f: updateFeatures f (rec {
    cfg_if."0.1.7".default = (f.cfg_if."0.1.7".default or true);
  }) [];


# end
# chrono-0.4.6

  crates.chrono."0.4.6" = deps: { features?(features_."chrono"."0.4.6" deps {}) }: buildRustCrate {
    crateName = "chrono";
    version = "0.4.6";
    description = "Date and time library for Rust";
    homepage = "https://github.com/chronotope/chrono";
    authors = [ "Kang Seonghoon <public+rust@mearie.org>" "Brandon W Maister <quodlibetor@gmail.com>" ];
    sha256 = "0cxgqgf4lknsii1k806dpmzapi2zccjpa350ns5wpb568mij096x";
    dependencies = mapFeatures features ([
      (crates."num_integer"."${deps."chrono"."0.4.6"."num_integer"}" deps)
      (crates."num_traits"."${deps."chrono"."0.4.6"."num_traits"}" deps)
    ]
      ++ (if features.chrono."0.4.6".time or false then [ (crates.time."${deps."chrono"."0.4.6".time}" deps) ] else []));
    features = mkFeatures (features."chrono"."0.4.6" or {});
  };
  features_."chrono"."0.4.6" = deps: f: updateFeatures f (rec {
    chrono = fold recursiveUpdate {} [
      { "0.4.6"."clock" =
        (f.chrono."0.4.6"."clock" or false) ||
        (f.chrono."0.4.6"."default" or false) ||
        (chrono."0.4.6"."default" or false); }
      { "0.4.6"."time" =
        (f.chrono."0.4.6"."time" or false) ||
        (f.chrono."0.4.6"."clock" or false) ||
        (chrono."0.4.6"."clock" or false); }
      { "0.4.6".default = (f.chrono."0.4.6".default or true); }
    ];
    num_integer."${deps.chrono."0.4.6".num_integer}".default = (f.num_integer."${deps.chrono."0.4.6".num_integer}".default or false);
    num_traits."${deps.chrono."0.4.6".num_traits}".default = (f.num_traits."${deps.chrono."0.4.6".num_traits}".default or false);
  }) [
    (f: if deps."chrono"."0.4.6" ? "time" then recursiveUpdate f { time."${deps."chrono"."0.4.6"."time"}"."default" = true; } else f)
    (if deps."chrono"."0.4.6" ? "num_integer" then features_.num_integer."${deps."chrono"."0.4.6"."num_integer" or ""}" deps else {})
    (if deps."chrono"."0.4.6" ? "num_traits" then features_.num_traits."${deps."chrono"."0.4.6"."num_traits" or ""}" deps else {})
    (if deps."chrono"."0.4.6" ? "time" then features_.time."${deps."chrono"."0.4.6"."time" or ""}" deps else {})
  ];


# end
# chunked_transfer-0.3.1

  crates.chunked_transfer."0.3.1" = deps: { features?(features_."chunked_transfer"."0.3.1" deps {}) }: buildRustCrate {
    crateName = "chunked_transfer";
    version = "0.3.1";
    description = "Encoder and decoder for HTTP chunked transfer coding (RFC 7230 § 4.1)";
    authors = [ "Corey Farwell <coreyf@rwell.org>" ];
    sha256 = "0bgk8axxlaawwqapm52r12lqiqj97qdl2wjn78w7x7x6lm76si3j";
  };
  features_."chunked_transfer"."0.3.1" = deps: f: updateFeatures f (rec {
    chunked_transfer."0.3.1".default = (f.chunked_transfer."0.3.1".default or true);
  }) [];


# end
# cloudabi-0.0.3

  crates.cloudabi."0.0.3" = deps: { features?(features_."cloudabi"."0.0.3" deps {}) }: buildRustCrate {
    crateName = "cloudabi";
    version = "0.0.3";
    description = "Low level interface to CloudABI. Contains all syscalls and related types.";
    homepage = "https://nuxi.nl/cloudabi/";
    authors = [ "Nuxi (https://nuxi.nl/) and contributors" ];
    sha256 = "1z9lby5sr6vslfd14d6igk03s7awf91mxpsfmsp3prxbxlk0x7h5";
    libPath = "cloudabi.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.cloudabi."0.0.3".bitflags or false then [ (crates.bitflags."${deps."cloudabi"."0.0.3".bitflags}" deps) ] else []));
    features = mkFeatures (features."cloudabi"."0.0.3" or {});
  };
  features_."cloudabi"."0.0.3" = deps: f: updateFeatures f (rec {
    cloudabi = fold recursiveUpdate {} [
      { "0.0.3"."bitflags" =
        (f.cloudabi."0.0.3"."bitflags" or false) ||
        (f.cloudabi."0.0.3"."default" or false) ||
        (cloudabi."0.0.3"."default" or false); }
      { "0.0.3".default = (f.cloudabi."0.0.3".default or true); }
    ];
  }) [
    (f: if deps."cloudabi"."0.0.3" ? "bitflags" then recursiveUpdate f { bitflags."${deps."cloudabi"."0.0.3"."bitflags"}"."default" = true; } else f)
    (if deps."cloudabi"."0.0.3" ? "bitflags" then features_.bitflags."${deps."cloudabi"."0.0.3"."bitflags" or ""}" deps else {})
  ];


# end
# constant_time_eq-0.1.3

  crates.constant_time_eq."0.1.3" = deps: { features?(features_."constant_time_eq"."0.1.3" deps {}) }: buildRustCrate {
    crateName = "constant_time_eq";
    version = "0.1.3";
    description = "Compares two equal-sized byte strings in constant time.";
    authors = [ "Cesar Eduardo Barros <cesarb@cesarb.eti.br>" ];
    sha256 = "03qri9hjf049gwqg9q527lybpg918q6y5q4g9a5lma753nff49wd";
  };
  features_."constant_time_eq"."0.1.3" = deps: f: updateFeatures f (rec {
    constant_time_eq."0.1.3".default = (f.constant_time_eq."0.1.3".default or true);
  }) [];


# end
# crossbeam-deque-0.2.0

  crates.crossbeam_deque."0.2.0" = deps: { features?(features_."crossbeam_deque"."0.2.0" deps {}) }: buildRustCrate {
    crateName = "crossbeam-deque";
    version = "0.2.0";
    description = "Concurrent work-stealing deque";
    homepage = "https://github.com/crossbeam-rs/crossbeam-deque";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "1h3n1p1qy45b6388j3svfy1m72xlcx9j9a5y0mww6jz8fmknipnb";
    dependencies = mapFeatures features ([
      (crates."crossbeam_epoch"."${deps."crossbeam_deque"."0.2.0"."crossbeam_epoch"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_deque"."0.2.0"."crossbeam_utils"}" deps)
    ]);
  };
  features_."crossbeam_deque"."0.2.0" = deps: f: updateFeatures f (rec {
    crossbeam_deque."0.2.0".default = (f.crossbeam_deque."0.2.0".default or true);
    crossbeam_epoch."${deps.crossbeam_deque."0.2.0".crossbeam_epoch}".default = true;
    crossbeam_utils."${deps.crossbeam_deque."0.2.0".crossbeam_utils}".default = true;
  }) [
    (if deps."crossbeam_deque"."0.2.0" ? "crossbeam_epoch" then features_.crossbeam_epoch."${deps."crossbeam_deque"."0.2.0"."crossbeam_epoch" or ""}" deps else {})
    (if deps."crossbeam_deque"."0.2.0" ? "crossbeam_utils" then features_.crossbeam_utils."${deps."crossbeam_deque"."0.2.0"."crossbeam_utils" or ""}" deps else {})
  ];


# end
# crossbeam-epoch-0.3.1

  crates.crossbeam_epoch."0.3.1" = deps: { features?(features_."crossbeam_epoch"."0.3.1" deps {}) }: buildRustCrate {
    crateName = "crossbeam-epoch";
    version = "0.3.1";
    description = "Epoch-based garbage collection";
    homepage = "https://github.com/crossbeam-rs/crossbeam-epoch";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "1ljrrpvalabi3r2nnpcz7rqkbl2ydmd0mrrr2fv335f7d46xgfxa";
    dependencies = mapFeatures features ([
      (crates."arrayvec"."${deps."crossbeam_epoch"."0.3.1"."arrayvec"}" deps)
      (crates."cfg_if"."${deps."crossbeam_epoch"."0.3.1"."cfg_if"}" deps)
      (crates."crossbeam_utils"."${deps."crossbeam_epoch"."0.3.1"."crossbeam_utils"}" deps)
      (crates."memoffset"."${deps."crossbeam_epoch"."0.3.1"."memoffset"}" deps)
      (crates."nodrop"."${deps."crossbeam_epoch"."0.3.1"."nodrop"}" deps)
      (crates."scopeguard"."${deps."crossbeam_epoch"."0.3.1"."scopeguard"}" deps)
    ]
      ++ (if features.crossbeam_epoch."0.3.1".lazy_static or false then [ (crates.lazy_static."${deps."crossbeam_epoch"."0.3.1".lazy_static}" deps) ] else []));
    features = mkFeatures (features."crossbeam_epoch"."0.3.1" or {});
  };
  features_."crossbeam_epoch"."0.3.1" = deps: f: updateFeatures f (rec {
    arrayvec = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.3.1".arrayvec}"."use_union" =
        (f.arrayvec."${deps.crossbeam_epoch."0.3.1".arrayvec}"."use_union" or false) ||
        (crossbeam_epoch."0.3.1"."nightly" or false) ||
        (f."crossbeam_epoch"."0.3.1"."nightly" or false); }
      { "${deps.crossbeam_epoch."0.3.1".arrayvec}".default = (f.arrayvec."${deps.crossbeam_epoch."0.3.1".arrayvec}".default or false); }
    ];
    cfg_if."${deps.crossbeam_epoch."0.3.1".cfg_if}".default = true;
    crossbeam_epoch = fold recursiveUpdate {} [
      { "0.3.1"."lazy_static" =
        (f.crossbeam_epoch."0.3.1"."lazy_static" or false) ||
        (f.crossbeam_epoch."0.3.1"."use_std" or false) ||
        (crossbeam_epoch."0.3.1"."use_std" or false); }
      { "0.3.1"."use_std" =
        (f.crossbeam_epoch."0.3.1"."use_std" or false) ||
        (f.crossbeam_epoch."0.3.1"."default" or false) ||
        (crossbeam_epoch."0.3.1"."default" or false); }
      { "0.3.1".default = (f.crossbeam_epoch."0.3.1".default or true); }
    ];
    crossbeam_utils = fold recursiveUpdate {} [
      { "${deps.crossbeam_epoch."0.3.1".crossbeam_utils}"."use_std" =
        (f.crossbeam_utils."${deps.crossbeam_epoch."0.3.1".crossbeam_utils}"."use_std" or false) ||
        (crossbeam_epoch."0.3.1"."use_std" or false) ||
        (f."crossbeam_epoch"."0.3.1"."use_std" or false); }
      { "${deps.crossbeam_epoch."0.3.1".crossbeam_utils}".default = (f.crossbeam_utils."${deps.crossbeam_epoch."0.3.1".crossbeam_utils}".default or false); }
    ];
    memoffset."${deps.crossbeam_epoch."0.3.1".memoffset}".default = true;
    nodrop."${deps.crossbeam_epoch."0.3.1".nodrop}".default = (f.nodrop."${deps.crossbeam_epoch."0.3.1".nodrop}".default or false);
    scopeguard."${deps.crossbeam_epoch."0.3.1".scopeguard}".default = (f.scopeguard."${deps.crossbeam_epoch."0.3.1".scopeguard}".default or false);
  }) [
    (f: if deps."crossbeam_epoch"."0.3.1" ? "lazy_static" then recursiveUpdate f { lazy_static."${deps."crossbeam_epoch"."0.3.1"."lazy_static"}"."default" = true; } else f)
    (if deps."crossbeam_epoch"."0.3.1" ? "arrayvec" then features_.arrayvec."${deps."crossbeam_epoch"."0.3.1"."arrayvec" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "cfg_if" then features_.cfg_if."${deps."crossbeam_epoch"."0.3.1"."cfg_if" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "crossbeam_utils" then features_.crossbeam_utils."${deps."crossbeam_epoch"."0.3.1"."crossbeam_utils" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "lazy_static" then features_.lazy_static."${deps."crossbeam_epoch"."0.3.1"."lazy_static" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "memoffset" then features_.memoffset."${deps."crossbeam_epoch"."0.3.1"."memoffset" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "nodrop" then features_.nodrop."${deps."crossbeam_epoch"."0.3.1"."nodrop" or ""}" deps else {})
    (if deps."crossbeam_epoch"."0.3.1" ? "scopeguard" then features_.scopeguard."${deps."crossbeam_epoch"."0.3.1"."scopeguard" or ""}" deps else {})
  ];


# end
# crossbeam-utils-0.2.2

  crates.crossbeam_utils."0.2.2" = deps: { features?(features_."crossbeam_utils"."0.2.2" deps {}) }: buildRustCrate {
    crateName = "crossbeam-utils";
    version = "0.2.2";
    description = "Utilities for concurrent programming";
    homepage = "https://github.com/crossbeam-rs/crossbeam-utils";
    authors = [ "The Crossbeam Project Developers" ];
    sha256 = "0jiwzxv0lysjq68yk4bzkygrf69zhdidyw55nxlmimxlm6xv0j4m";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crossbeam_utils"."0.2.2"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."crossbeam_utils"."0.2.2" or {});
  };
  features_."crossbeam_utils"."0.2.2" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crossbeam_utils."0.2.2".cfg_if}".default = true;
    crossbeam_utils = fold recursiveUpdate {} [
      { "0.2.2"."use_std" =
        (f.crossbeam_utils."0.2.2"."use_std" or false) ||
        (f.crossbeam_utils."0.2.2"."default" or false) ||
        (crossbeam_utils."0.2.2"."default" or false); }
      { "0.2.2".default = (f.crossbeam_utils."0.2.2".default or true); }
    ];
  }) [
    (if deps."crossbeam_utils"."0.2.2" ? "cfg_if" then features_.cfg_if."${deps."crossbeam_utils"."0.2.2"."cfg_if" or ""}" deps else {})
  ];


# end
# curl-0.4.21

  crates.curl."0.4.21" = deps: { features?(features_."curl"."0.4.21" deps {}) }: buildRustCrate {
    crateName = "curl";
    version = "0.4.21";
    description = "Rust bindings to libcurl for making HTTP requests";
    homepage = "https://github.com/alexcrichton/curl-rust";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1n13h0scc4s77ryf3w19n3myh4k1ls4bfxrx6y6ffvayjfnh13qy";
    dependencies = mapFeatures features ([
      (crates."curl_sys"."${deps."curl"."0.4.21"."curl_sys"}" deps)
      (crates."libc"."${deps."curl"."0.4.21"."libc"}" deps)
      (crates."socket2"."${deps."curl"."0.4.21"."socket2"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") && !(kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.curl."0.4.21".openssl-probe or false then [ (crates.openssl_probe."${deps."curl"."0.4.21".openssl_probe}" deps) ] else [])
      ++ (if features.curl."0.4.21".openssl-sys or false then [ (crates.openssl_sys."${deps."curl"."0.4.21".openssl_sys}" deps) ] else [])) else [])
      ++ (if abi == "msvc" then mapFeatures features ([
      (crates."kernel32_sys"."${deps."curl"."0.4.21"."kernel32_sys"}" deps)
      (crates."schannel"."${deps."curl"."0.4.21"."schannel"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."curl"."0.4.21"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."curl"."0.4.21" or {});
  };
  features_."curl"."0.4.21" = deps: f: updateFeatures f (rec {
    curl = fold recursiveUpdate {} [
      { "0.4.21"."openssl-probe" =
        (f.curl."0.4.21"."openssl-probe" or false) ||
        (f.curl."0.4.21"."ssl" or false) ||
        (curl."0.4.21"."ssl" or false); }
      { "0.4.21"."openssl-sys" =
        (f.curl."0.4.21"."openssl-sys" or false) ||
        (f.curl."0.4.21"."ssl" or false) ||
        (curl."0.4.21"."ssl" or false); }
      { "0.4.21"."ssl" =
        (f.curl."0.4.21"."ssl" or false) ||
        (f.curl."0.4.21"."default" or false) ||
        (curl."0.4.21"."default" or false); }
      { "0.4.21".default = (f.curl."0.4.21".default or true); }
    ];
    curl_sys = fold recursiveUpdate {} [
      { "${deps.curl."0.4.21".curl_sys}"."force-system-lib-on-osx" =
        (f.curl_sys."${deps.curl."0.4.21".curl_sys}"."force-system-lib-on-osx" or false) ||
        (curl."0.4.21"."force-system-lib-on-osx" or false) ||
        (f."curl"."0.4.21"."force-system-lib-on-osx" or false); }
      { "${deps.curl."0.4.21".curl_sys}"."http2" =
        (f.curl_sys."${deps.curl."0.4.21".curl_sys}"."http2" or false) ||
        (curl."0.4.21"."http2" or false) ||
        (f."curl"."0.4.21"."http2" or false); }
      { "${deps.curl."0.4.21".curl_sys}"."ssl" =
        (f.curl_sys."${deps.curl."0.4.21".curl_sys}"."ssl" or false) ||
        (curl."0.4.21"."ssl" or false) ||
        (f."curl"."0.4.21"."ssl" or false); }
      { "${deps.curl."0.4.21".curl_sys}"."static-curl" =
        (f.curl_sys."${deps.curl."0.4.21".curl_sys}"."static-curl" or false) ||
        (curl."0.4.21"."static-curl" or false) ||
        (f."curl"."0.4.21"."static-curl" or false); }
      { "${deps.curl."0.4.21".curl_sys}"."static-ssl" =
        (f.curl_sys."${deps.curl."0.4.21".curl_sys}"."static-ssl" or false) ||
        (curl."0.4.21"."static-ssl" or false) ||
        (f."curl"."0.4.21"."static-ssl" or false); }
      { "${deps.curl."0.4.21".curl_sys}".default = (f.curl_sys."${deps.curl."0.4.21".curl_sys}".default or false); }
    ];
    kernel32_sys."${deps.curl."0.4.21".kernel32_sys}".default = true;
    libc."${deps.curl."0.4.21".libc}".default = true;
    schannel."${deps.curl."0.4.21".schannel}".default = true;
    socket2."${deps.curl."0.4.21".socket2}".default = true;
    winapi."${deps.curl."0.4.21".winapi}".default = true;
  }) [
    (f: if deps."curl"."0.4.21" ? "openssl_probe" then recursiveUpdate f { openssl_probe."${deps."curl"."0.4.21"."openssl_probe"}"."default" = true; } else f)
    (f: if deps."curl"."0.4.21" ? "openssl_sys" then recursiveUpdate f { openssl_sys."${deps."curl"."0.4.21"."openssl_sys"}"."default" = true; } else f)
    (if deps."curl"."0.4.21" ? "curl_sys" then features_.curl_sys."${deps."curl"."0.4.21"."curl_sys" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "libc" then features_.libc."${deps."curl"."0.4.21"."libc" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "socket2" then features_.socket2."${deps."curl"."0.4.21"."socket2" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "openssl_probe" then features_.openssl_probe."${deps."curl"."0.4.21"."openssl_probe" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "openssl_sys" then features_.openssl_sys."${deps."curl"."0.4.21"."openssl_sys" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "kernel32_sys" then features_.kernel32_sys."${deps."curl"."0.4.21"."kernel32_sys" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "schannel" then features_.schannel."${deps."curl"."0.4.21"."schannel" or ""}" deps else {})
    (if deps."curl"."0.4.21" ? "winapi" then features_.winapi."${deps."curl"."0.4.21"."winapi" or ""}" deps else {})
  ];


# end
# curl-sys-0.4.18

  crates.curl_sys."0.4.18" = deps: { features?(features_."curl_sys"."0.4.18" deps {}) }: buildRustCrate {
    crateName = "curl-sys";
    version = "0.4.18";
    description = "Native bindings to the libcurl library";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1y9qglyirlxhp62gh5vlzpq67jw7cyccvsajvmj30dv1sn7cn3vk";
    libPath = "lib.rs";
    libName = "curl_sys";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."curl_sys"."0.4.18"."libc"}" deps)
      (crates."libz_sys"."${deps."curl_sys"."0.4.18"."libz_sys"}" deps)
    ])
      ++ (if (kernel == "linux" || kernel == "darwin") && !(kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.curl_sys."0.4.18".openssl-sys or false then [ (crates.openssl_sys."${deps."curl_sys"."0.4.18".openssl_sys}" deps) ] else [])) else [])
      ++ (if abi == "msvc" then mapFeatures features ([
]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."curl_sys"."0.4.18"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."curl_sys"."0.4.18"."cc"}" deps)
      (crates."pkg_config"."${deps."curl_sys"."0.4.18"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."curl_sys"."0.4.18" or {});
  };
  features_."curl_sys"."0.4.18" = deps: f: updateFeatures f (rec {
    cc."${deps.curl_sys."0.4.18".cc}".default = true;
    curl_sys = fold recursiveUpdate {} [
      { "0.4.18"."libnghttp2-sys" =
        (f.curl_sys."0.4.18"."libnghttp2-sys" or false) ||
        (f.curl_sys."0.4.18"."http2" or false) ||
        (curl_sys."0.4.18"."http2" or false); }
      { "0.4.18"."openssl-sys" =
        (f.curl_sys."0.4.18"."openssl-sys" or false) ||
        (f.curl_sys."0.4.18"."ssl" or false) ||
        (curl_sys."0.4.18"."ssl" or false); }
      { "0.4.18"."ssl" =
        (f.curl_sys."0.4.18"."ssl" or false) ||
        (f.curl_sys."0.4.18"."default" or false) ||
        (curl_sys."0.4.18"."default" or false); }
      { "0.4.18".default = (f.curl_sys."0.4.18".default or true); }
    ];
    libc."${deps.curl_sys."0.4.18".libc}".default = true;
    libz_sys."${deps.curl_sys."0.4.18".libz_sys}".default = true;
    pkg_config."${deps.curl_sys."0.4.18".pkg_config}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.curl_sys."0.4.18".winapi}"."winsock2" = true; }
      { "${deps.curl_sys."0.4.18".winapi}"."ws2def" = true; }
      { "${deps.curl_sys."0.4.18".winapi}".default = true; }
    ];
  }) [
    (f: if deps."curl_sys"."0.4.18" ? "openssl_sys" then recursiveUpdate f { openssl_sys."${deps."curl_sys"."0.4.18"."openssl_sys"}"."default" = true; } else f)
    (if deps."curl_sys"."0.4.18" ? "libc" then features_.libc."${deps."curl_sys"."0.4.18"."libc" or ""}" deps else {})
    (if deps."curl_sys"."0.4.18" ? "libz_sys" then features_.libz_sys."${deps."curl_sys"."0.4.18"."libz_sys" or ""}" deps else {})
    (if deps."curl_sys"."0.4.18" ? "cc" then features_.cc."${deps."curl_sys"."0.4.18"."cc" or ""}" deps else {})
    (if deps."curl_sys"."0.4.18" ? "pkg_config" then features_.pkg_config."${deps."curl_sys"."0.4.18"."pkg_config" or ""}" deps else {})
    (if deps."curl_sys"."0.4.18" ? "openssl_sys" then features_.openssl_sys."${deps."curl_sys"."0.4.18"."openssl_sys" or ""}" deps else {})
    (if deps."curl_sys"."0.4.18" ? "winapi" then features_.winapi."${deps."curl_sys"."0.4.18"."winapi" or ""}" deps else {})
  ];


# end
# difference-2.0.0

  crates.difference."2.0.0" = deps: { features?(features_."difference"."2.0.0" deps {}) }: buildRustCrate {
    crateName = "difference";
    version = "2.0.0";
    description = "A Rust text diffing and assertion library.";
    authors = [ "Johann Hofmann <mail@johann-hofmann.com>" ];
    sha256 = "1rk24wxxkhhw8drhda229dfy2nb64vvcz0ras6lq7va6wswlrc49";
    crateBin =
      [{  name = "difference"; }];
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."difference"."2.0.0" or {});
  };
  features_."difference"."2.0.0" = deps: f: updateFeatures f (rec {
    difference = fold recursiveUpdate {} [
      { "2.0.0"."getopts" =
        (f.difference."2.0.0"."getopts" or false) ||
        (f.difference."2.0.0"."bin" or false) ||
        (difference."2.0.0"."bin" or false); }
      { "2.0.0".default = (f.difference."2.0.0".default or true); }
    ];
  }) [];


# end
# dirs-1.0.5

  crates.dirs."1.0.5" = deps: { features?(features_."dirs"."1.0.5" deps {}) }: buildRustCrate {
    crateName = "dirs";
    version = "1.0.5";
    description = "A tiny low-level library that provides platform-specific standard locations of directories for config, cache and other data on Linux, Windows, macOS and Redox by leveraging the mechanisms defined by the XDG base/user directory specifications on Linux, the Known Folder API on Windows, and the Standard Directory guidelines on macOS.";
    authors = [ "Simon Ochsenreither <simon@ochsenreither.de>" ];
    sha256 = "1py68zwwrhlj5vbz9f9ansjmhc8y4gs5bpamw9ycmqz030pprwf3";
    dependencies = (if kernel == "redox" then mapFeatures features ([
      (crates."redox_users"."${deps."dirs"."1.0.5"."redox_users"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."dirs"."1.0.5"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."dirs"."1.0.5"."winapi"}" deps)
    ]) else []);
  };
  features_."dirs"."1.0.5" = deps: f: updateFeatures f (rec {
    dirs."1.0.5".default = (f.dirs."1.0.5".default or true);
    libc."${deps.dirs."1.0.5".libc}".default = true;
    redox_users."${deps.dirs."1.0.5".redox_users}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.dirs."1.0.5".winapi}"."knownfolders" = true; }
      { "${deps.dirs."1.0.5".winapi}"."objbase" = true; }
      { "${deps.dirs."1.0.5".winapi}"."shlobj" = true; }
      { "${deps.dirs."1.0.5".winapi}"."winbase" = true; }
      { "${deps.dirs."1.0.5".winapi}"."winerror" = true; }
      { "${deps.dirs."1.0.5".winapi}".default = true; }
    ];
  }) [
    (if deps."dirs"."1.0.5" ? "redox_users" then features_.redox_users."${deps."dirs"."1.0.5"."redox_users" or ""}" deps else {})
    (if deps."dirs"."1.0.5" ? "libc" then features_.libc."${deps."dirs"."1.0.5"."libc" or ""}" deps else {})
    (if deps."dirs"."1.0.5" ? "winapi" then features_.winapi."${deps."dirs"."1.0.5"."winapi" or ""}" deps else {})
  ];


# end
# docopt-1.1.0

  crates.docopt."1.1.0" = deps: { features?(features_."docopt"."1.1.0" deps {}) }: buildRustCrate {
    crateName = "docopt";
    version = "1.1.0";
    description = "Command line argument parsing.";
    homepage = "https://github.com/docopt/docopt.rs";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    edition = "2018";
    sha256 = "1xjvfw8398qcxwhdmak1bw2j6zn125ch24dmrmghv50vnlbb997x";
    crateBin =
      [{  name = "docopt-wordlist";  path = "src/wordlist.rs"; }];
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."docopt"."1.1.0"."lazy_static"}" deps)
      (crates."regex"."${deps."docopt"."1.1.0"."regex"}" deps)
      (crates."serde"."${deps."docopt"."1.1.0"."serde"}" deps)
      (crates."strsim"."${deps."docopt"."1.1.0"."strsim"}" deps)
    ]);
  };
  features_."docopt"."1.1.0" = deps: f: updateFeatures f (rec {
    docopt."1.1.0".default = (f.docopt."1.1.0".default or true);
    lazy_static."${deps.docopt."1.1.0".lazy_static}".default = true;
    regex."${deps.docopt."1.1.0".regex}".default = true;
    serde = fold recursiveUpdate {} [
      { "${deps.docopt."1.1.0".serde}"."derive" = true; }
      { "${deps.docopt."1.1.0".serde}".default = true; }
    ];
    strsim."${deps.docopt."1.1.0".strsim}".default = true;
  }) [
    (if deps."docopt"."1.1.0" ? "lazy_static" then features_.lazy_static."${deps."docopt"."1.1.0"."lazy_static" or ""}" deps else {})
    (if deps."docopt"."1.1.0" ? "regex" then features_.regex."${deps."docopt"."1.1.0"."regex" or ""}" deps else {})
    (if deps."docopt"."1.1.0" ? "serde" then features_.serde."${deps."docopt"."1.1.0"."serde" or ""}" deps else {})
    (if deps."docopt"."1.1.0" ? "strsim" then features_.strsim."${deps."docopt"."1.1.0"."strsim" or ""}" deps else {})
  ];


# end
# either-1.5.2

  crates.either."1.5.2" = deps: { features?(features_."either"."1.5.2" deps {}) }: buildRustCrate {
    crateName = "either";
    version = "1.5.2";
    description = "The enum `Either` with variants `Left` and `Right` is a general purpose sum type with two cases.
";
    authors = [ "bluss" ];
    sha256 = "1zqq1057c51f53ga4p9l4dd8ax6md27h1xjrjp2plkvml5iymks5";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."either"."1.5.2" or {});
  };
  features_."either"."1.5.2" = deps: f: updateFeatures f (rec {
    either = fold recursiveUpdate {} [
      { "1.5.2"."use_std" =
        (f.either."1.5.2"."use_std" or false) ||
        (f.either."1.5.2"."default" or false) ||
        (either."1.5.2"."default" or false); }
      { "1.5.2".default = (f.either."1.5.2".default or true); }
    ];
  }) [];


# end
# env_logger-0.6.1

  crates.env_logger."0.6.1" = deps: { features?(features_."env_logger"."0.6.1" deps {}) }: buildRustCrate {
    crateName = "env_logger";
    version = "0.6.1";
    description = "A logging implementation for `log` which is configured via an environment
variable.
";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1d02i2yaqpnmbgw42pf0hd56ddd9jr4zq5yypbmfvc8rs13x0jql";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."env_logger"."0.6.1"."log"}" deps)
    ]
      ++ (if features.env_logger."0.6.1".atty or false then [ (crates.atty."${deps."env_logger"."0.6.1".atty}" deps) ] else [])
      ++ (if features.env_logger."0.6.1".humantime or false then [ (crates.humantime."${deps."env_logger"."0.6.1".humantime}" deps) ] else [])
      ++ (if features.env_logger."0.6.1".regex or false then [ (crates.regex."${deps."env_logger"."0.6.1".regex}" deps) ] else [])
      ++ (if features.env_logger."0.6.1".termcolor or false then [ (crates.termcolor."${deps."env_logger"."0.6.1".termcolor}" deps) ] else []));
    features = mkFeatures (features."env_logger"."0.6.1" or {});
  };
  features_."env_logger"."0.6.1" = deps: f: updateFeatures f (rec {
    env_logger = fold recursiveUpdate {} [
      { "0.6.1"."atty" =
        (f.env_logger."0.6.1"."atty" or false) ||
        (f.env_logger."0.6.1"."default" or false) ||
        (env_logger."0.6.1"."default" or false); }
      { "0.6.1"."humantime" =
        (f.env_logger."0.6.1"."humantime" or false) ||
        (f.env_logger."0.6.1"."default" or false) ||
        (env_logger."0.6.1"."default" or false); }
      { "0.6.1"."regex" =
        (f.env_logger."0.6.1"."regex" or false) ||
        (f.env_logger."0.6.1"."default" or false) ||
        (env_logger."0.6.1"."default" or false); }
      { "0.6.1"."termcolor" =
        (f.env_logger."0.6.1"."termcolor" or false) ||
        (f.env_logger."0.6.1"."default" or false) ||
        (env_logger."0.6.1"."default" or false); }
      { "0.6.1".default = (f.env_logger."0.6.1".default or true); }
    ];
    log = fold recursiveUpdate {} [
      { "${deps.env_logger."0.6.1".log}"."std" = true; }
      { "${deps.env_logger."0.6.1".log}".default = true; }
    ];
  }) [
    (f: if deps."env_logger"."0.6.1" ? "atty" then recursiveUpdate f { atty."${deps."env_logger"."0.6.1"."atty"}"."default" = true; } else f)
    (f: if deps."env_logger"."0.6.1" ? "humantime" then recursiveUpdate f { humantime."${deps."env_logger"."0.6.1"."humantime"}"."default" = true; } else f)
    (f: if deps."env_logger"."0.6.1" ? "regex" then recursiveUpdate f { regex."${deps."env_logger"."0.6.1"."regex"}"."default" = true; } else f)
    (f: if deps."env_logger"."0.6.1" ? "termcolor" then recursiveUpdate f { termcolor."${deps."env_logger"."0.6.1"."termcolor"}"."default" = true; } else f)
    (if deps."env_logger"."0.6.1" ? "atty" then features_.atty."${deps."env_logger"."0.6.1"."atty" or ""}" deps else {})
    (if deps."env_logger"."0.6.1" ? "humantime" then features_.humantime."${deps."env_logger"."0.6.1"."humantime" or ""}" deps else {})
    (if deps."env_logger"."0.6.1" ? "log" then features_.log."${deps."env_logger"."0.6.1"."log" or ""}" deps else {})
    (if deps."env_logger"."0.6.1" ? "regex" then features_.regex."${deps."env_logger"."0.6.1"."regex" or ""}" deps else {})
    (if deps."env_logger"."0.6.1" ? "termcolor" then features_.termcolor."${deps."env_logger"."0.6.1"."termcolor" or ""}" deps else {})
  ];


# end
# escargot-0.4.0

  crates.escargot."0.4.0" = deps: { features?(features_."escargot"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "escargot";
    version = "0.4.0";
    description = "Cargo API written in Paris";
    homepage = "https://github.com/crate-ci/escargot";
    authors = [ "Ed Page <eopage@gmail.com>" ];
    sha256 = "1420y7llg3xr954mva6yyzbh9d7382amlkv2n8j4m92z73czrqmz";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."escargot"."0.4.0"."lazy_static"}" deps)
      (crates."log"."${deps."escargot"."0.4.0"."log"}" deps)
      (crates."serde"."${deps."escargot"."0.4.0"."serde"}" deps)
      (crates."serde_json"."${deps."escargot"."0.4.0"."serde_json"}" deps)
    ]);
    features = mkFeatures (features."escargot"."0.4.0" or {});
  };
  features_."escargot"."0.4.0" = deps: f: updateFeatures f (rec {
    escargot."0.4.0".default = (f.escargot."0.4.0".default or true);
    lazy_static."${deps.escargot."0.4.0".lazy_static}".default = true;
    log."${deps.escargot."0.4.0".log}".default = true;
    serde = fold recursiveUpdate {} [
      { "${deps.escargot."0.4.0".serde}"."derive" = true; }
      { "${deps.escargot."0.4.0".serde}".default = true; }
    ];
    serde_json."${deps.escargot."0.4.0".serde_json}".default = true;
  }) [
    (if deps."escargot"."0.4.0" ? "lazy_static" then features_.lazy_static."${deps."escargot"."0.4.0"."lazy_static" or ""}" deps else {})
    (if deps."escargot"."0.4.0" ? "log" then features_.log."${deps."escargot"."0.4.0"."log" or ""}" deps else {})
    (if deps."escargot"."0.4.0" ? "serde" then features_.serde."${deps."escargot"."0.4.0"."serde" or ""}" deps else {})
    (if deps."escargot"."0.4.0" ? "serde_json" then features_.serde_json."${deps."escargot"."0.4.0"."serde_json" or ""}" deps else {})
  ];


# end
# failure-0.1.5

  crates.failure."0.1.5" = deps: { features?(features_."failure"."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure";
    version = "0.1.5";
    description = "Experimental error handling abstraction.";
    homepage = "https://rust-lang-nursery.github.io/failure/";
    authors = [ "Without Boats <boats@mozilla.com>" ];
    sha256 = "1msaj1c0fg12dzyf4fhxqlx1gfx41lj2smdjmkc9hkrgajk2g3kx";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.failure."0.1.5".backtrace or false then [ (crates.backtrace."${deps."failure"."0.1.5".backtrace}" deps) ] else [])
      ++ (if features.failure."0.1.5".failure_derive or false then [ (crates.failure_derive."${deps."failure"."0.1.5".failure_derive}" deps) ] else []));
    features = mkFeatures (features."failure"."0.1.5" or {});
  };
  features_."failure"."0.1.5" = deps: f: updateFeatures f (rec {
    failure = fold recursiveUpdate {} [
      { "0.1.5"."backtrace" =
        (f.failure."0.1.5"."backtrace" or false) ||
        (f.failure."0.1.5"."std" or false) ||
        (failure."0.1.5"."std" or false); }
      { "0.1.5"."derive" =
        (f.failure."0.1.5"."derive" or false) ||
        (f.failure."0.1.5"."default" or false) ||
        (failure."0.1.5"."default" or false); }
      { "0.1.5"."failure_derive" =
        (f.failure."0.1.5"."failure_derive" or false) ||
        (f.failure."0.1.5"."derive" or false) ||
        (failure."0.1.5"."derive" or false); }
      { "0.1.5"."std" =
        (f.failure."0.1.5"."std" or false) ||
        (f.failure."0.1.5"."default" or false) ||
        (failure."0.1.5"."default" or false); }
      { "0.1.5".default = (f.failure."0.1.5".default or true); }
    ];
  }) [
    (f: if deps."failure"."0.1.5" ? "backtrace" then recursiveUpdate f { backtrace."${deps."failure"."0.1.5"."backtrace"}"."default" = true; } else f)
    (f: if deps."failure"."0.1.5" ? "failure_derive" then recursiveUpdate f { failure_derive."${deps."failure"."0.1.5"."failure_derive"}"."default" = true; } else f)
    (if deps."failure"."0.1.5" ? "backtrace" then features_.backtrace."${deps."failure"."0.1.5"."backtrace" or ""}" deps else {})
    (if deps."failure"."0.1.5" ? "failure_derive" then features_.failure_derive."${deps."failure"."0.1.5"."failure_derive" or ""}" deps else {})
  ];


# end
# failure_derive-0.1.5

  crates.failure_derive."0.1.5" = deps: { features?(features_."failure_derive"."0.1.5" deps {}) }: buildRustCrate {
    crateName = "failure_derive";
    version = "0.1.5";
    description = "derives for the failure crate";
    homepage = "https://rust-lang-nursery.github.io/failure/";
    authors = [ "Without Boats <woboats@gmail.com>" ];
    sha256 = "1wzk484b87r4qszcvdl2bkniv5ls4r2f2dshz7hmgiv6z4ln12g0";
    procMacro = true;
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."failure_derive"."0.1.5"."proc_macro2"}" deps)
      (crates."quote"."${deps."failure_derive"."0.1.5"."quote"}" deps)
      (crates."syn"."${deps."failure_derive"."0.1.5"."syn"}" deps)
      (crates."synstructure"."${deps."failure_derive"."0.1.5"."synstructure"}" deps)
    ]);
    features = mkFeatures (features."failure_derive"."0.1.5" or {});
  };
  features_."failure_derive"."0.1.5" = deps: f: updateFeatures f (rec {
    failure_derive."0.1.5".default = (f.failure_derive."0.1.5".default or true);
    proc_macro2."${deps.failure_derive."0.1.5".proc_macro2}".default = true;
    quote."${deps.failure_derive."0.1.5".quote}".default = true;
    syn."${deps.failure_derive."0.1.5".syn}".default = true;
    synstructure."${deps.failure_derive."0.1.5".synstructure}".default = true;
  }) [
    (if deps."failure_derive"."0.1.5" ? "proc_macro2" then features_.proc_macro2."${deps."failure_derive"."0.1.5"."proc_macro2" or ""}" deps else {})
    (if deps."failure_derive"."0.1.5" ? "quote" then features_.quote."${deps."failure_derive"."0.1.5"."quote" or ""}" deps else {})
    (if deps."failure_derive"."0.1.5" ? "syn" then features_.syn."${deps."failure_derive"."0.1.5"."syn" or ""}" deps else {})
    (if deps."failure_derive"."0.1.5" ? "synstructure" then features_.synstructure."${deps."failure_derive"."0.1.5"."synstructure" or ""}" deps else {})
  ];


# end
# filetime-0.2.5

  crates.filetime."0.2.5" = deps: { features?(features_."filetime"."0.2.5" deps {}) }: buildRustCrate {
    crateName = "filetime";
    version = "0.2.5";
    description = "Platform-agnostic accessors of timestamps in File metadata
";
    homepage = "https://github.com/alexcrichton/filetime";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0x36k69d1cvy0c2mrqrnahjjar8f2iai99cli2jjqxc1qx6kvdl7";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."filetime"."0.2.5"."cfg_if"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."filetime"."0.2.5"."redox_syscall"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."filetime"."0.2.5"."libc"}" deps)
    ]) else []);
  };
  features_."filetime"."0.2.5" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.filetime."0.2.5".cfg_if}".default = true;
    filetime."0.2.5".default = (f.filetime."0.2.5".default or true);
    libc."${deps.filetime."0.2.5".libc}".default = true;
    redox_syscall."${deps.filetime."0.2.5".redox_syscall}".default = true;
  }) [
    (if deps."filetime"."0.2.5" ? "cfg_if" then features_.cfg_if."${deps."filetime"."0.2.5"."cfg_if" or ""}" deps else {})
    (if deps."filetime"."0.2.5" ? "redox_syscall" then features_.redox_syscall."${deps."filetime"."0.2.5"."redox_syscall" or ""}" deps else {})
    (if deps."filetime"."0.2.5" ? "libc" then features_.libc."${deps."filetime"."0.2.5"."libc" or ""}" deps else {})
  ];


# end
# float-cmp-0.4.0

  crates.float_cmp."0.4.0" = deps: { features?(features_."float_cmp"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "float-cmp";
    version = "0.4.0";
    description = "Floating point approximate comparison traits";
    authors = [ "Mike Dilger <mike@mikedilger.com>" ];
    sha256 = "0fvzhjvrq4mwga90x8pchakm3q0q13dyiw2ppks54is0sywij122";
    libPath = "src/lib.rs";
    libName = "float_cmp";
    dependencies = mapFeatures features ([
      (crates."num_traits"."${deps."float_cmp"."0.4.0"."num_traits"}" deps)
    ]);
  };
  features_."float_cmp"."0.4.0" = deps: f: updateFeatures f (rec {
    float_cmp."0.4.0".default = (f.float_cmp."0.4.0".default or true);
    num_traits."${deps.float_cmp."0.4.0".num_traits}".default = (f.num_traits."${deps.float_cmp."0.4.0".num_traits}".default or false);
  }) [
    (if deps."float_cmp"."0.4.0" ? "num_traits" then features_.num_traits."${deps."float_cmp"."0.4.0"."num_traits" or ""}" deps else {})
  ];


# end
# foreign-types-0.3.2

  crates.foreign_types."0.3.2" = deps: { features?(features_."foreign_types"."0.3.2" deps {}) }: buildRustCrate {
    crateName = "foreign-types";
    version = "0.3.2";
    description = "A framework for Rust wrappers over C APIs";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "105n8sp2djb1s5lzrw04p7ss3dchr5qa3canmynx396nh3vwm2p8";
    dependencies = mapFeatures features ([
      (crates."foreign_types_shared"."${deps."foreign_types"."0.3.2"."foreign_types_shared"}" deps)
    ]);
  };
  features_."foreign_types"."0.3.2" = deps: f: updateFeatures f (rec {
    foreign_types."0.3.2".default = (f.foreign_types."0.3.2".default or true);
    foreign_types_shared."${deps.foreign_types."0.3.2".foreign_types_shared}".default = true;
  }) [
    (if deps."foreign_types"."0.3.2" ? "foreign_types_shared" then features_.foreign_types_shared."${deps."foreign_types"."0.3.2"."foreign_types_shared" or ""}" deps else {})
  ];


# end
# foreign-types-shared-0.1.1

  crates.foreign_types_shared."0.1.1" = deps: { features?(features_."foreign_types_shared"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "foreign-types-shared";
    version = "0.1.1";
    description = "An internal crate used by foreign-types";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0b6cnvqbflws8dxywk4589vgbz80049lz4x1g9dfy4s1ppd3g4z5";
  };
  features_."foreign_types_shared"."0.1.1" = deps: f: updateFeatures f (rec {
    foreign_types_shared."0.1.1".default = (f.foreign_types_shared."0.1.1".default or true);
  }) [];


# end
# fuchsia-cprng-0.1.1

  crates.fuchsia_cprng."0.1.1" = deps: { features?(features_."fuchsia_cprng"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "fuchsia-cprng";
    version = "0.1.1";
    description = "Rust crate for the Fuchsia cryptographically secure pseudorandom number generator";
    authors = [ "Erick Tryzelaar <etryzelaar@google.com>" ];
    edition = "2018";
    sha256 = "07apwv9dj716yjlcj29p94vkqn5zmfh7hlrqvrjx3wzshphc95h9";
  };
  features_."fuchsia_cprng"."0.1.1" = deps: f: updateFeatures f (rec {
    fuchsia_cprng."0.1.1".default = (f.fuchsia_cprng."0.1.1".default or true);
  }) [];


# end
# hashbrown-0.1.8

  crates.hashbrown."0.1.8" = deps: { features?(features_."hashbrown"."0.1.8" deps {}) }: buildRustCrate {
    crateName = "hashbrown";
    version = "0.1.8";
    description = "A Rust port of Google's SwissTable hash map";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "047fk80pg59cdn5lz4h2a514fmgmya896dvy3dqqviia52a27fzh";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."hashbrown"."0.1.8"."byteorder"}" deps)
      (crates."scopeguard"."${deps."hashbrown"."0.1.8"."scopeguard"}" deps)
    ]);
    features = mkFeatures (features."hashbrown"."0.1.8" or {});
  };
  features_."hashbrown"."0.1.8" = deps: f: updateFeatures f (rec {
    byteorder."${deps.hashbrown."0.1.8".byteorder}".default = (f.byteorder."${deps.hashbrown."0.1.8".byteorder}".default or false);
    hashbrown."0.1.8".default = (f.hashbrown."0.1.8".default or true);
    scopeguard."${deps.hashbrown."0.1.8".scopeguard}".default = (f.scopeguard."${deps.hashbrown."0.1.8".scopeguard}".default or false);
  }) [
    (if deps."hashbrown"."0.1.8" ? "byteorder" then features_.byteorder."${deps."hashbrown"."0.1.8"."byteorder" or ""}" deps else {})
    (if deps."hashbrown"."0.1.8" ? "scopeguard" then features_.scopeguard."${deps."hashbrown"."0.1.8"."scopeguard" or ""}" deps else {})
  ];


# end
# heck-0.3.1

  crates.heck."0.3.1" = deps: { features?(features_."heck"."0.3.1" deps {}) }: buildRustCrate {
    crateName = "heck";
    version = "0.3.1";
    description = "heck is a case conversion library.";
    homepage = "https://github.com/withoutboats/heck";
    authors = [ "Without Boats <woboats@gmail.com>" ];
    sha256 = "1q7vmnlh62kls6cvkfhbcacxkawaznaqa5wwm9dg1xkcza846c3d";
    dependencies = mapFeatures features ([
      (crates."unicode_segmentation"."${deps."heck"."0.3.1"."unicode_segmentation"}" deps)
    ]);
  };
  features_."heck"."0.3.1" = deps: f: updateFeatures f (rec {
    heck."0.3.1".default = (f.heck."0.3.1".default or true);
    unicode_segmentation."${deps.heck."0.3.1".unicode_segmentation}".default = true;
  }) [
    (if deps."heck"."0.3.1" ? "unicode_segmentation" then features_.unicode_segmentation."${deps."heck"."0.3.1"."unicode_segmentation" or ""}" deps else {})
  ];


# end
# httparse-1.3.3

  crates.httparse."1.3.3" = deps: { features?(features_."httparse"."1.3.3" deps {}) }: buildRustCrate {
    crateName = "httparse";
    version = "1.3.3";
    description = "A tiny, safe, speedy, zero-copy HTTP/1.x parser.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1jymxy4bl0mzgp2dx0pzqzbr72sw5jmr5sjqiry4xr88z4z9qlyx";
    build = "build.rs";
    features = mkFeatures (features."httparse"."1.3.3" or {});
  };
  features_."httparse"."1.3.3" = deps: f: updateFeatures f (rec {
    httparse = fold recursiveUpdate {} [
      { "1.3.3"."std" =
        (f.httparse."1.3.3"."std" or false) ||
        (f.httparse."1.3.3"."default" or false) ||
        (httparse."1.3.3"."default" or false); }
      { "1.3.3".default = (f.httparse."1.3.3".default or true); }
    ];
  }) [];


# end
# humantime-1.2.0

  crates.humantime."1.2.0" = deps: { features?(features_."humantime"."1.2.0" deps {}) }: buildRustCrate {
    crateName = "humantime";
    version = "1.2.0";
    description = "    A parser and formatter for std::time::{Duration, SystemTime}
";
    homepage = "https://github.com/tailhook/humantime";
    authors = [ "Paul Colomiets <paul@colomiets.name>" ];
    sha256 = "0wlcxzz2mhq0brkfbjb12hc6jm17bgm8m6pdgblw4qjwmf26aw28";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."quick_error"."${deps."humantime"."1.2.0"."quick_error"}" deps)
    ]);
  };
  features_."humantime"."1.2.0" = deps: f: updateFeatures f (rec {
    humantime."1.2.0".default = (f.humantime."1.2.0".default or true);
    quick_error."${deps.humantime."1.2.0".quick_error}".default = true;
  }) [
    (if deps."humantime"."1.2.0" ? "quick_error" then features_.quick_error."${deps."humantime"."1.2.0"."quick_error" or ""}" deps else {})
  ];


# end
# id-arena-2.2.1

  crates.id_arena."2.2.1" = deps: { features?(features_."id_arena"."2.2.1" deps {}) }: buildRustCrate {
    crateName = "id-arena";
    version = "2.2.1";
    description = "A simple, id-based arena.";
    authors = [ "Nick Fitzgerald <fitzgen@gmail.com>" "Aleksey Kladov <aleksey.kladov@gmail.com>" ];
    sha256 = "1yrjhk4rbnm0ngglpj1krjmnaj62zhwjr1szrjmmhb1k7lzjp26v";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.id_arena."2.2.1".rayon or false then [ (crates.rayon."${deps."id_arena"."2.2.1".rayon}" deps) ] else []));
    features = mkFeatures (features."id_arena"."2.2.1" or {});
  };
  features_."id_arena"."2.2.1" = deps: f: updateFeatures f (rec {
    id_arena = fold recursiveUpdate {} [
      { "2.2.1"."std" =
        (f.id_arena."2.2.1"."std" or false) ||
        (f.id_arena."2.2.1"."default" or false) ||
        (id_arena."2.2.1"."default" or false); }
      { "2.2.1".default = (f.id_arena."2.2.1".default or true); }
    ];
  }) [
    (f: if deps."id_arena"."2.2.1" ? "rayon" then recursiveUpdate f { rayon."${deps."id_arena"."2.2.1"."rayon"}"."default" = true; } else f)
    (if deps."id_arena"."2.2.1" ? "rayon" then features_.rayon."${deps."id_arena"."2.2.1"."rayon" or ""}" deps else {})
  ];


# end
# idna-0.1.5

  crates.idna."0.1.5" = deps: { features?(features_."idna"."0.1.5" deps {}) }: buildRustCrate {
    crateName = "idna";
    version = "0.1.5";
    description = "IDNA (Internationalizing Domain Names in Applications) and Punycode.";
    authors = [ "The rust-url developers" ];
    sha256 = "1gwgl19rz5vzi67rrhamczhxy050f5ynx4ybabfapyalv7z1qmjy";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."idna"."0.1.5"."matches"}" deps)
      (crates."unicode_bidi"."${deps."idna"."0.1.5"."unicode_bidi"}" deps)
      (crates."unicode_normalization"."${deps."idna"."0.1.5"."unicode_normalization"}" deps)
    ]);
  };
  features_."idna"."0.1.5" = deps: f: updateFeatures f (rec {
    idna."0.1.5".default = (f.idna."0.1.5".default or true);
    matches."${deps.idna."0.1.5".matches}".default = true;
    unicode_bidi."${deps.idna."0.1.5".unicode_bidi}".default = true;
    unicode_normalization."${deps.idna."0.1.5".unicode_normalization}".default = true;
  }) [
    (if deps."idna"."0.1.5" ? "matches" then features_.matches."${deps."idna"."0.1.5"."matches" or ""}" deps else {})
    (if deps."idna"."0.1.5" ? "unicode_bidi" then features_.unicode_bidi."${deps."idna"."0.1.5"."unicode_bidi" or ""}" deps else {})
    (if deps."idna"."0.1.5" ? "unicode_normalization" then features_.unicode_normalization."${deps."idna"."0.1.5"."unicode_normalization" or ""}" deps else {})
  ];


# end
# itertools-0.7.11

  crates.itertools."0.7.11" = deps: { features?(features_."itertools"."0.7.11" deps {}) }: buildRustCrate {
    crateName = "itertools";
    version = "0.7.11";
    description = "Extra iterator adaptors, iterator methods, free functions, and macros.";
    authors = [ "bluss" ];
    sha256 = "0gavmkvn2c3cwfwk5zl5p7saiqn4ww227am5ykn6pgfm7c6ppz56";
    dependencies = mapFeatures features ([
      (crates."either"."${deps."itertools"."0.7.11"."either"}" deps)
    ]);
    features = mkFeatures (features."itertools"."0.7.11" or {});
  };
  features_."itertools"."0.7.11" = deps: f: updateFeatures f (rec {
    either."${deps.itertools."0.7.11".either}".default = (f.either."${deps.itertools."0.7.11".either}".default or false);
    itertools = fold recursiveUpdate {} [
      { "0.7.11"."use_std" =
        (f.itertools."0.7.11"."use_std" or false) ||
        (f.itertools."0.7.11"."default" or false) ||
        (itertools."0.7.11"."default" or false); }
      { "0.7.11".default = (f.itertools."0.7.11".default or true); }
    ];
  }) [
    (if deps."itertools"."0.7.11" ? "either" then features_.either."${deps."itertools"."0.7.11"."either" or ""}" deps else {})
  ];


# end
# itoa-0.4.4

  crates.itoa."0.4.4" = deps: { features?(features_."itoa"."0.4.4" deps {}) }: buildRustCrate {
    crateName = "itoa";
    version = "0.4.4";
    description = "Fast functions for printing integer primitives to an io::Write";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1fqc34xzzl2spfdawxd9awhzl0fwf1y6y4i94l8bq8rfrzd90awl";
    features = mkFeatures (features."itoa"."0.4.4" or {});
  };
  features_."itoa"."0.4.4" = deps: f: updateFeatures f (rec {
    itoa = fold recursiveUpdate {} [
      { "0.4.4"."std" =
        (f.itoa."0.4.4"."std" or false) ||
        (f.itoa."0.4.4"."default" or false) ||
        (itoa."0.4.4"."default" or false); }
      { "0.4.4".default = (f.itoa."0.4.4".default or true); }
    ];
  }) [];


# end
# kernel32-sys-0.2.2

  crates.kernel32_sys."0.2.2" = deps: { features?(features_."kernel32_sys"."0.2.2" deps {}) }: buildRustCrate {
    crateName = "kernel32-sys";
    version = "0.2.2";
    description = "Contains function definitions for the Windows API library kernel32. See winapi for types and constants.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lrw1hbinyvr6cp28g60z97w32w8vsk6pahk64pmrv2fmby8srfj";
    libName = "kernel32";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."kernel32_sys"."0.2.2"."winapi"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."winapi_build"."${deps."kernel32_sys"."0.2.2"."winapi_build"}" deps)
    ]);
  };
  features_."kernel32_sys"."0.2.2" = deps: f: updateFeatures f (rec {
    kernel32_sys."0.2.2".default = (f.kernel32_sys."0.2.2".default or true);
    winapi."${deps.kernel32_sys."0.2.2".winapi}".default = true;
    winapi_build."${deps.kernel32_sys."0.2.2".winapi_build}".default = true;
  }) [
    (if deps."kernel32_sys"."0.2.2" ? "winapi" then features_.winapi."${deps."kernel32_sys"."0.2.2"."winapi" or ""}" deps else {})
    (if deps."kernel32_sys"."0.2.2" ? "winapi_build" then features_.winapi_build."${deps."kernel32_sys"."0.2.2"."winapi_build" or ""}" deps else {})
  ];


# end
# lazy_static-1.3.0

  crates.lazy_static."1.3.0" = deps: { features?(features_."lazy_static"."1.3.0" deps {}) }: buildRustCrate {
    crateName = "lazy_static";
    version = "1.3.0";
    description = "A macro for declaring lazily evaluated statics in Rust.";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1vv47va18ydk7dx5paz88g3jy1d3lwbx6qpxkbj8gyfv770i4b1y";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."lazy_static"."1.3.0" or {});
  };
  features_."lazy_static"."1.3.0" = deps: f: updateFeatures f (rec {
    lazy_static = fold recursiveUpdate {} [
      { "1.3.0"."spin" =
        (f.lazy_static."1.3.0"."spin" or false) ||
        (f.lazy_static."1.3.0"."spin_no_std" or false) ||
        (lazy_static."1.3.0"."spin_no_std" or false); }
      { "1.3.0".default = (f.lazy_static."1.3.0".default or true); }
    ];
  }) [];


# end
# leb128-0.2.3

  crates.leb128."0.2.3" = deps: { features?(features_."leb128"."0.2.3" deps {}) }: buildRustCrate {
    crateName = "leb128";
    version = "0.2.3";
    description = "Read and write DWARF's \\\"Little Endian Base 128\\\" (LEB128) variable length integer encoding.";
    authors = [ "Nick Fitzgerald <fitzgen@gmail.com>" "Philip Craig <philipjcraig@gmail.com>" ];
    sha256 = "1xvi3f3cq3jlsyzw5xvr8nmh5ywic8382iy7r7gr5ddl4p979gf2";
    features = mkFeatures (features."leb128"."0.2.3" or {});
  };
  features_."leb128"."0.2.3" = deps: f: updateFeatures f (rec {
    leb128."0.2.3".default = (f.leb128."0.2.3".default or true);
  }) [];


# end
# libc-0.2.54

  crates.libc."0.2.54" = deps: { features?(features_."libc"."0.2.54" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.54";
    description = "Raw FFI bindings to platform libraries like libc.
";
    homepage = "https://github.com/rust-lang/libc";
    authors = [ "The Rust Project Developers" ];
    sha256 = "11nrsbpmwcnfrjcds0wnicwwql3809nq6q6z00q920bdpryyaf58";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.54" or {});
  };
  features_."libc"."0.2.54" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.54"."align" =
        (f.libc."0.2.54"."align" or false) ||
        (f.libc."0.2.54"."rustc-dep-of-std" or false) ||
        (libc."0.2.54"."rustc-dep-of-std" or false); }
      { "0.2.54"."rustc-std-workspace-core" =
        (f.libc."0.2.54"."rustc-std-workspace-core" or false) ||
        (f.libc."0.2.54"."rustc-dep-of-std" or false) ||
        (libc."0.2.54"."rustc-dep-of-std" or false); }
      { "0.2.54"."use_std" =
        (f.libc."0.2.54"."use_std" or false) ||
        (f.libc."0.2.54"."default" or false) ||
        (libc."0.2.54"."default" or false); }
      { "0.2.54".default = (f.libc."0.2.54".default or true); }
    ];
  }) [];


# end
# libz-sys-1.0.25

  crates.libz_sys."1.0.25" = deps: { features?(features_."libz_sys"."1.0.25" deps {}) }: buildRustCrate {
    crateName = "libz-sys";
    version = "1.0.25";
    description = "Bindings to the system libz library (also known as zlib).
";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "195jzg8mgjbvmkbpx1rzkzrqm0g2fdivk79v44c9lzl64r3f9fym";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."libz_sys"."1.0.25"."libc"}" deps)
    ])
      ++ (if abi == "msvc" then mapFeatures features ([
]) else []);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."libz_sys"."1.0.25"."cc"}" deps)
      (crates."pkg_config"."${deps."libz_sys"."1.0.25"."pkg_config"}" deps)
    ]);
    features = mkFeatures (features."libz_sys"."1.0.25" or {});
  };
  features_."libz_sys"."1.0.25" = deps: f: updateFeatures f (rec {
    cc."${deps.libz_sys."1.0.25".cc}".default = true;
    libc."${deps.libz_sys."1.0.25".libc}".default = true;
    libz_sys."1.0.25".default = (f.libz_sys."1.0.25".default or true);
    pkg_config."${deps.libz_sys."1.0.25".pkg_config}".default = true;
  }) [
    (if deps."libz_sys"."1.0.25" ? "libc" then features_.libc."${deps."libz_sys"."1.0.25"."libc" or ""}" deps else {})
    (if deps."libz_sys"."1.0.25" ? "cc" then features_.cc."${deps."libz_sys"."1.0.25"."cc" or ""}" deps else {})
    (if deps."libz_sys"."1.0.25" ? "pkg_config" then features_.pkg_config."${deps."libz_sys"."1.0.25"."pkg_config" or ""}" deps else {})
  ];


# end
# log-0.3.9

  crates.log."0.3.9" = deps: { features?(features_."log"."0.3.9" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.3.9";
    description = "A lightweight logging facade for Rust
";
    homepage = "https://github.com/rust-lang/log";
    authors = [ "The Rust Project Developers" ];
    sha256 = "19i9pwp7lhaqgzangcpw00kc3zsgcqcx84crv07xgz3v7d3kvfa2";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."log"."0.3.9"."log"}" deps)
    ]);
    features = mkFeatures (features."log"."0.3.9" or {});
  };
  features_."log"."0.3.9" = deps: f: updateFeatures f (rec {
    log = fold recursiveUpdate {} [
      { "${deps.log."0.3.9".log}"."max_level_debug" =
        (f.log."${deps.log."0.3.9".log}"."max_level_debug" or false) ||
        (log."0.3.9"."max_level_debug" or false) ||
        (f."log"."0.3.9"."max_level_debug" or false); }
      { "${deps.log."0.3.9".log}"."max_level_error" =
        (f.log."${deps.log."0.3.9".log}"."max_level_error" or false) ||
        (log."0.3.9"."max_level_error" or false) ||
        (f."log"."0.3.9"."max_level_error" or false); }
      { "${deps.log."0.3.9".log}"."max_level_info" =
        (f.log."${deps.log."0.3.9".log}"."max_level_info" or false) ||
        (log."0.3.9"."max_level_info" or false) ||
        (f."log"."0.3.9"."max_level_info" or false); }
      { "${deps.log."0.3.9".log}"."max_level_off" =
        (f.log."${deps.log."0.3.9".log}"."max_level_off" or false) ||
        (log."0.3.9"."max_level_off" or false) ||
        (f."log"."0.3.9"."max_level_off" or false); }
      { "${deps.log."0.3.9".log}"."max_level_trace" =
        (f.log."${deps.log."0.3.9".log}"."max_level_trace" or false) ||
        (log."0.3.9"."max_level_trace" or false) ||
        (f."log"."0.3.9"."max_level_trace" or false); }
      { "${deps.log."0.3.9".log}"."max_level_warn" =
        (f.log."${deps.log."0.3.9".log}"."max_level_warn" or false) ||
        (log."0.3.9"."max_level_warn" or false) ||
        (f."log"."0.3.9"."max_level_warn" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_debug" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_debug" or false) ||
        (log."0.3.9"."release_max_level_debug" or false) ||
        (f."log"."0.3.9"."release_max_level_debug" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_error" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_error" or false) ||
        (log."0.3.9"."release_max_level_error" or false) ||
        (f."log"."0.3.9"."release_max_level_error" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_info" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_info" or false) ||
        (log."0.3.9"."release_max_level_info" or false) ||
        (f."log"."0.3.9"."release_max_level_info" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_off" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_off" or false) ||
        (log."0.3.9"."release_max_level_off" or false) ||
        (f."log"."0.3.9"."release_max_level_off" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_trace" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_trace" or false) ||
        (log."0.3.9"."release_max_level_trace" or false) ||
        (f."log"."0.3.9"."release_max_level_trace" or false); }
      { "${deps.log."0.3.9".log}"."release_max_level_warn" =
        (f.log."${deps.log."0.3.9".log}"."release_max_level_warn" or false) ||
        (log."0.3.9"."release_max_level_warn" or false) ||
        (f."log"."0.3.9"."release_max_level_warn" or false); }
      { "${deps.log."0.3.9".log}"."std" =
        (f.log."${deps.log."0.3.9".log}"."std" or false) ||
        (log."0.3.9"."use_std" or false) ||
        (f."log"."0.3.9"."use_std" or false); }
      { "${deps.log."0.3.9".log}".default = true; }
      { "0.3.9"."use_std" =
        (f.log."0.3.9"."use_std" or false) ||
        (f.log."0.3.9"."default" or false) ||
        (log."0.3.9"."default" or false); }
      { "0.3.9".default = (f.log."0.3.9".default or true); }
    ];
  }) [
    (if deps."log"."0.3.9" ? "log" then features_.log."${deps."log"."0.3.9"."log" or ""}" deps else {})
  ];


# end
# log-0.4.6

  crates.log."0.4.6" = deps: { features?(features_."log"."0.4.6" deps {}) }: buildRustCrate {
    crateName = "log";
    version = "0.4.6";
    description = "A lightweight logging facade for Rust
";
    homepage = "https://github.com/rust-lang/log";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1nd8dl9mvc9vd6fks5d4gsxaz990xi6rzlb8ymllshmwi153vngr";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."log"."0.4.6"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."log"."0.4.6" or {});
  };
  features_."log"."0.4.6" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.log."0.4.6".cfg_if}".default = true;
    log."0.4.6".default = (f.log."0.4.6".default or true);
  }) [
    (if deps."log"."0.4.6" ? "cfg_if" then features_.cfg_if."${deps."log"."0.4.6"."cfg_if" or ""}" deps else {})
  ];


# end
# matches-0.1.8

  crates.matches."0.1.8" = deps: { features?(features_."matches"."0.1.8" deps {}) }: buildRustCrate {
    crateName = "matches";
    version = "0.1.8";
    description = "A macro to evaluate, as a boolean, whether an expression matches a pattern.";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "03hl636fg6xggy0a26200xs74amk3k9n0908rga2szn68agyz3cv";
    libPath = "lib.rs";
  };
  features_."matches"."0.1.8" = deps: f: updateFeatures f (rec {
    matches."0.1.8".default = (f.matches."0.1.8".default or true);
  }) [];


# end
# matrixmultiply-0.1.15

  crates.matrixmultiply."0.1.15" = deps: { features?(features_."matrixmultiply"."0.1.15" deps {}) }: buildRustCrate {
    crateName = "matrixmultiply";
    version = "0.1.15";
    description = "General matrix multiplication of f32 and f64 matrices in Rust. Supports matrices with general strides. Uses a microkernel strategy, so that the implementation is easy to parallelize and optimize. `RUSTFLAGS=\\\"-C target-cpu=native\\\"` is your friend here.";
    authors = [ "bluss" ];
    sha256 = "0ix1i4lnkfqnzv8f9wr34bf0mlr1sx5hr7yr70k4npxmwxscvdj5";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rawpointer"."${deps."matrixmultiply"."0.1.15"."rawpointer"}" deps)
    ]);
  };
  features_."matrixmultiply"."0.1.15" = deps: f: updateFeatures f (rec {
    matrixmultiply."0.1.15".default = (f.matrixmultiply."0.1.15".default or true);
    rawpointer."${deps.matrixmultiply."0.1.15".rawpointer}".default = true;
  }) [
    (if deps."matrixmultiply"."0.1.15" ? "rawpointer" then features_.rawpointer."${deps."matrixmultiply"."0.1.15"."rawpointer" or ""}" deps else {})
  ];


# end
# memchr-2.2.0

  crates.memchr."2.2.0" = deps: { features?(features_."memchr"."2.2.0" deps {}) }: buildRustCrate {
    crateName = "memchr";
    version = "2.2.0";
    description = "Safe interface to memchr.";
    homepage = "https://github.com/BurntSushi/rust-memchr";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" "bluss" ];
    sha256 = "11vwg8iig9jyjxq3n1cq15g29ikzw5l7ar87md54k1aisjs0997p";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."memchr"."2.2.0" or {});
  };
  features_."memchr"."2.2.0" = deps: f: updateFeatures f (rec {
    memchr = fold recursiveUpdate {} [
      { "2.2.0"."use_std" =
        (f.memchr."2.2.0"."use_std" or false) ||
        (f.memchr."2.2.0"."default" or false) ||
        (memchr."2.2.0"."default" or false); }
      { "2.2.0".default = (f.memchr."2.2.0".default or true); }
    ];
  }) [];


# end
# memoffset-0.2.1

  crates.memoffset."0.2.1" = deps: { features?(features_."memoffset"."0.2.1" deps {}) }: buildRustCrate {
    crateName = "memoffset";
    version = "0.2.1";
    description = "offset_of functionality for Rust structs.";
    authors = [ "Gilad Naaman <gilad.naaman@gmail.com>" ];
    sha256 = "00vym01jk9slibq2nsiilgffp7n6k52a4q3n4dqp0xf5kzxvffcf";
  };
  features_."memoffset"."0.2.1" = deps: f: updateFeatures f (rec {
    memoffset."0.2.1".default = (f.memoffset."0.2.1".default or true);
  }) [];


# end
# mime-0.2.6

  crates.mime."0.2.6" = deps: { features?(features_."mime"."0.2.6" deps {}) }: buildRustCrate {
    crateName = "mime";
    version = "0.2.6";
    description = "Strongly Typed Mimes";
    authors = [ "Sean McArthur <sean.monstar@gmail.com>" ];
    sha256 = "1skwwa0j3kqd8rm9387zgabjhp07zj99q71nzlhba4lrz9r911b3";
    dependencies = mapFeatures features ([
      (crates."log"."${deps."mime"."0.2.6"."log"}" deps)
    ]);
    features = mkFeatures (features."mime"."0.2.6" or {});
  };
  features_."mime"."0.2.6" = deps: f: updateFeatures f (rec {
    log."${deps.mime."0.2.6".log}".default = true;
    mime = fold recursiveUpdate {} [
      { "0.2.6"."heapsize" =
        (f.mime."0.2.6"."heapsize" or false) ||
        (f.mime."0.2.6"."heap_size" or false) ||
        (mime."0.2.6"."heap_size" or false); }
      { "0.2.6".default = (f.mime."0.2.6".default or true); }
    ];
  }) [
    (if deps."mime"."0.2.6" ? "log" then features_.log."${deps."mime"."0.2.6"."log" or ""}" deps else {})
  ];


# end
# mime_guess-1.8.7

  crates.mime_guess."1.8.7" = deps: { features?(features_."mime_guess"."1.8.7" deps {}) }: buildRustCrate {
    crateName = "mime_guess";
    version = "1.8.7";
    description = "A simple crate for detection of a file's MIME type by its extension.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "0l0l3iz8y536m6v3gvbs24sk0ij2ma4ngrvlc0kqpgr3yly1h82r";
    dependencies = mapFeatures features ([
      (crates."mime"."${deps."mime_guess"."1.8.7"."mime"}" deps)
      (crates."phf"."${deps."mime_guess"."1.8.7"."phf"}" deps)
      (crates."unicase"."${deps."mime_guess"."1.8.7"."unicase"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."phf_codegen"."${deps."mime_guess"."1.8.7"."phf_codegen"}" deps)
      (crates."unicase"."${deps."mime_guess"."1.8.7"."unicase"}" deps)
    ]);
    features = mkFeatures (features."mime_guess"."1.8.7" or {});
  };
  features_."mime_guess"."1.8.7" = deps: f: updateFeatures f (rec {
    mime."${deps.mime_guess."1.8.7".mime}".default = true;
    mime_guess."1.8.7".default = (f.mime_guess."1.8.7".default or true);
    phf = fold recursiveUpdate {} [
      { "${deps.mime_guess."1.8.7".phf}"."unicase" = true; }
      { "${deps.mime_guess."1.8.7".phf}".default = true; }
    ];
    phf_codegen."${deps.mime_guess."1.8.7".phf_codegen}".default = true;
    unicase."${deps.mime_guess."1.8.7".unicase}".default = true;
  }) [
    (if deps."mime_guess"."1.8.7" ? "mime" then features_.mime."${deps."mime_guess"."1.8.7"."mime" or ""}" deps else {})
    (if deps."mime_guess"."1.8.7" ? "phf" then features_.phf."${deps."mime_guess"."1.8.7"."phf" or ""}" deps else {})
    (if deps."mime_guess"."1.8.7" ? "unicase" then features_.unicase."${deps."mime_guess"."1.8.7"."unicase" or ""}" deps else {})
    (if deps."mime_guess"."1.8.7" ? "phf_codegen" then features_.phf_codegen."${deps."mime_guess"."1.8.7"."phf_codegen" or ""}" deps else {})
    (if deps."mime_guess"."1.8.7" ? "unicase" then features_.unicase."${deps."mime_guess"."1.8.7"."unicase" or ""}" deps else {})
  ];


# end
# multipart-0.15.4

  crates.multipart."0.15.4" = deps: { features?(features_."multipart"."0.15.4" deps {}) }: buildRustCrate {
    crateName = "multipart";
    version = "0.15.4";
    description = "A backend-agnostic extension for HTTP libraries that provides support for POST multipart/form-data requests on both client and server.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "18nrr8319hf3bxrly4w87j24bnkmz30r6ywjlpjgb4676wyc55wg";
    crateBin =
      (if features."multipart"."0.15.4"."mock" && features."multipart"."0.15.4"."hyper" && features."multipart"."0.15.4"."server" then [{  name = "form_test"; } ] else []);
    dependencies = mapFeatures features ([
      (crates."log"."${deps."multipart"."0.15.4"."log"}" deps)
      (crates."mime"."${deps."multipart"."0.15.4"."mime"}" deps)
      (crates."mime_guess"."${deps."multipart"."0.15.4"."mime_guess"}" deps)
      (crates."rand"."${deps."multipart"."0.15.4"."rand"}" deps)
      (crates."tempdir"."${deps."multipart"."0.15.4"."tempdir"}" deps)
    ]
      ++ (if features.multipart."0.15.4".buf_redux or false then [ (crates.buf_redux."${deps."multipart"."0.15.4".buf_redux}" deps) ] else [])
      ++ (if features.multipart."0.15.4".httparse or false then [ (crates.httparse."${deps."multipart"."0.15.4".httparse}" deps) ] else [])
      ++ (if features.multipart."0.15.4".quick-error or false then [ (crates.quick_error."${deps."multipart"."0.15.4".quick_error}" deps) ] else [])
      ++ (if features.multipart."0.15.4".safemem or false then [ (crates.safemem."${deps."multipart"."0.15.4".safemem}" deps) ] else [])
      ++ (if features.multipart."0.15.4".twoway or false then [ (crates.twoway."${deps."multipart"."0.15.4".twoway}" deps) ] else []));
    features = mkFeatures (features."multipart"."0.15.4" or {});
  };
  features_."multipart"."0.15.4" = deps: f: updateFeatures f (rec {
    log."${deps.multipart."0.15.4".log}".default = true;
    mime."${deps.multipart."0.15.4".mime}".default = true;
    mime_guess."${deps.multipart."0.15.4".mime_guess}".default = true;
    multipart = fold recursiveUpdate {} [
      { "0.15.4"."buf_redux" =
        (f.multipart."0.15.4"."buf_redux" or false) ||
        (f.multipart."0.15.4"."server" or false) ||
        (multipart."0.15.4"."server" or false); }
      { "0.15.4"."client" =
        (f.multipart."0.15.4"."client" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."httparse" =
        (f.multipart."0.15.4"."httparse" or false) ||
        (f.multipart."0.15.4"."server" or false) ||
        (multipart."0.15.4"."server" or false); }
      { "0.15.4"."hyper" =
        (f.multipart."0.15.4"."hyper" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."iron" =
        (f.multipart."0.15.4"."iron" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."mock" =
        (f.multipart."0.15.4"."mock" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."nickel" =
        (f.multipart."0.15.4"."nickel" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."nightly" =
        (f.multipart."0.15.4"."nightly" or false) ||
        (f.multipart."0.15.4"."sse4" or false) ||
        (multipart."0.15.4"."sse4" or false); }
      { "0.15.4"."quick-error" =
        (f.multipart."0.15.4"."quick-error" or false) ||
        (f.multipart."0.15.4"."server" or false) ||
        (multipart."0.15.4"."server" or false); }
      { "0.15.4"."safemem" =
        (f.multipart."0.15.4"."safemem" or false) ||
        (f.multipart."0.15.4"."server" or false) ||
        (multipart."0.15.4"."server" or false); }
      { "0.15.4"."server" =
        (f.multipart."0.15.4"."server" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."tiny_http" =
        (f.multipart."0.15.4"."tiny_http" or false) ||
        (f.multipart."0.15.4"."default" or false) ||
        (multipart."0.15.4"."default" or false); }
      { "0.15.4"."twoway" =
        (f.multipart."0.15.4"."twoway" or false) ||
        (f.multipart."0.15.4"."server" or false) ||
        (multipart."0.15.4"."server" or false); }
      { "0.15.4".default = (f.multipart."0.15.4".default or true); }
    ];
    rand."${deps.multipart."0.15.4".rand}".default = true;
    tempdir."${deps.multipart."0.15.4".tempdir}".default = true;
    twoway."${deps.multipart."0.15.4".twoway}"."pcmp" =
        (f.twoway."${deps.multipart."0.15.4".twoway}"."pcmp" or false) ||
        (multipart."0.15.4"."sse4" or false) ||
        (f."multipart"."0.15.4"."sse4" or false);
  }) [
    (f: if deps."multipart"."0.15.4" ? "buf_redux" then recursiveUpdate f { buf_redux."${deps."multipart"."0.15.4"."buf_redux"}"."default" = false; } else f)
    (f: if deps."multipart"."0.15.4" ? "httparse" then recursiveUpdate f { httparse."${deps."multipart"."0.15.4"."httparse"}"."default" = true; } else f)
    (f: if deps."multipart"."0.15.4" ? "quick_error" then recursiveUpdate f { quick_error."${deps."multipart"."0.15.4"."quick_error"}"."default" = true; } else f)
    (f: if deps."multipart"."0.15.4" ? "safemem" then recursiveUpdate f { safemem."${deps."multipart"."0.15.4"."safemem"}"."default" = true; } else f)
    (f: if deps."multipart"."0.15.4" ? "twoway" then recursiveUpdate f { twoway."${deps."multipart"."0.15.4"."twoway"}"."default" = true; } else f)
    (if deps."multipart"."0.15.4" ? "buf_redux" then features_.buf_redux."${deps."multipart"."0.15.4"."buf_redux" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "httparse" then features_.httparse."${deps."multipart"."0.15.4"."httparse" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "log" then features_.log."${deps."multipart"."0.15.4"."log" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "mime" then features_.mime."${deps."multipart"."0.15.4"."mime" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "mime_guess" then features_.mime_guess."${deps."multipart"."0.15.4"."mime_guess" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "quick_error" then features_.quick_error."${deps."multipart"."0.15.4"."quick_error" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "rand" then features_.rand."${deps."multipart"."0.15.4"."rand" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "safemem" then features_.safemem."${deps."multipart"."0.15.4"."safemem" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "tempdir" then features_.tempdir."${deps."multipart"."0.15.4"."tempdir" or ""}" deps else {})
    (if deps."multipart"."0.15.4" ? "twoway" then features_.twoway."${deps."multipart"."0.15.4"."twoway" or ""}" deps else {})
  ];


# end
# ndarray-0.12.1

  crates.ndarray."0.12.1" = deps: { features?(features_."ndarray"."0.12.1" deps {}) }: buildRustCrate {
    crateName = "ndarray";
    version = "0.12.1";
    description = "An n-dimensional array for general elements and for numerics. Lightweight array views and slicing; views support chunking and splitting.";
    authors = [ "bluss" "Jim Turner" ];
    sha256 = "13708k97kdjfj6g4z1yapjln0v4m7zj0114h8snw44fj79l00346";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."itertools"."${deps."ndarray"."0.12.1"."itertools"}" deps)
      (crates."matrixmultiply"."${deps."ndarray"."0.12.1"."matrixmultiply"}" deps)
      (crates."num_complex"."${deps."ndarray"."0.12.1"."num_complex"}" deps)
      (crates."num_traits"."${deps."ndarray"."0.12.1"."num_traits"}" deps)
    ]);
    features = mkFeatures (features."ndarray"."0.12.1" or {});
  };
  features_."ndarray"."0.12.1" = deps: f: updateFeatures f (rec {
    itertools."${deps.ndarray."0.12.1".itertools}".default = (f.itertools."${deps.ndarray."0.12.1".itertools}".default or false);
    matrixmultiply."${deps.ndarray."0.12.1".matrixmultiply}".default = true;
    ndarray = fold recursiveUpdate {} [
      { "0.12.1"."blas" =
        (f.ndarray."0.12.1"."blas" or false) ||
        (f.ndarray."0.12.1"."test-blas-openblas-sys" or false) ||
        (ndarray."0.12.1"."test-blas-openblas-sys" or false); }
      { "0.12.1"."blas-src" =
        (f.ndarray."0.12.1"."blas-src" or false) ||
        (f.ndarray."0.12.1"."blas" or false) ||
        (ndarray."0.12.1"."blas" or false); }
      { "0.12.1"."cblas-sys" =
        (f.ndarray."0.12.1"."cblas-sys" or false) ||
        (f.ndarray."0.12.1"."blas" or false) ||
        (ndarray."0.12.1"."blas" or false); }
      { "0.12.1"."rustc-serialize" =
        (f.ndarray."0.12.1"."rustc-serialize" or false) ||
        (f.ndarray."0.12.1"."docs" or false) ||
        (ndarray."0.12.1"."docs" or false); }
      { "0.12.1"."serde" =
        (f.ndarray."0.12.1"."serde" or false) ||
        (f.ndarray."0.12.1"."serde-1" or false) ||
        (ndarray."0.12.1"."serde-1" or false); }
      { "0.12.1"."serde-1" =
        (f.ndarray."0.12.1"."serde-1" or false) ||
        (f.ndarray."0.12.1"."docs" or false) ||
        (ndarray."0.12.1"."docs" or false); }
      { "0.12.1"."test-blas-openblas-sys" =
        (f.ndarray."0.12.1"."test-blas-openblas-sys" or false) ||
        (f.ndarray."0.12.1"."test" or false) ||
        (ndarray."0.12.1"."test" or false); }
      { "0.12.1".default = (f.ndarray."0.12.1".default or true); }
    ];
    num_complex."${deps.ndarray."0.12.1".num_complex}".default = true;
    num_traits."${deps.ndarray."0.12.1".num_traits}".default = true;
  }) [
    (if deps."ndarray"."0.12.1" ? "itertools" then features_.itertools."${deps."ndarray"."0.12.1"."itertools" or ""}" deps else {})
    (if deps."ndarray"."0.12.1" ? "matrixmultiply" then features_.matrixmultiply."${deps."ndarray"."0.12.1"."matrixmultiply" or ""}" deps else {})
    (if deps."ndarray"."0.12.1" ? "num_complex" then features_.num_complex."${deps."ndarray"."0.12.1"."num_complex" or ""}" deps else {})
    (if deps."ndarray"."0.12.1" ? "num_traits" then features_.num_traits."${deps."ndarray"."0.12.1"."num_traits" or ""}" deps else {})
  ];


# end
# nodrop-0.1.13

  crates.nodrop."0.1.13" = deps: { features?(features_."nodrop"."0.1.13" deps {}) }: buildRustCrate {
    crateName = "nodrop";
    version = "0.1.13";
    description = "A wrapper type to inhibit drop (destructor). Use std::mem::ManuallyDrop instead!";
    authors = [ "bluss" ];
    sha256 = "0gkfx6wihr9z0m8nbdhma5pyvbipznjpkzny2d4zkc05b0vnhinb";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."nodrop"."0.1.13" or {});
  };
  features_."nodrop"."0.1.13" = deps: f: updateFeatures f (rec {
    nodrop = fold recursiveUpdate {} [
      { "0.1.13"."nodrop-union" =
        (f.nodrop."0.1.13"."nodrop-union" or false) ||
        (f.nodrop."0.1.13"."use_union" or false) ||
        (nodrop."0.1.13"."use_union" or false); }
      { "0.1.13"."std" =
        (f.nodrop."0.1.13"."std" or false) ||
        (f.nodrop."0.1.13"."default" or false) ||
        (nodrop."0.1.13"."default" or false); }
      { "0.1.13".default = (f.nodrop."0.1.13".default or true); }
    ];
  }) [];


# end
# normalize-line-endings-0.2.2

  crates.normalize_line_endings."0.2.2" = deps: { features?(features_."normalize_line_endings"."0.2.2" deps {}) }: buildRustCrate {
    crateName = "normalize-line-endings";
    version = "0.2.2";
    description = "Takes an iterator over chars and returns a new iterator with all line endings (\r, \n, or \r\n) as \n";
    authors = [ "Richard Dodd <richdodj@gmail.com>" ];
    sha256 = "0hzwsp4p30g105y3s2vj5wg8yc187jmkacrp9m7shwpzkfdiri0y";
  };
  features_."normalize_line_endings"."0.2.2" = deps: f: updateFeatures f (rec {
    normalize_line_endings."0.2.2".default = (f.normalize_line_endings."0.2.2".default or true);
  }) [];


# end
# num-complex-0.2.1

  crates.num_complex."0.2.1" = deps: { features?(features_."num_complex"."0.2.1" deps {}) }: buildRustCrate {
    crateName = "num-complex";
    version = "0.2.1";
    description = "Complex numbers implementation for Rust";
    homepage = "https://github.com/rust-num/num-complex";
    authors = [ "The Rust Project Developers" ];
    sha256 = "12lpp62ahc80p33cpw2771l8bwl0q13rl5vq0jzkqib1l5z8q80z";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."num_traits"."${deps."num_complex"."0.2.1"."num_traits"}" deps)
    ]);
    features = mkFeatures (features."num_complex"."0.2.1" or {});
  };
  features_."num_complex"."0.2.1" = deps: f: updateFeatures f (rec {
    num_complex = fold recursiveUpdate {} [
      { "0.2.1"."std" =
        (f.num_complex."0.2.1"."std" or false) ||
        (f.num_complex."0.2.1"."default" or false) ||
        (num_complex."0.2.1"."default" or false); }
      { "0.2.1".default = (f.num_complex."0.2.1".default or true); }
    ];
    num_traits = fold recursiveUpdate {} [
      { "${deps.num_complex."0.2.1".num_traits}"."i128" =
        (f.num_traits."${deps.num_complex."0.2.1".num_traits}"."i128" or false) ||
        (num_complex."0.2.1"."i128" or false) ||
        (f."num_complex"."0.2.1"."i128" or false); }
      { "${deps.num_complex."0.2.1".num_traits}"."std" =
        (f.num_traits."${deps.num_complex."0.2.1".num_traits}"."std" or false) ||
        (num_complex."0.2.1"."std" or false) ||
        (f."num_complex"."0.2.1"."std" or false); }
      { "${deps.num_complex."0.2.1".num_traits}".default = (f.num_traits."${deps.num_complex."0.2.1".num_traits}".default or false); }
    ];
  }) [
    (if deps."num_complex"."0.2.1" ? "num_traits" then features_.num_traits."${deps."num_complex"."0.2.1"."num_traits" or ""}" deps else {})
  ];


# end
# num-integer-0.1.39

  crates.num_integer."0.1.39" = deps: { features?(features_."num_integer"."0.1.39" deps {}) }: buildRustCrate {
    crateName = "num-integer";
    version = "0.1.39";
    description = "Integer traits and functions";
    homepage = "https://github.com/rust-num/num-integer";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1f42ls46cghs13qfzgbd7syib2zc6m7hlmv1qlar6c9mdxapvvbg";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."num_traits"."${deps."num_integer"."0.1.39"."num_traits"}" deps)
    ]);
    features = mkFeatures (features."num_integer"."0.1.39" or {});
  };
  features_."num_integer"."0.1.39" = deps: f: updateFeatures f (rec {
    num_integer = fold recursiveUpdate {} [
      { "0.1.39"."std" =
        (f.num_integer."0.1.39"."std" or false) ||
        (f.num_integer."0.1.39"."default" or false) ||
        (num_integer."0.1.39"."default" or false); }
      { "0.1.39".default = (f.num_integer."0.1.39".default or true); }
    ];
    num_traits = fold recursiveUpdate {} [
      { "${deps.num_integer."0.1.39".num_traits}"."i128" =
        (f.num_traits."${deps.num_integer."0.1.39".num_traits}"."i128" or false) ||
        (num_integer."0.1.39"."i128" or false) ||
        (f."num_integer"."0.1.39"."i128" or false); }
      { "${deps.num_integer."0.1.39".num_traits}"."std" =
        (f.num_traits."${deps.num_integer."0.1.39".num_traits}"."std" or false) ||
        (num_integer."0.1.39"."std" or false) ||
        (f."num_integer"."0.1.39"."std" or false); }
      { "${deps.num_integer."0.1.39".num_traits}".default = (f.num_traits."${deps.num_integer."0.1.39".num_traits}".default or false); }
    ];
  }) [
    (if deps."num_integer"."0.1.39" ? "num_traits" then features_.num_traits."${deps."num_integer"."0.1.39"."num_traits" or ""}" deps else {})
  ];


# end
# num-traits-0.2.6

  crates.num_traits."0.2.6" = deps: { features?(features_."num_traits"."0.2.6" deps {}) }: buildRustCrate {
    crateName = "num-traits";
    version = "0.2.6";
    description = "Numeric traits for generic mathematics";
    homepage = "https://github.com/rust-num/num-traits";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1d20sil9n0wgznd1nycm3yjfj1mzyl41ambb7by1apxlyiil1azk";
    build = "build.rs";
    features = mkFeatures (features."num_traits"."0.2.6" or {});
  };
  features_."num_traits"."0.2.6" = deps: f: updateFeatures f (rec {
    num_traits = fold recursiveUpdate {} [
      { "0.2.6"."std" =
        (f.num_traits."0.2.6"."std" or false) ||
        (f.num_traits."0.2.6"."default" or false) ||
        (num_traits."0.2.6"."default" or false); }
      { "0.2.6".default = (f.num_traits."0.2.6".default or true); }
    ];
  }) [];


# end
# num_cpus-1.10.0

  crates.num_cpus."1.10.0" = deps: { features?(features_."num_cpus"."1.10.0" deps {}) }: buildRustCrate {
    crateName = "num_cpus";
    version = "1.10.0";
    description = "Get the number of CPUs on a machine.";
    authors = [ "Sean McArthur <sean@seanmonstar.com>" ];
    sha256 = "1411jyxy1wd8d59mv7cf6ynkvvar92czmwhb9l2c1brdkxbbiqn7";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."num_cpus"."1.10.0"."libc"}" deps)
    ]);
  };
  features_."num_cpus"."1.10.0" = deps: f: updateFeatures f (rec {
    libc."${deps.num_cpus."1.10.0".libc}".default = true;
    num_cpus."1.10.0".default = (f.num_cpus."1.10.0".default or true);
  }) [
    (if deps."num_cpus"."1.10.0" ? "libc" then features_.libc."${deps."num_cpus"."1.10.0"."libc" or ""}" deps else {})
  ];


# end
# numtoa-0.1.0

  crates.numtoa."0.1.0" = deps: { features?(features_."numtoa"."0.1.0" deps {}) }: buildRustCrate {
    crateName = "numtoa";
    version = "0.1.0";
    description = "Convert numbers into stack-allocated byte arrays";
    authors = [ "Michael Aaron Murphy <mmstickman@gmail.com>" ];
    sha256 = "1i2wxr96bb1rvax15z843126z3bnl2frpx69vxsp95r96wr24j08";
    features = mkFeatures (features."numtoa"."0.1.0" or {});
  };
  features_."numtoa"."0.1.0" = deps: f: updateFeatures f (rec {
    numtoa."0.1.0".default = (f.numtoa."0.1.0".default or true);
  }) [];


# end
# openssl-0.10.21

  crates.openssl."0.10.21" = deps: { features?(features_."openssl"."0.10.21" deps {}) }: buildRustCrate {
    crateName = "openssl";
    version = "0.10.21";
    description = "OpenSSL bindings";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "1msb9iqfz4zb426g3l622wfa1dh9p7w0dz8cac1wpf66isj0x028";
    dependencies = mapFeatures features ([
      (crates."bitflags"."${deps."openssl"."0.10.21"."bitflags"}" deps)
      (crates."cfg_if"."${deps."openssl"."0.10.21"."cfg_if"}" deps)
      (crates."foreign_types"."${deps."openssl"."0.10.21"."foreign_types"}" deps)
      (crates."lazy_static"."${deps."openssl"."0.10.21"."lazy_static"}" deps)
      (crates."libc"."${deps."openssl"."0.10.21"."libc"}" deps)
      (crates."openssl_sys"."${deps."openssl"."0.10.21"."openssl_sys"}" deps)
    ]);
    features = mkFeatures (features."openssl"."0.10.21" or {});
  };
  features_."openssl"."0.10.21" = deps: f: updateFeatures f (rec {
    bitflags."${deps.openssl."0.10.21".bitflags}".default = true;
    cfg_if."${deps.openssl."0.10.21".cfg_if}".default = true;
    foreign_types."${deps.openssl."0.10.21".foreign_types}".default = true;
    lazy_static."${deps.openssl."0.10.21".lazy_static}".default = true;
    libc."${deps.openssl."0.10.21".libc}".default = true;
    openssl."0.10.21".default = (f.openssl."0.10.21".default or true);
    openssl_sys = fold recursiveUpdate {} [
      { "${deps.openssl."0.10.21".openssl_sys}"."vendored" =
        (f.openssl_sys."${deps.openssl."0.10.21".openssl_sys}"."vendored" or false) ||
        (openssl."0.10.21"."vendored" or false) ||
        (f."openssl"."0.10.21"."vendored" or false); }
      { "${deps.openssl."0.10.21".openssl_sys}".default = true; }
    ];
  }) [
    (if deps."openssl"."0.10.21" ? "bitflags" then features_.bitflags."${deps."openssl"."0.10.21"."bitflags" or ""}" deps else {})
    (if deps."openssl"."0.10.21" ? "cfg_if" then features_.cfg_if."${deps."openssl"."0.10.21"."cfg_if" or ""}" deps else {})
    (if deps."openssl"."0.10.21" ? "foreign_types" then features_.foreign_types."${deps."openssl"."0.10.21"."foreign_types" or ""}" deps else {})
    (if deps."openssl"."0.10.21" ? "lazy_static" then features_.lazy_static."${deps."openssl"."0.10.21"."lazy_static" or ""}" deps else {})
    (if deps."openssl"."0.10.21" ? "libc" then features_.libc."${deps."openssl"."0.10.21"."libc" or ""}" deps else {})
    (if deps."openssl"."0.10.21" ? "openssl_sys" then features_.openssl_sys."${deps."openssl"."0.10.21"."openssl_sys" or ""}" deps else {})
  ];


# end
# openssl-probe-0.1.2

  crates.openssl_probe."0.1.2" = deps: { features?(features_."openssl_probe"."0.1.2" deps {}) }: buildRustCrate {
    crateName = "openssl-probe";
    version = "0.1.2";
    description = "Tool for helping to find SSL certificate locations on the system for OpenSSL
";
    homepage = "https://github.com/alexcrichton/openssl-probe";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1a89fznx26vvaxyrxdvgf6iwai5xvs6xjvpjin68fgvrslv6n15a";
  };
  features_."openssl_probe"."0.1.2" = deps: f: updateFeatures f (rec {
    openssl_probe."0.1.2".default = (f.openssl_probe."0.1.2".default or true);
  }) [];


# end
# openssl-src-111.2.1+1.1.1b

  crates.openssl_src."111.2.1+1.1.1b" = deps: { features?(features_."openssl_src"."111.2.1+1.1.1b" deps {}) }: buildRustCrate {
    crateName = "openssl-src";
    version = "111.2.1+1.1.1b";
    description = "Source of OpenSSL and logic to build it.
";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0gfa29r16ds88a3sjcgkc2q5dkhgnxk58gly313r05xqj4zi2pxc";
    dependencies = mapFeatures features ([
      (crates."cc"."${deps."openssl_src"."111.2.1+1.1.1b"."cc"}" deps)
    ]);
  };
  features_."openssl_src"."111.2.1+1.1.1b" = deps: f: updateFeatures f (rec {
    cc."${deps.openssl_src."111.2.1+1.1.1b".cc}".default = true;
    openssl_src."111.2.1+1.1.1b".default = (f.openssl_src."111.2.1+1.1.1b".default or true);
  }) [
    (if deps."openssl_src"."111.2.1+1.1.1b" ? "cc" then features_.cc."${deps."openssl_src"."111.2.1+1.1.1b"."cc" or ""}" deps else {})
  ];


# end
# openssl-sys-0.9.44

  crates.openssl_sys."0.9.44" = deps: { features?(features_."openssl_sys"."0.9.44" deps {}) }: buildRustCrate {
    crateName = "openssl-sys";
    version = "0.9.44";
    description = "FFI bindings to OpenSSL";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "09rbq04mcs1zv89r61ikywsin8a9szraq06a4fs3chp44igswymh";
    build = "build/main.rs";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."openssl_sys"."0.9.44"."libc"}" deps)
    ])
      ++ (if abi == "msvc" then mapFeatures features ([
]) else []);

    buildDependencies = mapFeatures features ([
      (crates."cc"."${deps."openssl_sys"."0.9.44"."cc"}" deps)
      (crates."pkg_config"."${deps."openssl_sys"."0.9.44"."pkg_config"}" deps)
      (crates."rustc_version"."${deps."openssl_sys"."0.9.44"."rustc_version"}" deps)
    ]
      ++ (if features.openssl_sys."0.9.44".openssl-src or false then [ (crates.openssl_src."${deps."openssl_sys"."0.9.44".openssl_src}" deps) ] else []));
    features = mkFeatures (features."openssl_sys"."0.9.44" or {});
  };
  features_."openssl_sys"."0.9.44" = deps: f: updateFeatures f (rec {
    cc."${deps.openssl_sys."0.9.44".cc}".default = true;
    libc."${deps.openssl_sys."0.9.44".libc}".default = true;
    openssl_sys = fold recursiveUpdate {} [
      { "0.9.44"."openssl-src" =
        (f.openssl_sys."0.9.44"."openssl-src" or false) ||
        (f.openssl_sys."0.9.44"."vendored" or false) ||
        (openssl_sys."0.9.44"."vendored" or false); }
      { "0.9.44".default = (f.openssl_sys."0.9.44".default or true); }
    ];
    pkg_config."${deps.openssl_sys."0.9.44".pkg_config}".default = true;
    rustc_version."${deps.openssl_sys."0.9.44".rustc_version}".default = true;
  }) [
    (f: if deps."openssl_sys"."0.9.44" ? "openssl_src" then recursiveUpdate f { openssl_src."${deps."openssl_sys"."0.9.44"."openssl_src"}"."default" = true; } else f)
    (if deps."openssl_sys"."0.9.44" ? "libc" then features_.libc."${deps."openssl_sys"."0.9.44"."libc" or ""}" deps else {})
    (if deps."openssl_sys"."0.9.44" ? "cc" then features_.cc."${deps."openssl_sys"."0.9.44"."cc" or ""}" deps else {})
    (if deps."openssl_sys"."0.9.44" ? "openssl_src" then features_.openssl_src."${deps."openssl_sys"."0.9.44"."openssl_src" or ""}" deps else {})
    (if deps."openssl_sys"."0.9.44" ? "pkg_config" then features_.pkg_config."${deps."openssl_sys"."0.9.44"."pkg_config" or ""}" deps else {})
    (if deps."openssl_sys"."0.9.44" ? "rustc_version" then features_.rustc_version."${deps."openssl_sys"."0.9.44"."rustc_version" or ""}" deps else {})
  ];


# end
# percent-encoding-1.0.1

  crates.percent_encoding."1.0.1" = deps: { features?(features_."percent_encoding"."1.0.1" deps {}) }: buildRustCrate {
    crateName = "percent-encoding";
    version = "1.0.1";
    description = "Percent encoding and decoding";
    authors = [ "The rust-url developers" ];
    sha256 = "04ahrp7aw4ip7fmadb0bknybmkfav0kk0gw4ps3ydq5w6hr0ib5i";
    libPath = "lib.rs";
  };
  features_."percent_encoding"."1.0.1" = deps: f: updateFeatures f (rec {
    percent_encoding."1.0.1".default = (f.percent_encoding."1.0.1".default or true);
  }) [];


# end
# phf-0.7.24

  crates.phf."0.7.24" = deps: { features?(features_."phf"."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf";
    version = "0.7.24";
    description = "Runtime support for perfect hash function data structures";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "19mmhmafd1dhywc7pzkmd1nq0kjfvg57viny20jqa91hhprf2dv5";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."phf_shared"."${deps."phf"."0.7.24"."phf_shared"}" deps)
    ]);
    features = mkFeatures (features."phf"."0.7.24" or {});
  };
  features_."phf"."0.7.24" = deps: f: updateFeatures f (rec {
    phf = fold recursiveUpdate {} [
      { "0.7.24"."phf_macros" =
        (f.phf."0.7.24"."phf_macros" or false) ||
        (f.phf."0.7.24"."macros" or false) ||
        (phf."0.7.24"."macros" or false); }
      { "0.7.24".default = (f.phf."0.7.24".default or true); }
    ];
    phf_shared = fold recursiveUpdate {} [
      { "${deps.phf."0.7.24".phf_shared}"."core" =
        (f.phf_shared."${deps.phf."0.7.24".phf_shared}"."core" or false) ||
        (phf."0.7.24"."core" or false) ||
        (f."phf"."0.7.24"."core" or false); }
      { "${deps.phf."0.7.24".phf_shared}"."unicase" =
        (f.phf_shared."${deps.phf."0.7.24".phf_shared}"."unicase" or false) ||
        (phf."0.7.24"."unicase" or false) ||
        (f."phf"."0.7.24"."unicase" or false); }
      { "${deps.phf."0.7.24".phf_shared}".default = true; }
    ];
  }) [
    (if deps."phf"."0.7.24" ? "phf_shared" then features_.phf_shared."${deps."phf"."0.7.24"."phf_shared" or ""}" deps else {})
  ];


# end
# phf_codegen-0.7.24

  crates.phf_codegen."0.7.24" = deps: { features?(features_."phf_codegen"."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_codegen";
    version = "0.7.24";
    description = "Codegen library for PHF types";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "0avkx97r4ph8rv70wwgniarlcfiq27yd74gmnxfdv3rx840cyf8g";
    dependencies = mapFeatures features ([
      (crates."phf_generator"."${deps."phf_codegen"."0.7.24"."phf_generator"}" deps)
      (crates."phf_shared"."${deps."phf_codegen"."0.7.24"."phf_shared"}" deps)
    ]);
  };
  features_."phf_codegen"."0.7.24" = deps: f: updateFeatures f (rec {
    phf_codegen."0.7.24".default = (f.phf_codegen."0.7.24".default or true);
    phf_generator."${deps.phf_codegen."0.7.24".phf_generator}".default = true;
    phf_shared."${deps.phf_codegen."0.7.24".phf_shared}".default = true;
  }) [
    (if deps."phf_codegen"."0.7.24" ? "phf_generator" then features_.phf_generator."${deps."phf_codegen"."0.7.24"."phf_generator" or ""}" deps else {})
    (if deps."phf_codegen"."0.7.24" ? "phf_shared" then features_.phf_shared."${deps."phf_codegen"."0.7.24"."phf_shared" or ""}" deps else {})
  ];


# end
# phf_generator-0.7.24

  crates.phf_generator."0.7.24" = deps: { features?(features_."phf_generator"."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_generator";
    version = "0.7.24";
    description = "PHF generation logic";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "1frn2jfydinifxb1fki0xnnsxf0f1ciaa79jz415r5qhw1ash72j";
    dependencies = mapFeatures features ([
      (crates."phf_shared"."${deps."phf_generator"."0.7.24"."phf_shared"}" deps)
      (crates."rand"."${deps."phf_generator"."0.7.24"."rand"}" deps)
    ]);
  };
  features_."phf_generator"."0.7.24" = deps: f: updateFeatures f (rec {
    phf_generator."0.7.24".default = (f.phf_generator."0.7.24".default or true);
    phf_shared."${deps.phf_generator."0.7.24".phf_shared}".default = true;
    rand."${deps.phf_generator."0.7.24".rand}".default = true;
  }) [
    (if deps."phf_generator"."0.7.24" ? "phf_shared" then features_.phf_shared."${deps."phf_generator"."0.7.24"."phf_shared" or ""}" deps else {})
    (if deps."phf_generator"."0.7.24" ? "rand" then features_.rand."${deps."phf_generator"."0.7.24"."rand" or ""}" deps else {})
  ];


# end
# phf_shared-0.7.24

  crates.phf_shared."0.7.24" = deps: { features?(features_."phf_shared"."0.7.24" deps {}) }: buildRustCrate {
    crateName = "phf_shared";
    version = "0.7.24";
    description = "Support code shared by PHF libraries";
    authors = [ "Steven Fackler <sfackler@gmail.com>" ];
    sha256 = "1hndqn461jvm2r269ym4qh7fnjc6n8yy53avc2pb43p70vxhm9rl";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."siphasher"."${deps."phf_shared"."0.7.24"."siphasher"}" deps)
    ]
      ++ (if features.phf_shared."0.7.24".unicase or false then [ (crates.unicase."${deps."phf_shared"."0.7.24".unicase}" deps) ] else []));
    features = mkFeatures (features."phf_shared"."0.7.24" or {});
  };
  features_."phf_shared"."0.7.24" = deps: f: updateFeatures f (rec {
    phf_shared."0.7.24".default = (f.phf_shared."0.7.24".default or true);
    siphasher."${deps.phf_shared."0.7.24".siphasher}".default = true;
  }) [
    (f: if deps."phf_shared"."0.7.24" ? "unicase" then recursiveUpdate f { unicase."${deps."phf_shared"."0.7.24"."unicase"}"."default" = true; } else f)
    (if deps."phf_shared"."0.7.24" ? "siphasher" then features_.siphasher."${deps."phf_shared"."0.7.24"."siphasher" or ""}" deps else {})
    (if deps."phf_shared"."0.7.24" ? "unicase" then features_.unicase."${deps."phf_shared"."0.7.24"."unicase" or ""}" deps else {})
  ];


# end
# pkg-config-0.3.14

  crates.pkg_config."0.3.14" = deps: { features?(features_."pkg_config"."0.3.14" deps {}) }: buildRustCrate {
    crateName = "pkg-config";
    version = "0.3.14";
    description = "A library to run the pkg-config system tool at build time in order to be used in
Cargo build scripts.
";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "0207fsarrm412j0dh87lfcas72n8mxar7q3mgflsbsrqnb140sv6";
  };
  features_."pkg_config"."0.3.14" = deps: f: updateFeatures f (rec {
    pkg_config."0.3.14".default = (f.pkg_config."0.3.14".default or true);
  }) [];


# end
# predicates-1.0.1

  crates.predicates."1.0.1" = deps: { features?(features_."predicates"."1.0.1" deps {}) }: buildRustCrate {
    crateName = "predicates";
    version = "1.0.1";
    description = "An implementation of boolean-valued predicate functions.
";
    homepage = "https://github.com/assert-rs/predicates-rs";
    authors = [ "Nick Stevens <nick@bitcurry.com>" ];
    sha256 = "06l9y5rml2c9jinnfv5kk40ssg7xc0g9jaibzmhh9kwff4im8ipx";
    dependencies = mapFeatures features ([
      (crates."predicates_core"."${deps."predicates"."1.0.1"."predicates_core"}" deps)
    ]
      ++ (if features.predicates."1.0.1".difference or false then [ (crates.difference."${deps."predicates"."1.0.1".difference}" deps) ] else [])
      ++ (if features.predicates."1.0.1".float-cmp or false then [ (crates.float_cmp."${deps."predicates"."1.0.1".float_cmp}" deps) ] else [])
      ++ (if features.predicates."1.0.1".normalize-line-endings or false then [ (crates.normalize_line_endings."${deps."predicates"."1.0.1".normalize_line_endings}" deps) ] else [])
      ++ (if features.predicates."1.0.1".regex or false then [ (crates.regex."${deps."predicates"."1.0.1".regex}" deps) ] else []));
    features = mkFeatures (features."predicates"."1.0.1" or {});
  };
  features_."predicates"."1.0.1" = deps: f: updateFeatures f (rec {
    predicates = fold recursiveUpdate {} [
      { "1.0.1"."difference" =
        (f.predicates."1.0.1"."difference" or false) ||
        (f.predicates."1.0.1"."default" or false) ||
        (predicates."1.0.1"."default" or false); }
      { "1.0.1"."float-cmp" =
        (f.predicates."1.0.1"."float-cmp" or false) ||
        (f.predicates."1.0.1"."default" or false) ||
        (predicates."1.0.1"."default" or false); }
      { "1.0.1"."normalize-line-endings" =
        (f.predicates."1.0.1"."normalize-line-endings" or false) ||
        (f.predicates."1.0.1"."default" or false) ||
        (predicates."1.0.1"."default" or false); }
      { "1.0.1"."regex" =
        (f.predicates."1.0.1"."regex" or false) ||
        (f.predicates."1.0.1"."default" or false) ||
        (predicates."1.0.1"."default" or false); }
      { "1.0.1".default = (f.predicates."1.0.1".default or true); }
    ];
    predicates_core."${deps.predicates."1.0.1".predicates_core}".default = true;
  }) [
    (f: if deps."predicates"."1.0.1" ? "difference" then recursiveUpdate f { difference."${deps."predicates"."1.0.1"."difference"}"."default" = true; } else f)
    (f: if deps."predicates"."1.0.1" ? "float_cmp" then recursiveUpdate f { float_cmp."${deps."predicates"."1.0.1"."float_cmp"}"."default" = true; } else f)
    (f: if deps."predicates"."1.0.1" ? "normalize_line_endings" then recursiveUpdate f { normalize_line_endings."${deps."predicates"."1.0.1"."normalize_line_endings"}"."default" = true; } else f)
    (f: if deps."predicates"."1.0.1" ? "regex" then recursiveUpdate f { regex."${deps."predicates"."1.0.1"."regex"}"."default" = true; } else f)
    (if deps."predicates"."1.0.1" ? "difference" then features_.difference."${deps."predicates"."1.0.1"."difference" or ""}" deps else {})
    (if deps."predicates"."1.0.1" ? "float_cmp" then features_.float_cmp."${deps."predicates"."1.0.1"."float_cmp" or ""}" deps else {})
    (if deps."predicates"."1.0.1" ? "normalize_line_endings" then features_.normalize_line_endings."${deps."predicates"."1.0.1"."normalize_line_endings" or ""}" deps else {})
    (if deps."predicates"."1.0.1" ? "predicates_core" then features_.predicates_core."${deps."predicates"."1.0.1"."predicates_core" or ""}" deps else {})
    (if deps."predicates"."1.0.1" ? "regex" then features_.regex."${deps."predicates"."1.0.1"."regex" or ""}" deps else {})
  ];


# end
# predicates-core-1.0.0

  crates.predicates_core."1.0.0" = deps: { features?(features_."predicates_core"."1.0.0" deps {}) }: buildRustCrate {
    crateName = "predicates-core";
    version = "1.0.0";
    description = "An API for boolean-valued predicate functions.
";
    homepage = "https://github.com/assert-rs/predicates-rs/tree/master/predicates-core";
    authors = [ "Nick Stevens <nick@bitcurry.com>" ];
    sha256 = "14khkbx5lv35jbs64cyxafiljjygamy25y5brnnh38ksymlc8izp";
  };
  features_."predicates_core"."1.0.0" = deps: f: updateFeatures f (rec {
    predicates_core."1.0.0".default = (f.predicates_core."1.0.0".default or true);
  }) [];


# end
# predicates-tree-1.0.0

  crates.predicates_tree."1.0.0" = deps: { features?(features_."predicates_tree"."1.0.0" deps {}) }: buildRustCrate {
    crateName = "predicates-tree";
    version = "1.0.0";
    description = "Render boolean-valued predicate functions results as a tree.
";
    homepage = "https://github.com/assert-rs/predicates-rs/tree/master/predicates-tree";
    authors = [ "Nick Stevens <nick@bitcurry.com>" ];
    sha256 = "0bkgg7nz6vnv4f5ah4hx2xb946w18b8sv90z1lyz4vv7x7fa45np";
    dependencies = mapFeatures features ([
      (crates."predicates_core"."${deps."predicates_tree"."1.0.0"."predicates_core"}" deps)
      (crates."treeline"."${deps."predicates_tree"."1.0.0"."treeline"}" deps)
    ]);
  };
  features_."predicates_tree"."1.0.0" = deps: f: updateFeatures f (rec {
    predicates_core."${deps.predicates_tree."1.0.0".predicates_core}".default = true;
    predicates_tree."1.0.0".default = (f.predicates_tree."1.0.0".default or true);
    treeline."${deps.predicates_tree."1.0.0".treeline}".default = true;
  }) [
    (if deps."predicates_tree"."1.0.0" ? "predicates_core" then features_.predicates_core."${deps."predicates_tree"."1.0.0"."predicates_core" or ""}" deps else {})
    (if deps."predicates_tree"."1.0.0" ? "treeline" then features_.treeline."${deps."predicates_tree"."1.0.0"."treeline" or ""}" deps else {})
  ];


# end
# proc-macro2-0.4.29

  crates.proc_macro2."0.4.29" = deps: { features?(features_."proc_macro2"."0.4.29" deps {}) }: buildRustCrate {
    crateName = "proc-macro2";
    version = "0.4.29";
    description = "A stable implementation of the upcoming new `proc_macro` API. Comes with an
option, off by default, to also reimplement itself in terms of the upstream
unstable API.
";
    homepage = "https://github.com/alexcrichton/proc-macro2";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "08jfiqzh7drl67061aiwv9g93rpzydg39wvsyw4jn2h3n6chw1x3";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."unicode_xid"."${deps."proc_macro2"."0.4.29"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."proc_macro2"."0.4.29" or {});
  };
  features_."proc_macro2"."0.4.29" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "0.4.29"."proc-macro" =
        (f.proc_macro2."0.4.29"."proc-macro" or false) ||
        (f.proc_macro2."0.4.29"."default" or false) ||
        (proc_macro2."0.4.29"."default" or false); }
      { "0.4.29".default = (f.proc_macro2."0.4.29".default or true); }
    ];
    unicode_xid."${deps.proc_macro2."0.4.29".unicode_xid}".default = true;
  }) [
    (if deps."proc_macro2"."0.4.29" ? "unicode_xid" then features_.unicode_xid."${deps."proc_macro2"."0.4.29"."unicode_xid" or ""}" deps else {})
  ];


# end
# quick-error-1.2.2

  crates.quick_error."1.2.2" = deps: { features?(features_."quick_error"."1.2.2" deps {}) }: buildRustCrate {
    crateName = "quick-error";
    version = "1.2.2";
    description = "    A macro which makes error types pleasant to write.
";
    homepage = "http://github.com/tailhook/quick-error";
    authors = [ "Paul Colomiets <paul@colomiets.name>" "Colin Kiegel <kiegel@gmx.de>" ];
    sha256 = "192a3adc5phgpibgqblsdx1b421l5yg9bjbmv552qqq9f37h60k5";
  };
  features_."quick_error"."1.2.2" = deps: f: updateFeatures f (rec {
    quick_error."1.2.2".default = (f.quick_error."1.2.2".default or true);
  }) [];


# end
# quote-0.6.12

  crates.quote."0.6.12" = deps: { features?(features_."quote"."0.6.12" deps {}) }: buildRustCrate {
    crateName = "quote";
    version = "0.6.12";
    description = "Quasi-quoting macro quote!(...)";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1ckd2d2sy0hrwrqcr47dn0n3hyh7ygpc026l8xaycccyg27mihv9";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."quote"."0.6.12"."proc_macro2"}" deps)
    ]);
    features = mkFeatures (features."quote"."0.6.12" or {});
  };
  features_."quote"."0.6.12" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.quote."0.6.12".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.quote."0.6.12".proc_macro2}"."proc-macro" or false) ||
        (quote."0.6.12"."proc-macro" or false) ||
        (f."quote"."0.6.12"."proc-macro" or false); }
      { "${deps.quote."0.6.12".proc_macro2}".default = (f.proc_macro2."${deps.quote."0.6.12".proc_macro2}".default or false); }
    ];
    quote = fold recursiveUpdate {} [
      { "0.6.12"."proc-macro" =
        (f.quote."0.6.12"."proc-macro" or false) ||
        (f.quote."0.6.12"."default" or false) ||
        (quote."0.6.12"."default" or false); }
      { "0.6.12".default = (f.quote."0.6.12".default or true); }
    ];
  }) [
    (if deps."quote"."0.6.12" ? "proc_macro2" then features_.proc_macro2."${deps."quote"."0.6.12"."proc_macro2" or ""}" deps else {})
  ];


# end
# rand-0.4.6

  crates.rand."0.4.6" = deps: { features?(features_."rand"."0.4.6" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.4.6";
    description = "Random number generators and other randomness functionality.
";
    homepage = "https://github.com/rust-lang-nursery/rand";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0c3rmg5q7d6qdi7cbmg5py9alm70wd3xsg0mmcawrnl35qv37zfs";
    dependencies = (if abi == "sgx" then mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.4.6"."rand_core"}" deps)
      (crates."rdrand"."${deps."rand"."0.4.6"."rdrand"}" deps)
    ]) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_cprng"."${deps."rand"."0.4.6"."fuchsia_cprng"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.4.6".libc or false then [ (crates.libc."${deps."rand"."0.4.6".libc}" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.4.6"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand"."0.4.6" or {});
  };
  features_."rand"."0.4.6" = deps: f: updateFeatures f (rec {
    fuchsia_cprng."${deps.rand."0.4.6".fuchsia_cprng}".default = true;
    rand = fold recursiveUpdate {} [
      { "0.4.6"."i128_support" =
        (f.rand."0.4.6"."i128_support" or false) ||
        (f.rand."0.4.6"."nightly" or false) ||
        (rand."0.4.6"."nightly" or false); }
      { "0.4.6"."libc" =
        (f.rand."0.4.6"."libc" or false) ||
        (f.rand."0.4.6"."std" or false) ||
        (rand."0.4.6"."std" or false); }
      { "0.4.6"."std" =
        (f.rand."0.4.6"."std" or false) ||
        (f.rand."0.4.6"."default" or false) ||
        (rand."0.4.6"."default" or false); }
      { "0.4.6".default = (f.rand."0.4.6".default or true); }
    ];
    rand_core."${deps.rand."0.4.6".rand_core}".default = (f.rand_core."${deps.rand."0.4.6".rand_core}".default or false);
    rdrand."${deps.rand."0.4.6".rdrand}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.4.6".winapi}"."minwindef" = true; }
      { "${deps.rand."0.4.6".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.4.6".winapi}"."profileapi" = true; }
      { "${deps.rand."0.4.6".winapi}"."winnt" = true; }
      { "${deps.rand."0.4.6".winapi}".default = true; }
    ];
  }) [
    (f: if deps."rand"."0.4.6" ? "libc" then recursiveUpdate f { libc."${deps."rand"."0.4.6"."libc"}"."default" = true; } else f)
    (if deps."rand"."0.4.6" ? "rand_core" then features_.rand_core."${deps."rand"."0.4.6"."rand_core" or ""}" deps else {})
    (if deps."rand"."0.4.6" ? "rdrand" then features_.rdrand."${deps."rand"."0.4.6"."rdrand" or ""}" deps else {})
    (if deps."rand"."0.4.6" ? "fuchsia_cprng" then features_.fuchsia_cprng."${deps."rand"."0.4.6"."fuchsia_cprng" or ""}" deps else {})
    (if deps."rand"."0.4.6" ? "libc" then features_.libc."${deps."rand"."0.4.6"."libc" or ""}" deps else {})
    (if deps."rand"."0.4.6" ? "winapi" then features_.winapi."${deps."rand"."0.4.6"."winapi" or ""}" deps else {})
  ];


# end
# rand-0.5.6

  crates.rand."0.5.6" = deps: { features?(features_."rand"."0.5.6" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.5.6";
    description = "Random number generators and other randomness functionality.
";
    homepage = "https://crates.io/crates/rand";
    authors = [ "The Rust Project Developers" ];
    sha256 = "04f1gydiia347cx24n5cw4v21fhh9yga7dw739z4jsxzls2ss8w8";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand"."0.5.6"."rand_core"}" deps)
    ])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.6".cloudabi or false then [ (crates.cloudabi."${deps."rand"."0.5.6".cloudabi}" deps) ] else [])) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.6".fuchsia-cprng or false then [ (crates.fuchsia_cprng."${deps."rand"."0.5.6".fuchsia_cprng}" deps) ] else [])) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.6".libc or false then [ (crates.libc."${deps."rand"."0.5.6".libc}" deps) ] else [])) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
    ]
      ++ (if features.rand."0.5.6".winapi or false then [ (crates.winapi."${deps."rand"."0.5.6".winapi}" deps) ] else [])) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
    features = mkFeatures (features."rand"."0.5.6" or {});
  };
  features_."rand"."0.5.6" = deps: f: updateFeatures f (rec {
    rand = fold recursiveUpdate {} [
      { "0.5.6"."alloc" =
        (f.rand."0.5.6"."alloc" or false) ||
        (f.rand."0.5.6"."std" or false) ||
        (rand."0.5.6"."std" or false); }
      { "0.5.6"."cloudabi" =
        (f.rand."0.5.6"."cloudabi" or false) ||
        (f.rand."0.5.6"."std" or false) ||
        (rand."0.5.6"."std" or false); }
      { "0.5.6"."fuchsia-cprng" =
        (f.rand."0.5.6"."fuchsia-cprng" or false) ||
        (f.rand."0.5.6"."std" or false) ||
        (rand."0.5.6"."std" or false); }
      { "0.5.6"."i128_support" =
        (f.rand."0.5.6"."i128_support" or false) ||
        (f.rand."0.5.6"."nightly" or false) ||
        (rand."0.5.6"."nightly" or false); }
      { "0.5.6"."libc" =
        (f.rand."0.5.6"."libc" or false) ||
        (f.rand."0.5.6"."std" or false) ||
        (rand."0.5.6"."std" or false); }
      { "0.5.6"."serde" =
        (f.rand."0.5.6"."serde" or false) ||
        (f.rand."0.5.6"."serde1" or false) ||
        (rand."0.5.6"."serde1" or false); }
      { "0.5.6"."serde_derive" =
        (f.rand."0.5.6"."serde_derive" or false) ||
        (f.rand."0.5.6"."serde1" or false) ||
        (rand."0.5.6"."serde1" or false); }
      { "0.5.6"."std" =
        (f.rand."0.5.6"."std" or false) ||
        (f.rand."0.5.6"."default" or false) ||
        (rand."0.5.6"."default" or false); }
      { "0.5.6"."winapi" =
        (f.rand."0.5.6"."winapi" or false) ||
        (f.rand."0.5.6"."std" or false) ||
        (rand."0.5.6"."std" or false); }
      { "0.5.6".default = (f.rand."0.5.6".default or true); }
    ];
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.5.6".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.5.6".rand_core}"."alloc" or false) ||
        (rand."0.5.6"."alloc" or false) ||
        (f."rand"."0.5.6"."alloc" or false); }
      { "${deps.rand."0.5.6".rand_core}"."serde1" =
        (f.rand_core."${deps.rand."0.5.6".rand_core}"."serde1" or false) ||
        (rand."0.5.6"."serde1" or false) ||
        (f."rand"."0.5.6"."serde1" or false); }
      { "${deps.rand."0.5.6".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.5.6".rand_core}"."std" or false) ||
        (rand."0.5.6"."std" or false) ||
        (f."rand"."0.5.6"."std" or false); }
      { "${deps.rand."0.5.6".rand_core}".default = (f.rand_core."${deps.rand."0.5.6".rand_core}".default or false); }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.5.6".winapi}"."minwindef" = true; }
      { "${deps.rand."0.5.6".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.5.6".winapi}"."profileapi" = true; }
      { "${deps.rand."0.5.6".winapi}"."winnt" = true; }
    ];
  }) [
    (f: if deps."rand"."0.5.6" ? "cloudabi" then recursiveUpdate f { cloudabi."${deps."rand"."0.5.6"."cloudabi"}"."default" = true; } else f)
    (f: if deps."rand"."0.5.6" ? "fuchsia_cprng" then recursiveUpdate f { fuchsia_cprng."${deps."rand"."0.5.6"."fuchsia_cprng"}"."default" = true; } else f)
    (f: if deps."rand"."0.5.6" ? "libc" then recursiveUpdate f { libc."${deps."rand"."0.5.6"."libc"}"."default" = true; } else f)
    (f: if deps."rand"."0.5.6" ? "winapi" then recursiveUpdate f { winapi."${deps."rand"."0.5.6"."winapi"}"."default" = true; } else f)
    (if deps."rand"."0.5.6" ? "rand_core" then features_.rand_core."${deps."rand"."0.5.6"."rand_core" or ""}" deps else {})
    (if deps."rand"."0.5.6" ? "cloudabi" then features_.cloudabi."${deps."rand"."0.5.6"."cloudabi" or ""}" deps else {})
    (if deps."rand"."0.5.6" ? "fuchsia_cprng" then features_.fuchsia_cprng."${deps."rand"."0.5.6"."fuchsia_cprng" or ""}" deps else {})
    (if deps."rand"."0.5.6" ? "libc" then features_.libc."${deps."rand"."0.5.6"."libc" or ""}" deps else {})
    (if deps."rand"."0.5.6" ? "winapi" then features_.winapi."${deps."rand"."0.5.6"."winapi" or ""}" deps else {})
  ];


# end
# rand-0.6.5

  crates.rand."0.6.5" = deps: { features?(features_."rand"."0.6.5" deps {}) }: buildRustCrate {
    crateName = "rand";
    version = "0.6.5";
    description = "Random number generators and other randomness functionality.
";
    homepage = "https://crates.io/crates/rand";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0zbck48159aj8zrwzf80sd9xxh96w4f4968nshwjpysjvflimvgb";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_chacha"."${deps."rand"."0.6.5"."rand_chacha"}" deps)
      (crates."rand_core"."${deps."rand"."0.6.5"."rand_core"}" deps)
      (crates."rand_hc"."${deps."rand"."0.6.5"."rand_hc"}" deps)
      (crates."rand_isaac"."${deps."rand"."0.6.5"."rand_isaac"}" deps)
      (crates."rand_jitter"."${deps."rand"."0.6.5"."rand_jitter"}" deps)
      (crates."rand_pcg"."${deps."rand"."0.6.5"."rand_pcg"}" deps)
      (crates."rand_xorshift"."${deps."rand"."0.6.5"."rand_xorshift"}" deps)
    ]
      ++ (if features.rand."0.6.5".rand_os or false then [ (crates.rand_os."${deps."rand"."0.6.5".rand_os}" deps) ] else []))
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand"."0.6.5"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand"."0.6.5"."winapi"}" deps)
    ]) else []);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand"."0.6.5"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand"."0.6.5" or {});
  };
  features_."rand"."0.6.5" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand."0.6.5".autocfg}".default = true;
    libc."${deps.rand."0.6.5".libc}".default = (f.libc."${deps.rand."0.6.5".libc}".default or false);
    rand = fold recursiveUpdate {} [
      { "0.6.5"."alloc" =
        (f.rand."0.6.5"."alloc" or false) ||
        (f.rand."0.6.5"."std" or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5"."packed_simd" =
        (f.rand."0.6.5"."packed_simd" or false) ||
        (f.rand."0.6.5"."simd_support" or false) ||
        (rand."0.6.5"."simd_support" or false); }
      { "0.6.5"."rand_os" =
        (f.rand."0.6.5"."rand_os" or false) ||
        (f.rand."0.6.5"."std" or false) ||
        (rand."0.6.5"."std" or false); }
      { "0.6.5"."simd_support" =
        (f.rand."0.6.5"."simd_support" or false) ||
        (f.rand."0.6.5"."nightly" or false) ||
        (rand."0.6.5"."nightly" or false); }
      { "0.6.5"."std" =
        (f.rand."0.6.5"."std" or false) ||
        (f.rand."0.6.5"."default" or false) ||
        (rand."0.6.5"."default" or false); }
      { "0.6.5".default = (f.rand."0.6.5".default or true); }
    ];
    rand_chacha."${deps.rand."0.6.5".rand_chacha}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_core}"."alloc" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."alloc" or false) ||
        (rand."0.6.5"."alloc" or false) ||
        (f."rand"."0.6.5"."alloc" or false); }
      { "${deps.rand."0.6.5".rand_core}"."serde1" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_core}"."std" =
        (f.rand_core."${deps.rand."0.6.5".rand_core}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_core}".default = true; }
    ];
    rand_hc."${deps.rand."0.6.5".rand_hc}".default = true;
    rand_isaac = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_isaac}"."serde1" =
        (f.rand_isaac."${deps.rand."0.6.5".rand_isaac}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_isaac}".default = true; }
    ];
    rand_jitter = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_jitter}"."std" =
        (f.rand_jitter."${deps.rand."0.6.5".rand_jitter}"."std" or false) ||
        (rand."0.6.5"."std" or false) ||
        (f."rand"."0.6.5"."std" or false); }
      { "${deps.rand."0.6.5".rand_jitter}".default = true; }
    ];
    rand_os = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_os}"."stdweb" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."stdweb" or false) ||
        (rand."0.6.5"."stdweb" or false) ||
        (f."rand"."0.6.5"."stdweb" or false); }
      { "${deps.rand."0.6.5".rand_os}"."wasm-bindgen" =
        (f.rand_os."${deps.rand."0.6.5".rand_os}"."wasm-bindgen" or false) ||
        (rand."0.6.5"."wasm-bindgen" or false) ||
        (f."rand"."0.6.5"."wasm-bindgen" or false); }
    ];
    rand_pcg."${deps.rand."0.6.5".rand_pcg}".default = true;
    rand_xorshift = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".rand_xorshift}"."serde1" =
        (f.rand_xorshift."${deps.rand."0.6.5".rand_xorshift}"."serde1" or false) ||
        (rand."0.6.5"."serde1" or false) ||
        (f."rand"."0.6.5"."serde1" or false); }
      { "${deps.rand."0.6.5".rand_xorshift}".default = true; }
    ];
    winapi = fold recursiveUpdate {} [
      { "${deps.rand."0.6.5".winapi}"."minwindef" = true; }
      { "${deps.rand."0.6.5".winapi}"."ntsecapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."profileapi" = true; }
      { "${deps.rand."0.6.5".winapi}"."winnt" = true; }
      { "${deps.rand."0.6.5".winapi}".default = true; }
    ];
  }) [
    (f: if deps."rand"."0.6.5" ? "rand_os" then recursiveUpdate f { rand_os."${deps."rand"."0.6.5"."rand_os"}"."default" = true; } else f)
    (if deps."rand"."0.6.5" ? "rand_chacha" then features_.rand_chacha."${deps."rand"."0.6.5"."rand_chacha" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_core" then features_.rand_core."${deps."rand"."0.6.5"."rand_core" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_hc" then features_.rand_hc."${deps."rand"."0.6.5"."rand_hc" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_isaac" then features_.rand_isaac."${deps."rand"."0.6.5"."rand_isaac" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_jitter" then features_.rand_jitter."${deps."rand"."0.6.5"."rand_jitter" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_os" then features_.rand_os."${deps."rand"."0.6.5"."rand_os" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_pcg" then features_.rand_pcg."${deps."rand"."0.6.5"."rand_pcg" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "rand_xorshift" then features_.rand_xorshift."${deps."rand"."0.6.5"."rand_xorshift" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "autocfg" then features_.autocfg."${deps."rand"."0.6.5"."autocfg" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "libc" then features_.libc."${deps."rand"."0.6.5"."libc" or ""}" deps else {})
    (if deps."rand"."0.6.5" ? "winapi" then features_.winapi."${deps."rand"."0.6.5"."winapi" or ""}" deps else {})
  ];


# end
# rand_chacha-0.1.1

  crates.rand_chacha."0.1.1" = deps: { features?(features_."rand_chacha"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_chacha";
    version = "0.1.1";
    description = "ChaCha random number generator
";
    homepage = "https://crates.io/crates/rand_chacha";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0xnxm4mjd7wjnh18zxc1yickw58axbycp35ciraplqdfwn1gffwi";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_chacha"."0.1.1"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_chacha"."0.1.1"."autocfg"}" deps)
    ]);
  };
  features_."rand_chacha"."0.1.1" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_chacha."0.1.1".autocfg}".default = true;
    rand_chacha."0.1.1".default = (f.rand_chacha."0.1.1".default or true);
    rand_core."${deps.rand_chacha."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_chacha."0.1.1".rand_core}".default or false);
  }) [
    (if deps."rand_chacha"."0.1.1" ? "rand_core" then features_.rand_core."${deps."rand_chacha"."0.1.1"."rand_core" or ""}" deps else {})
    (if deps."rand_chacha"."0.1.1" ? "autocfg" then features_.autocfg."${deps."rand_chacha"."0.1.1"."autocfg" or ""}" deps else {})
  ];


# end
# rand_core-0.3.1

  crates.rand_core."0.3.1" = deps: { features?(features_."rand_core"."0.3.1" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.3.1";
    description = "Core random number generator traits and tools for implementation.
";
    homepage = "https://crates.io/crates/rand_core";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0q0ssgpj9x5a6fda83nhmfydy7a6c0wvxm0jhncsmjx8qp8gw91m";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_core"."0.3.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_core"."0.3.1" or {});
  };
  features_."rand_core"."0.3.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_core."0.3.1".rand_core}"."alloc" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."alloc" or false) ||
        (rand_core."0.3.1"."alloc" or false) ||
        (f."rand_core"."0.3.1"."alloc" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."serde1" or false) ||
        (rand_core."0.3.1"."serde1" or false) ||
        (f."rand_core"."0.3.1"."serde1" or false); }
      { "${deps.rand_core."0.3.1".rand_core}"."std" =
        (f.rand_core."${deps.rand_core."0.3.1".rand_core}"."std" or false) ||
        (rand_core."0.3.1"."std" or false) ||
        (f."rand_core"."0.3.1"."std" or false); }
      { "${deps.rand_core."0.3.1".rand_core}".default = true; }
      { "0.3.1"."std" =
        (f.rand_core."0.3.1"."std" or false) ||
        (f.rand_core."0.3.1"."default" or false) ||
        (rand_core."0.3.1"."default" or false); }
      { "0.3.1".default = (f.rand_core."0.3.1".default or true); }
    ];
  }) [
    (if deps."rand_core"."0.3.1" ? "rand_core" then features_.rand_core."${deps."rand_core"."0.3.1"."rand_core" or ""}" deps else {})
  ];


# end
# rand_core-0.4.0

  crates.rand_core."0.4.0" = deps: { features?(features_."rand_core"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "rand_core";
    version = "0.4.0";
    description = "Core random number generator traits and tools for implementation.
";
    homepage = "https://crates.io/crates/rand_core";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0wb5iwhffibj0pnpznhv1g3i7h1fnhz64s3nz74fz6vsm3q6q3br";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rand_core"."0.4.0" or {});
  };
  features_."rand_core"."0.4.0" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "0.4.0"."alloc" =
        (f.rand_core."0.4.0"."alloc" or false) ||
        (f.rand_core."0.4.0"."std" or false) ||
        (rand_core."0.4.0"."std" or false); }
      { "0.4.0"."serde" =
        (f.rand_core."0.4.0"."serde" or false) ||
        (f.rand_core."0.4.0"."serde1" or false) ||
        (rand_core."0.4.0"."serde1" or false); }
      { "0.4.0"."serde_derive" =
        (f.rand_core."0.4.0"."serde_derive" or false) ||
        (f.rand_core."0.4.0"."serde1" or false) ||
        (rand_core."0.4.0"."serde1" or false); }
      { "0.4.0".default = (f.rand_core."0.4.0".default or true); }
    ];
  }) [];


# end
# rand_hc-0.1.0

  crates.rand_hc."0.1.0" = deps: { features?(features_."rand_hc"."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rand_hc";
    version = "0.1.0";
    description = "HC128 random number generator
";
    homepage = "https://crates.io/crates/rand_hc";
    authors = [ "The Rand Project Developers" ];
    sha256 = "05agb75j87yp7y1zk8yf7bpm66hc0673r3dlypn0kazynr6fdgkz";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_hc"."0.1.0"."rand_core"}" deps)
    ]);
  };
  features_."rand_hc"."0.1.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_hc."0.1.0".rand_core}".default = (f.rand_core."${deps.rand_hc."0.1.0".rand_core}".default or false);
    rand_hc."0.1.0".default = (f.rand_hc."0.1.0".default or true);
  }) [
    (if deps."rand_hc"."0.1.0" ? "rand_core" then features_.rand_core."${deps."rand_hc"."0.1.0"."rand_core" or ""}" deps else {})
  ];


# end
# rand_isaac-0.1.1

  crates.rand_isaac."0.1.1" = deps: { features?(features_."rand_isaac"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_isaac";
    version = "0.1.1";
    description = "ISAAC random number generator
";
    homepage = "https://crates.io/crates/rand_isaac";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "10hhdh5b5sa03s6b63y9bafm956jwilx41s71jbrzl63ccx8lxdq";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_isaac"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_isaac"."0.1.1" or {});
  };
  features_."rand_isaac"."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_isaac."0.1.1".rand_core}"."serde1" =
        (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}"."serde1" or false) ||
        (rand_isaac."0.1.1"."serde1" or false) ||
        (f."rand_isaac"."0.1.1"."serde1" or false); }
      { "${deps.rand_isaac."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_isaac."0.1.1".rand_core}".default or false); }
    ];
    rand_isaac = fold recursiveUpdate {} [
      { "0.1.1"."serde" =
        (f.rand_isaac."0.1.1"."serde" or false) ||
        (f.rand_isaac."0.1.1"."serde1" or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1"."serde_derive" =
        (f.rand_isaac."0.1.1"."serde_derive" or false) ||
        (f.rand_isaac."0.1.1"."serde1" or false) ||
        (rand_isaac."0.1.1"."serde1" or false); }
      { "0.1.1".default = (f.rand_isaac."0.1.1".default or true); }
    ];
  }) [
    (if deps."rand_isaac"."0.1.1" ? "rand_core" then features_.rand_core."${deps."rand_isaac"."0.1.1"."rand_core" or ""}" deps else {})
  ];


# end
# rand_jitter-0.1.4

  crates.rand_jitter."0.1.4" = deps: { features?(features_."rand_jitter"."0.1.4" deps {}) }: buildRustCrate {
    crateName = "rand_jitter";
    version = "0.1.4";
    description = "Random number generator based on timing jitter";
    authors = [ "The Rand Project Developers" ];
    sha256 = "13nr4h042ab9l7qcv47bxrxw3gkf2pc3cni6c9pyi4nxla0mm7b6";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_jitter"."0.1.4"."rand_core"}" deps)
    ])
      ++ (if kernel == "darwin" || kernel == "ios" then mapFeatures features ([
      (crates."libc"."${deps."rand_jitter"."0.1.4"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_jitter"."0.1.4"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."rand_jitter"."0.1.4" or {});
  };
  features_."rand_jitter"."0.1.4" = deps: f: updateFeatures f (rec {
    libc."${deps.rand_jitter."0.1.4".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".rand_core}"."std" =
        (f.rand_core."${deps.rand_jitter."0.1.4".rand_core}"."std" or false) ||
        (rand_jitter."0.1.4"."std" or false) ||
        (f."rand_jitter"."0.1.4"."std" or false); }
      { "${deps.rand_jitter."0.1.4".rand_core}".default = true; }
    ];
    rand_jitter."0.1.4".default = (f.rand_jitter."0.1.4".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_jitter."0.1.4".winapi}"."profileapi" = true; }
      { "${deps.rand_jitter."0.1.4".winapi}".default = true; }
    ];
  }) [
    (if deps."rand_jitter"."0.1.4" ? "rand_core" then features_.rand_core."${deps."rand_jitter"."0.1.4"."rand_core" or ""}" deps else {})
    (if deps."rand_jitter"."0.1.4" ? "libc" then features_.libc."${deps."rand_jitter"."0.1.4"."libc" or ""}" deps else {})
    (if deps."rand_jitter"."0.1.4" ? "winapi" then features_.winapi."${deps."rand_jitter"."0.1.4"."winapi" or ""}" deps else {})
  ];


# end
# rand_os-0.1.3

  crates.rand_os."0.1.3" = deps: { features?(features_."rand_os"."0.1.3" deps {}) }: buildRustCrate {
    crateName = "rand_os";
    version = "0.1.3";
    description = "OS backed Random Number Generator";
    homepage = "https://crates.io/crates/rand_os";
    authors = [ "The Rand Project Developers" ];
    sha256 = "0ywwspizgs9g8vzn6m5ix9yg36n15119d6n792h7mk4r5vs0ww4j";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_os"."0.1.3"."rand_core"}" deps)
    ])
      ++ (if abi == "sgx" then mapFeatures features ([
      (crates."rdrand"."${deps."rand_os"."0.1.3"."rdrand"}" deps)
    ]) else [])
      ++ (if kernel == "cloudabi" then mapFeatures features ([
      (crates."cloudabi"."${deps."rand_os"."0.1.3"."cloudabi"}" deps)
    ]) else [])
      ++ (if kernel == "fuchsia" then mapFeatures features ([
      (crates."fuchsia_cprng"."${deps."rand_os"."0.1.3"."fuchsia_cprng"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."rand_os"."0.1.3"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."rand_os"."0.1.3"."winapi"}" deps)
    ]) else [])
      ++ (if kernel == "wasm32-unknown-unknown" then mapFeatures features ([
]) else []);
  };
  features_."rand_os"."0.1.3" = deps: f: updateFeatures f (rec {
    cloudabi."${deps.rand_os."0.1.3".cloudabi}".default = true;
    fuchsia_cprng."${deps.rand_os."0.1.3".fuchsia_cprng}".default = true;
    libc."${deps.rand_os."0.1.3".libc}".default = true;
    rand_core = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".rand_core}"."std" = true; }
      { "${deps.rand_os."0.1.3".rand_core}".default = true; }
    ];
    rand_os."0.1.3".default = (f.rand_os."0.1.3".default or true);
    rdrand."${deps.rand_os."0.1.3".rdrand}".default = true;
    winapi = fold recursiveUpdate {} [
      { "${deps.rand_os."0.1.3".winapi}"."minwindef" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."ntsecapi" = true; }
      { "${deps.rand_os."0.1.3".winapi}"."winnt" = true; }
      { "${deps.rand_os."0.1.3".winapi}".default = true; }
    ];
  }) [
    (if deps."rand_os"."0.1.3" ? "rand_core" then features_.rand_core."${deps."rand_os"."0.1.3"."rand_core" or ""}" deps else {})
    (if deps."rand_os"."0.1.3" ? "rdrand" then features_.rdrand."${deps."rand_os"."0.1.3"."rdrand" or ""}" deps else {})
    (if deps."rand_os"."0.1.3" ? "cloudabi" then features_.cloudabi."${deps."rand_os"."0.1.3"."cloudabi" or ""}" deps else {})
    (if deps."rand_os"."0.1.3" ? "fuchsia_cprng" then features_.fuchsia_cprng."${deps."rand_os"."0.1.3"."fuchsia_cprng" or ""}" deps else {})
    (if deps."rand_os"."0.1.3" ? "libc" then features_.libc."${deps."rand_os"."0.1.3"."libc" or ""}" deps else {})
    (if deps."rand_os"."0.1.3" ? "winapi" then features_.winapi."${deps."rand_os"."0.1.3"."winapi" or ""}" deps else {})
  ];


# end
# rand_pcg-0.1.2

  crates.rand_pcg."0.1.2" = deps: { features?(features_."rand_pcg"."0.1.2" deps {}) }: buildRustCrate {
    crateName = "rand_pcg";
    version = "0.1.2";
    description = "Selected PCG random number generators
";
    homepage = "https://crates.io/crates/rand_pcg";
    authors = [ "The Rand Project Developers" ];
    sha256 = "04qgi2ai2z42li5h4aawvxbpnlqyjfnipz9d6k73mdnl6p1xq938";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_pcg"."0.1.2"."rand_core"}" deps)
    ]);

    buildDependencies = mapFeatures features ([
      (crates."autocfg"."${deps."rand_pcg"."0.1.2"."autocfg"}" deps)
    ]);
    features = mkFeatures (features."rand_pcg"."0.1.2" or {});
  };
  features_."rand_pcg"."0.1.2" = deps: f: updateFeatures f (rec {
    autocfg."${deps.rand_pcg."0.1.2".autocfg}".default = true;
    rand_core."${deps.rand_pcg."0.1.2".rand_core}".default = true;
    rand_pcg = fold recursiveUpdate {} [
      { "0.1.2"."serde" =
        (f.rand_pcg."0.1.2"."serde" or false) ||
        (f.rand_pcg."0.1.2"."serde1" or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
      { "0.1.2"."serde_derive" =
        (f.rand_pcg."0.1.2"."serde_derive" or false) ||
        (f.rand_pcg."0.1.2"."serde1" or false) ||
        (rand_pcg."0.1.2"."serde1" or false); }
      { "0.1.2".default = (f.rand_pcg."0.1.2".default or true); }
    ];
  }) [
    (if deps."rand_pcg"."0.1.2" ? "rand_core" then features_.rand_core."${deps."rand_pcg"."0.1.2"."rand_core" or ""}" deps else {})
    (if deps."rand_pcg"."0.1.2" ? "autocfg" then features_.autocfg."${deps."rand_pcg"."0.1.2"."autocfg" or ""}" deps else {})
  ];


# end
# rand_xorshift-0.1.1

  crates.rand_xorshift."0.1.1" = deps: { features?(features_."rand_xorshift"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "rand_xorshift";
    version = "0.1.1";
    description = "Xorshift random number generator
";
    homepage = "https://crates.io/crates/rand_xorshift";
    authors = [ "The Rand Project Developers" "The Rust Project Developers" ];
    sha256 = "0v365c4h4lzxwz5k5kp9m0661s0sss7ylv74if0xb4svis9sswnn";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rand_xorshift"."0.1.1"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rand_xorshift"."0.1.1" or {});
  };
  features_."rand_xorshift"."0.1.1" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default = (f.rand_core."${deps.rand_xorshift."0.1.1".rand_core}".default or false);
    rand_xorshift = fold recursiveUpdate {} [
      { "0.1.1"."serde" =
        (f.rand_xorshift."0.1.1"."serde" or false) ||
        (f.rand_xorshift."0.1.1"."serde1" or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
      { "0.1.1"."serde_derive" =
        (f.rand_xorshift."0.1.1"."serde_derive" or false) ||
        (f.rand_xorshift."0.1.1"."serde1" or false) ||
        (rand_xorshift."0.1.1"."serde1" or false); }
      { "0.1.1".default = (f.rand_xorshift."0.1.1".default or true); }
    ];
  }) [
    (if deps."rand_xorshift"."0.1.1" ? "rand_core" then features_.rand_core."${deps."rand_xorshift"."0.1.1"."rand_core" or ""}" deps else {})
  ];


# end
# rawpointer-0.1.0

  crates.rawpointer."0.1.0" = deps: { features?(features_."rawpointer"."0.1.0" deps {}) }: buildRustCrate {
    crateName = "rawpointer";
    version = "0.1.0";
    description = "Extra methods for raw pointers.

For example `.post_inc()` and `.pre_dec()` (c.f. `ptr++` and `--ptr`) and
`ptrdistance`.
";
    authors = [ "bluss" ];
    sha256 = "0hblv2cv310ixf5f1jw4nk9w5pb95wh4dwqyjv07g2xrshbw6j04";
  };
  features_."rawpointer"."0.1.0" = deps: f: updateFeatures f (rec {
    rawpointer."0.1.0".default = (f.rawpointer."0.1.0".default or true);
  }) [];


# end
# rayon-1.0.3

  crates.rayon."1.0.3" = deps: { features?(features_."rayon"."1.0.3" deps {}) }: buildRustCrate {
    crateName = "rayon";
    version = "1.0.3";
    description = "Simple work-stealing parallelism for Rust";
    authors = [ "Niko Matsakis <niko@alum.mit.edu>" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "0bmwk0l5nbx20a5x16dhrgrmkh3m40v6i0qs2gi2iqimlszyhq93";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."rayon"."1.0.3"."crossbeam_deque"}" deps)
      (crates."either"."${deps."rayon"."1.0.3"."either"}" deps)
      (crates."rayon_core"."${deps."rayon"."1.0.3"."rayon_core"}" deps)
    ]);
  };
  features_."rayon"."1.0.3" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.rayon."1.0.3".crossbeam_deque}".default = true;
    either."${deps.rayon."1.0.3".either}".default = (f.either."${deps.rayon."1.0.3".either}".default or false);
    rayon."1.0.3".default = (f.rayon."1.0.3".default or true);
    rayon_core."${deps.rayon."1.0.3".rayon_core}".default = true;
  }) [
    (if deps."rayon"."1.0.3" ? "crossbeam_deque" then features_.crossbeam_deque."${deps."rayon"."1.0.3"."crossbeam_deque" or ""}" deps else {})
    (if deps."rayon"."1.0.3" ? "either" then features_.either."${deps."rayon"."1.0.3"."either" or ""}" deps else {})
    (if deps."rayon"."1.0.3" ? "rayon_core" then features_.rayon_core."${deps."rayon"."1.0.3"."rayon_core" or ""}" deps else {})
  ];


# end
# rayon-core-1.4.1

  crates.rayon_core."1.4.1" = deps: { features?(features_."rayon_core"."1.4.1" deps {}) }: buildRustCrate {
    crateName = "rayon-core";
    version = "1.4.1";
    description = "Core APIs for Rayon";
    authors = [ "Niko Matsakis <niko@alum.mit.edu>" "Josh Stone <cuviper@gmail.com>" ];
    sha256 = "01xf3mwmmji7yaarrpzpqjhz928ajxkwmjczbwmnpy39y95m4fbn";
    build = "build.rs";
    dependencies = mapFeatures features ([
      (crates."crossbeam_deque"."${deps."rayon_core"."1.4.1"."crossbeam_deque"}" deps)
      (crates."lazy_static"."${deps."rayon_core"."1.4.1"."lazy_static"}" deps)
      (crates."libc"."${deps."rayon_core"."1.4.1"."libc"}" deps)
      (crates."num_cpus"."${deps."rayon_core"."1.4.1"."num_cpus"}" deps)
    ]);
  };
  features_."rayon_core"."1.4.1" = deps: f: updateFeatures f (rec {
    crossbeam_deque."${deps.rayon_core."1.4.1".crossbeam_deque}".default = true;
    lazy_static."${deps.rayon_core."1.4.1".lazy_static}".default = true;
    libc."${deps.rayon_core."1.4.1".libc}".default = true;
    num_cpus."${deps.rayon_core."1.4.1".num_cpus}".default = true;
    rayon_core."1.4.1".default = (f.rayon_core."1.4.1".default or true);
  }) [
    (if deps."rayon_core"."1.4.1" ? "crossbeam_deque" then features_.crossbeam_deque."${deps."rayon_core"."1.4.1"."crossbeam_deque" or ""}" deps else {})
    (if deps."rayon_core"."1.4.1" ? "lazy_static" then features_.lazy_static."${deps."rayon_core"."1.4.1"."lazy_static" or ""}" deps else {})
    (if deps."rayon_core"."1.4.1" ? "libc" then features_.libc."${deps."rayon_core"."1.4.1"."libc" or ""}" deps else {})
    (if deps."rayon_core"."1.4.1" ? "num_cpus" then features_.num_cpus."${deps."rayon_core"."1.4.1"."num_cpus" or ""}" deps else {})
  ];


# end
# rdrand-0.4.0

  crates.rdrand."0.4.0" = deps: { features?(features_."rdrand"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "rdrand";
    version = "0.4.0";
    description = "An implementation of random number generator based on rdrand and rdseed instructions";
    authors = [ "Simonas Kazlauskas <rdrand@kazlauskas.me>" ];
    sha256 = "15hrcasn0v876wpkwab1dwbk9kvqwrb3iv4y4dibb6yxnfvzwajk";
    dependencies = mapFeatures features ([
      (crates."rand_core"."${deps."rdrand"."0.4.0"."rand_core"}" deps)
    ]);
    features = mkFeatures (features."rdrand"."0.4.0" or {});
  };
  features_."rdrand"."0.4.0" = deps: f: updateFeatures f (rec {
    rand_core."${deps.rdrand."0.4.0".rand_core}".default = (f.rand_core."${deps.rdrand."0.4.0".rand_core}".default or false);
    rdrand = fold recursiveUpdate {} [
      { "0.4.0"."std" =
        (f.rdrand."0.4.0"."std" or false) ||
        (f.rdrand."0.4.0"."default" or false) ||
        (rdrand."0.4.0"."default" or false); }
      { "0.4.0".default = (f.rdrand."0.4.0".default or true); }
    ];
  }) [
    (if deps."rdrand"."0.4.0" ? "rand_core" then features_.rand_core."${deps."rdrand"."0.4.0"."rand_core" or ""}" deps else {})
  ];


# end
# redox_syscall-0.1.54

  crates.redox_syscall."0.1.54" = deps: { features?(features_."redox_syscall"."0.1.54" deps {}) }: buildRustCrate {
    crateName = "redox_syscall";
    version = "0.1.54";
    description = "A Rust library to access raw Redox system calls";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "1ndcp7brnvii87ndcd34fk846498r07iznphkslcy0shic9cp4rr";
    libName = "syscall";
  };
  features_."redox_syscall"."0.1.54" = deps: f: updateFeatures f (rec {
    redox_syscall."0.1.54".default = (f.redox_syscall."0.1.54".default or true);
  }) [];


# end
# redox_termios-0.1.1

  crates.redox_termios."0.1.1" = deps: { features?(features_."redox_termios"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "redox_termios";
    version = "0.1.1";
    description = "A Rust library to access Redox termios functions";
    authors = [ "Jeremy Soller <jackpot51@gmail.com>" ];
    sha256 = "04s6yyzjca552hdaqlvqhp3vw0zqbc304md5czyd3axh56iry8wh";
    libPath = "src/lib.rs";
    dependencies = mapFeatures features ([
      (crates."redox_syscall"."${deps."redox_termios"."0.1.1"."redox_syscall"}" deps)
    ]);
  };
  features_."redox_termios"."0.1.1" = deps: f: updateFeatures f (rec {
    redox_syscall."${deps.redox_termios."0.1.1".redox_syscall}".default = true;
    redox_termios."0.1.1".default = (f.redox_termios."0.1.1".default or true);
  }) [
    (if deps."redox_termios"."0.1.1" ? "redox_syscall" then features_.redox_syscall."${deps."redox_termios"."0.1.1"."redox_syscall" or ""}" deps else {})
  ];


# end
# redox_users-0.3.0

  crates.redox_users."0.3.0" = deps: { features?(features_."redox_users"."0.3.0" deps {}) }: buildRustCrate {
    crateName = "redox_users";
    version = "0.3.0";
    description = "A Rust library to access Redox users and groups functionality";
    authors = [ "Jose Narvaez <goyox86@gmail.com>" "Wesley Hershberger <mggmugginsmc@gmail.com>" ];
    sha256 = "051rzqgk5hn7rf24nwgbb32zfdn8qp2kwqvdp0772ia85p737p4j";
    dependencies = mapFeatures features ([
      (crates."argon2rs"."${deps."redox_users"."0.3.0"."argon2rs"}" deps)
      (crates."failure"."${deps."redox_users"."0.3.0"."failure"}" deps)
      (crates."rand_os"."${deps."redox_users"."0.3.0"."rand_os"}" deps)
      (crates."redox_syscall"."${deps."redox_users"."0.3.0"."redox_syscall"}" deps)
    ]);
  };
  features_."redox_users"."0.3.0" = deps: f: updateFeatures f (rec {
    argon2rs."${deps.redox_users."0.3.0".argon2rs}".default = (f.argon2rs."${deps.redox_users."0.3.0".argon2rs}".default or false);
    failure."${deps.redox_users."0.3.0".failure}".default = true;
    rand_os."${deps.redox_users."0.3.0".rand_os}".default = true;
    redox_syscall."${deps.redox_users."0.3.0".redox_syscall}".default = true;
    redox_users."0.3.0".default = (f.redox_users."0.3.0".default or true);
  }) [
    (if deps."redox_users"."0.3.0" ? "argon2rs" then features_.argon2rs."${deps."redox_users"."0.3.0"."argon2rs" or ""}" deps else {})
    (if deps."redox_users"."0.3.0" ? "failure" then features_.failure."${deps."redox_users"."0.3.0"."failure" or ""}" deps else {})
    (if deps."redox_users"."0.3.0" ? "rand_os" then features_.rand_os."${deps."redox_users"."0.3.0"."rand_os" or ""}" deps else {})
    (if deps."redox_users"."0.3.0" ? "redox_syscall" then features_.redox_syscall."${deps."redox_users"."0.3.0"."redox_syscall" or ""}" deps else {})
  ];


# end
# regex-1.1.6

  crates.regex."1.1.6" = deps: { features?(features_."regex"."1.1.6" deps {}) }: buildRustCrate {
    crateName = "regex";
    version = "1.1.6";
    description = "An implementation of regular expressions for Rust. This implementation uses
finite automata and guarantees linear time matching on all inputs.
";
    homepage = "https://github.com/rust-lang/regex";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1yynvabg03m5f65qxcw70qckkfjwi9xyfpjdp6yq7pk0xf0ydc0b";
    dependencies = mapFeatures features ([
      (crates."aho_corasick"."${deps."regex"."1.1.6"."aho_corasick"}" deps)
      (crates."memchr"."${deps."regex"."1.1.6"."memchr"}" deps)
      (crates."regex_syntax"."${deps."regex"."1.1.6"."regex_syntax"}" deps)
      (crates."thread_local"."${deps."regex"."1.1.6"."thread_local"}" deps)
      (crates."utf8_ranges"."${deps."regex"."1.1.6"."utf8_ranges"}" deps)
    ]);
    features = mkFeatures (features."regex"."1.1.6" or {});
  };
  features_."regex"."1.1.6" = deps: f: updateFeatures f (rec {
    aho_corasick."${deps.regex."1.1.6".aho_corasick}".default = true;
    memchr."${deps.regex."1.1.6".memchr}".default = true;
    regex = fold recursiveUpdate {} [
      { "1.1.6"."pattern" =
        (f.regex."1.1.6"."pattern" or false) ||
        (f.regex."1.1.6"."unstable" or false) ||
        (regex."1.1.6"."unstable" or false); }
      { "1.1.6"."use_std" =
        (f.regex."1.1.6"."use_std" or false) ||
        (f.regex."1.1.6"."default" or false) ||
        (regex."1.1.6"."default" or false); }
      { "1.1.6".default = (f.regex."1.1.6".default or true); }
    ];
    regex_syntax."${deps.regex."1.1.6".regex_syntax}".default = true;
    thread_local."${deps.regex."1.1.6".thread_local}".default = true;
    utf8_ranges."${deps.regex."1.1.6".utf8_ranges}".default = true;
  }) [
    (if deps."regex"."1.1.6" ? "aho_corasick" then features_.aho_corasick."${deps."regex"."1.1.6"."aho_corasick" or ""}" deps else {})
    (if deps."regex"."1.1.6" ? "memchr" then features_.memchr."${deps."regex"."1.1.6"."memchr" or ""}" deps else {})
    (if deps."regex"."1.1.6" ? "regex_syntax" then features_.regex_syntax."${deps."regex"."1.1.6"."regex_syntax" or ""}" deps else {})
    (if deps."regex"."1.1.6" ? "thread_local" then features_.thread_local."${deps."regex"."1.1.6"."thread_local" or ""}" deps else {})
    (if deps."regex"."1.1.6" ? "utf8_ranges" then features_.utf8_ranges."${deps."regex"."1.1.6"."utf8_ranges" or ""}" deps else {})
  ];


# end
# regex-syntax-0.6.6

  crates.regex_syntax."0.6.6" = deps: { features?(features_."regex_syntax"."0.6.6" deps {}) }: buildRustCrate {
    crateName = "regex-syntax";
    version = "0.6.6";
    description = "A regular expression parser.";
    homepage = "https://github.com/rust-lang/regex";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1cjrdc3affa3rjfaxkp91xnf9k0fsqn9z4xqc280vv39nvrl8p8b";
    dependencies = mapFeatures features ([
      (crates."ucd_util"."${deps."regex_syntax"."0.6.6"."ucd_util"}" deps)
    ]);
  };
  features_."regex_syntax"."0.6.6" = deps: f: updateFeatures f (rec {
    regex_syntax."0.6.6".default = (f.regex_syntax."0.6.6".default or true);
    ucd_util."${deps.regex_syntax."0.6.6".ucd_util}".default = true;
  }) [
    (if deps."regex_syntax"."0.6.6" ? "ucd_util" then features_.ucd_util."${deps."regex_syntax"."0.6.6"."ucd_util" or ""}" deps else {})
  ];


# end
# remove_dir_all-0.5.1

  crates.remove_dir_all."0.5.1" = deps: { features?(features_."remove_dir_all"."0.5.1" deps {}) }: buildRustCrate {
    crateName = "remove_dir_all";
    version = "0.5.1";
    description = "A safe, reliable implementation of remove_dir_all for Windows";
    authors = [ "Aaronepower <theaaronepower@gmail.com>" ];
    sha256 = "1chx3yvfbj46xjz4bzsvps208l46hfbcy0sm98gpiya454n4rrl7";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."remove_dir_all"."0.5.1"."winapi"}" deps)
    ]) else []);
  };
  features_."remove_dir_all"."0.5.1" = deps: f: updateFeatures f (rec {
    remove_dir_all."0.5.1".default = (f.remove_dir_all."0.5.1".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.remove_dir_all."0.5.1".winapi}"."errhandlingapi" = true; }
      { "${deps.remove_dir_all."0.5.1".winapi}"."fileapi" = true; }
      { "${deps.remove_dir_all."0.5.1".winapi}"."std" = true; }
      { "${deps.remove_dir_all."0.5.1".winapi}"."winbase" = true; }
      { "${deps.remove_dir_all."0.5.1".winapi}"."winerror" = true; }
      { "${deps.remove_dir_all."0.5.1".winapi}".default = true; }
    ];
  }) [
    (if deps."remove_dir_all"."0.5.1" ? "winapi" then features_.winapi."${deps."remove_dir_all"."0.5.1"."winapi" or ""}" deps else {})
  ];


# end
# rouille-3.0.0

  crates.rouille."3.0.0" = deps: { features?(features_."rouille"."3.0.0" deps {}) }: buildRustCrate {
    crateName = "rouille";
    version = "3.0.0";
    description = "High-level idiomatic web framework.";
    authors = [ "Pierre Krieger <pierre.krieger1708@gmail.com>" ];
    sha256 = "1hhmhcfll5ra1h7axijr6baz6738xir7ilhb43mvi6y9dwf3cdqa";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."rouille"."3.0.0"."base64"}" deps)
      (crates."chrono"."${deps."rouille"."3.0.0"."chrono"}" deps)
      (crates."filetime"."${deps."rouille"."3.0.0"."filetime"}" deps)
      (crates."multipart"."${deps."rouille"."3.0.0"."multipart"}" deps)
      (crates."num_cpus"."${deps."rouille"."3.0.0"."num_cpus"}" deps)
      (crates."rand"."${deps."rouille"."3.0.0"."rand"}" deps)
      (crates."serde"."${deps."rouille"."3.0.0"."serde"}" deps)
      (crates."serde_derive"."${deps."rouille"."3.0.0"."serde_derive"}" deps)
      (crates."serde_json"."${deps."rouille"."3.0.0"."serde_json"}" deps)
      (crates."sha1"."${deps."rouille"."3.0.0"."sha1"}" deps)
      (crates."term"."${deps."rouille"."3.0.0"."term"}" deps)
      (crates."threadpool"."${deps."rouille"."3.0.0"."threadpool"}" deps)
      (crates."time"."${deps."rouille"."3.0.0"."time"}" deps)
      (crates."tiny_http"."${deps."rouille"."3.0.0"."tiny_http"}" deps)
      (crates."url"."${deps."rouille"."3.0.0"."url"}" deps)
    ]);
    features = mkFeatures (features."rouille"."3.0.0" or {});
  };
  features_."rouille"."3.0.0" = deps: f: updateFeatures f (rec {
    base64."${deps.rouille."3.0.0".base64}".default = true;
    chrono."${deps.rouille."3.0.0".chrono}".default = true;
    filetime."${deps.rouille."3.0.0".filetime}".default = true;
    multipart = fold recursiveUpdate {} [
      { "${deps.rouille."3.0.0".multipart}"."server" = true; }
      { "${deps.rouille."3.0.0".multipart}".default = (f.multipart."${deps.rouille."3.0.0".multipart}".default or false); }
    ];
    num_cpus."${deps.rouille."3.0.0".num_cpus}".default = true;
    rand."${deps.rouille."3.0.0".rand}".default = true;
    rouille = fold recursiveUpdate {} [
      { "3.0.0"."brotli" =
        (f.rouille."3.0.0"."brotli" or false) ||
        (f.rouille."3.0.0"."default" or false) ||
        (rouille."3.0.0"."default" or false); }
      { "3.0.0"."brotli2" =
        (f.rouille."3.0.0"."brotli2" or false) ||
        (f.rouille."3.0.0"."brotli" or false) ||
        (rouille."3.0.0"."brotli" or false); }
      { "3.0.0"."deflate" =
        (f.rouille."3.0.0"."deflate" or false) ||
        (f.rouille."3.0.0"."gzip" or false) ||
        (rouille."3.0.0"."gzip" or false); }
      { "3.0.0"."gzip" =
        (f.rouille."3.0.0"."gzip" or false) ||
        (f.rouille."3.0.0"."default" or false) ||
        (rouille."3.0.0"."default" or false); }
      { "3.0.0".default = (f.rouille."3.0.0".default or true); }
    ];
    serde."${deps.rouille."3.0.0".serde}".default = true;
    serde_derive."${deps.rouille."3.0.0".serde_derive}".default = true;
    serde_json."${deps.rouille."3.0.0".serde_json}".default = true;
    sha1."${deps.rouille."3.0.0".sha1}".default = true;
    term."${deps.rouille."3.0.0".term}".default = true;
    threadpool."${deps.rouille."3.0.0".threadpool}".default = true;
    time."${deps.rouille."3.0.0".time}".default = true;
    tiny_http = fold recursiveUpdate {} [
      { "${deps.rouille."3.0.0".tiny_http}"."ssl" =
        (f.tiny_http."${deps.rouille."3.0.0".tiny_http}"."ssl" or false) ||
        (rouille."3.0.0"."ssl" or false) ||
        (f."rouille"."3.0.0"."ssl" or false); }
      { "${deps.rouille."3.0.0".tiny_http}".default = true; }
    ];
    url."${deps.rouille."3.0.0".url}".default = true;
  }) [
    (if deps."rouille"."3.0.0" ? "base64" then features_.base64."${deps."rouille"."3.0.0"."base64" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "chrono" then features_.chrono."${deps."rouille"."3.0.0"."chrono" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "filetime" then features_.filetime."${deps."rouille"."3.0.0"."filetime" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "multipart" then features_.multipart."${deps."rouille"."3.0.0"."multipart" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "num_cpus" then features_.num_cpus."${deps."rouille"."3.0.0"."num_cpus" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "rand" then features_.rand."${deps."rouille"."3.0.0"."rand" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "serde" then features_.serde."${deps."rouille"."3.0.0"."serde" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "serde_derive" then features_.serde_derive."${deps."rouille"."3.0.0"."serde_derive" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "serde_json" then features_.serde_json."${deps."rouille"."3.0.0"."serde_json" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "sha1" then features_.sha1."${deps."rouille"."3.0.0"."sha1" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "term" then features_.term."${deps."rouille"."3.0.0"."term" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "threadpool" then features_.threadpool."${deps."rouille"."3.0.0"."threadpool" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "time" then features_.time."${deps."rouille"."3.0.0"."time" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "tiny_http" then features_.tiny_http."${deps."rouille"."3.0.0"."tiny_http" or ""}" deps else {})
    (if deps."rouille"."3.0.0" ? "url" then features_.url."${deps."rouille"."3.0.0"."url" or ""}" deps else {})
  ];


# end
# rustc-demangle-0.1.14

  crates.rustc_demangle."0.1.14" = deps: { features?(features_."rustc_demangle"."0.1.14" deps {}) }: buildRustCrate {
    crateName = "rustc-demangle";
    version = "0.1.14";
    description = "Rust compiler symbol demangling.
";
    homepage = "https://github.com/alexcrichton/rustc-demangle";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "07vl0ms3a27fpry9kh9piv08w7d51i5m7bgphk7pw4jygwzdy31f";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."rustc_demangle"."0.1.14" or {});
  };
  features_."rustc_demangle"."0.1.14" = deps: f: updateFeatures f (rec {
    rustc_demangle = fold recursiveUpdate {} [
      { "0.1.14"."compiler_builtins" =
        (f.rustc_demangle."0.1.14"."compiler_builtins" or false) ||
        (f.rustc_demangle."0.1.14"."rustc-dep-of-std" or false) ||
        (rustc_demangle."0.1.14"."rustc-dep-of-std" or false); }
      { "0.1.14"."core" =
        (f.rustc_demangle."0.1.14"."core" or false) ||
        (f.rustc_demangle."0.1.14"."rustc-dep-of-std" or false) ||
        (rustc_demangle."0.1.14"."rustc-dep-of-std" or false); }
      { "0.1.14".default = (f.rustc_demangle."0.1.14".default or true); }
    ];
  }) [];


# end
# rustc_version-0.2.3

  crates.rustc_version."0.2.3" = deps: { features?(features_."rustc_version"."0.2.3" deps {}) }: buildRustCrate {
    crateName = "rustc_version";
    version = "0.2.3";
    description = "A library for querying the version of a installed rustc compiler";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "0rgwzbgs3i9fqjm1p4ra3n7frafmpwl29c8lw85kv1rxn7n2zaa7";
    dependencies = mapFeatures features ([
      (crates."semver"."${deps."rustc_version"."0.2.3"."semver"}" deps)
    ]);
  };
  features_."rustc_version"."0.2.3" = deps: f: updateFeatures f (rec {
    rustc_version."0.2.3".default = (f.rustc_version."0.2.3".default or true);
    semver."${deps.rustc_version."0.2.3".semver}".default = true;
  }) [
    (if deps."rustc_version"."0.2.3" ? "semver" then features_.semver."${deps."rustc_version"."0.2.3"."semver" or ""}" deps else {})
  ];


# end
# ryu-0.2.8

  crates.ryu."0.2.8" = deps: { features?(features_."ryu"."0.2.8" deps {}) }: buildRustCrate {
    crateName = "ryu";
    version = "0.2.8";
    description = "Fast floating point to string conversion";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1qd0ni13w19a97y51vm31biyh2pvz8j9gi78rn5in912mi04xcnk";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."ryu"."0.2.8" or {});
  };
  features_."ryu"."0.2.8" = deps: f: updateFeatures f (rec {
    ryu."0.2.8".default = (f.ryu."0.2.8".default or true);
  }) [];


# end
# safemem-0.2.0

  crates.safemem."0.2.0" = deps: { features?(features_."safemem"."0.2.0" deps {}) }: buildRustCrate {
    crateName = "safemem";
    version = "0.2.0";
    description = "Safe wrappers for memory-accessing functions, like `std::ptr::copy()`.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "058m251q202n479ip1h6s91yw3plg66vsk5mpaflssn6rs5hijdm";
  };
  features_."safemem"."0.2.0" = deps: f: updateFeatures f (rec {
    safemem."0.2.0".default = (f.safemem."0.2.0".default or true);
  }) [];


# end
# safemem-0.3.0

  crates.safemem."0.3.0" = deps: { features?(features_."safemem"."0.3.0" deps {}) }: buildRustCrate {
    crateName = "safemem";
    version = "0.3.0";
    description = "Safe wrappers for memory-accessing functions, like `std::ptr::copy()`.";
    authors = [ "Austin Bonander <austin.bonander@gmail.com>" ];
    sha256 = "0pr39b468d05f6m7m4alsngmj5p7an8df21apsxbi57k0lmwrr18";
    features = mkFeatures (features."safemem"."0.3.0" or {});
  };
  features_."safemem"."0.3.0" = deps: f: updateFeatures f (rec {
    safemem = fold recursiveUpdate {} [
      { "0.3.0"."std" =
        (f.safemem."0.3.0"."std" or false) ||
        (f.safemem."0.3.0"."default" or false) ||
        (safemem."0.3.0"."default" or false); }
      { "0.3.0".default = (f.safemem."0.3.0".default or true); }
    ];
  }) [];


# end
# schannel-0.1.15

  crates.schannel."0.1.15" = deps: { features?(features_."schannel"."0.1.15" deps {}) }: buildRustCrate {
    crateName = "schannel";
    version = "0.1.15";
    description = "Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl";
    authors = [ "Steven Fackler <sfackler@gmail.com>" "Steffen Butzer <steffen.butzer@outlook.com>" ];
    sha256 = "1x9i0z9y8n5cg23ppyglgqdlz6rwcv2a489m5qpfk6l2ib8a1jdv";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."schannel"."0.1.15"."lazy_static"}" deps)
      (crates."winapi"."${deps."schannel"."0.1.15"."winapi"}" deps)
    ]);
  };
  features_."schannel"."0.1.15" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.schannel."0.1.15".lazy_static}".default = true;
    schannel."0.1.15".default = (f.schannel."0.1.15".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.schannel."0.1.15".winapi}"."lmcons" = true; }
      { "${deps.schannel."0.1.15".winapi}"."minschannel" = true; }
      { "${deps.schannel."0.1.15".winapi}"."schannel" = true; }
      { "${deps.schannel."0.1.15".winapi}"."securitybaseapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."sspi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."sysinfoapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."timezoneapi" = true; }
      { "${deps.schannel."0.1.15".winapi}"."winbase" = true; }
      { "${deps.schannel."0.1.15".winapi}"."wincrypt" = true; }
      { "${deps.schannel."0.1.15".winapi}"."winerror" = true; }
      { "${deps.schannel."0.1.15".winapi}".default = true; }
    ];
  }) [
    (if deps."schannel"."0.1.15" ? "lazy_static" then features_.lazy_static."${deps."schannel"."0.1.15"."lazy_static" or ""}" deps else {})
    (if deps."schannel"."0.1.15" ? "winapi" then features_.winapi."${deps."schannel"."0.1.15"."winapi" or ""}" deps else {})
  ];


# end
# scoped_threadpool-0.1.9

  crates.scoped_threadpool."0.1.9" = deps: { features?(features_."scoped_threadpool"."0.1.9" deps {}) }: buildRustCrate {
    crateName = "scoped_threadpool";
    version = "0.1.9";
    description = "A library for scoped and cached threadpools.";
    authors = [ "Marvin Löbel <loebel.marvin@gmail.com>" ];
    sha256 = "1arqj2skcfr46s1lcyvnlmfr5456kg5nhn8k90xyfjnxkp5yga2v";
    features = mkFeatures (features."scoped_threadpool"."0.1.9" or {});
  };
  features_."scoped_threadpool"."0.1.9" = deps: f: updateFeatures f (rec {
    scoped_threadpool."0.1.9".default = (f.scoped_threadpool."0.1.9".default or true);
  }) [];


# end
# scopeguard-0.3.3

  crates.scopeguard."0.3.3" = deps: { features?(features_."scopeguard"."0.3.3" deps {}) }: buildRustCrate {
    crateName = "scopeguard";
    version = "0.3.3";
    description = "A RAII scope guard that will run a given closure when it goes out of scope,
even if the code between panics (assuming unwinding panic).

Defines the macros `defer!` and `defer_on_unwind!`; the latter only runs
if the scope is extited through unwinding on panic.
";
    authors = [ "bluss" ];
    sha256 = "0i1l013csrqzfz6c68pr5pi01hg5v5yahq8fsdmaxy6p8ygsjf3r";
    features = mkFeatures (features."scopeguard"."0.3.3" or {});
  };
  features_."scopeguard"."0.3.3" = deps: f: updateFeatures f (rec {
    scopeguard = fold recursiveUpdate {} [
      { "0.3.3"."use_std" =
        (f.scopeguard."0.3.3"."use_std" or false) ||
        (f.scopeguard."0.3.3"."default" or false) ||
        (scopeguard."0.3.3"."default" or false); }
      { "0.3.3".default = (f.scopeguard."0.3.3".default or true); }
    ];
  }) [];


# end
# semver-0.9.0

  crates.semver."0.9.0" = deps: { features?(features_."semver"."0.9.0" deps {}) }: buildRustCrate {
    crateName = "semver";
    version = "0.9.0";
    description = "Semantic version parsing and comparison.
";
    homepage = "https://docs.rs/crate/semver/";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" "The Rust Project Developers" ];
    sha256 = "0azak2lb2wc36s3x15az886kck7rpnksrw14lalm157rg9sc9z63";
    dependencies = mapFeatures features ([
      (crates."semver_parser"."${deps."semver"."0.9.0"."semver_parser"}" deps)
    ]);
    features = mkFeatures (features."semver"."0.9.0" or {});
  };
  features_."semver"."0.9.0" = deps: f: updateFeatures f (rec {
    semver = fold recursiveUpdate {} [
      { "0.9.0"."serde" =
        (f.semver."0.9.0"."serde" or false) ||
        (f.semver."0.9.0"."ci" or false) ||
        (semver."0.9.0"."ci" or false); }
      { "0.9.0".default = (f.semver."0.9.0".default or true); }
    ];
    semver_parser."${deps.semver."0.9.0".semver_parser}".default = true;
  }) [
    (if deps."semver"."0.9.0" ? "semver_parser" then features_.semver_parser."${deps."semver"."0.9.0"."semver_parser" or ""}" deps else {})
  ];


# end
# semver-parser-0.7.0

  crates.semver_parser."0.7.0" = deps: { features?(features_."semver_parser"."0.7.0" deps {}) }: buildRustCrate {
    crateName = "semver-parser";
    version = "0.7.0";
    description = "Parsing of the semver spec.
";
    homepage = "https://github.com/steveklabnik/semver-parser";
    authors = [ "Steve Klabnik <steve@steveklabnik.com>" ];
    sha256 = "1da66c8413yakx0y15k8c055yna5lyb6fr0fw9318kdwkrk5k12h";
  };
  features_."semver_parser"."0.7.0" = deps: f: updateFeatures f (rec {
    semver_parser."0.7.0".default = (f.semver_parser."0.7.0".default or true);
  }) [];


# end
# serde-1.0.90

  crates.serde."1.0.90" = deps: { features?(features_."serde"."1.0.90" deps {}) }: buildRustCrate {
    crateName = "serde";
    version = "1.0.90";
    description = "A generic serialization/deserialization framework";
    homepage = "https://serde.rs";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "10b6n74m1dvb667vrn1db47ncb4h0mkqbg1dsamqjvv5vl5b5j56";
    build = "build.rs";
    dependencies = mapFeatures features ([
    ]
      ++ (if features.serde."1.0.90".serde_derive or false then [ (crates.serde_derive."${deps."serde"."1.0.90".serde_derive}" deps) ] else []));
    features = mkFeatures (features."serde"."1.0.90" or {});
  };
  features_."serde"."1.0.90" = deps: f: updateFeatures f (rec {
    serde = fold recursiveUpdate {} [
      { "1.0.90"."serde_derive" =
        (f.serde."1.0.90"."serde_derive" or false) ||
        (f.serde."1.0.90"."derive" or false) ||
        (serde."1.0.90"."derive" or false); }
      { "1.0.90"."std" =
        (f.serde."1.0.90"."std" or false) ||
        (f.serde."1.0.90"."default" or false) ||
        (serde."1.0.90"."default" or false); }
      { "1.0.90"."unstable" =
        (f.serde."1.0.90"."unstable" or false) ||
        (f.serde."1.0.90"."alloc" or false) ||
        (serde."1.0.90"."alloc" or false); }
      { "1.0.90".default = (f.serde."1.0.90".default or true); }
    ];
  }) [
    (f: if deps."serde"."1.0.90" ? "serde_derive" then recursiveUpdate f { serde_derive."${deps."serde"."1.0.90"."serde_derive"}"."default" = true; } else f)
    (if deps."serde"."1.0.90" ? "serde_derive" then features_.serde_derive."${deps."serde"."1.0.90"."serde_derive" or ""}" deps else {})
  ];


# end
# serde_derive-1.0.90

  crates.serde_derive."1.0.90" = deps: { features?(features_."serde_derive"."1.0.90" deps {}) }: buildRustCrate {
    crateName = "serde_derive";
    version = "1.0.90";
    description = "Macros 1.1 implementation of #[derive(Serialize, Deserialize)]";
    homepage = "https://serde.rs";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "1m4xgyl8jj3mxj0wszminzc1qf2gbkj9dpl17vi95nwl6m7i157y";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."serde_derive"."1.0.90"."proc_macro2"}" deps)
      (crates."quote"."${deps."serde_derive"."1.0.90"."quote"}" deps)
      (crates."syn"."${deps."serde_derive"."1.0.90"."syn"}" deps)
    ]);
    features = mkFeatures (features."serde_derive"."1.0.90" or {});
  };
  features_."serde_derive"."1.0.90" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.serde_derive."1.0.90".proc_macro2}".default = true;
    quote."${deps.serde_derive."1.0.90".quote}".default = true;
    serde_derive."1.0.90".default = (f.serde_derive."1.0.90".default or true);
    syn = fold recursiveUpdate {} [
      { "${deps.serde_derive."1.0.90".syn}"."visit" = true; }
      { "${deps.serde_derive."1.0.90".syn}".default = true; }
    ];
  }) [
    (if deps."serde_derive"."1.0.90" ? "proc_macro2" then features_.proc_macro2."${deps."serde_derive"."1.0.90"."proc_macro2" or ""}" deps else {})
    (if deps."serde_derive"."1.0.90" ? "quote" then features_.quote."${deps."serde_derive"."1.0.90"."quote" or ""}" deps else {})
    (if deps."serde_derive"."1.0.90" ? "syn" then features_.syn."${deps."serde_derive"."1.0.90"."syn" or ""}" deps else {})
  ];


# end
# serde_json-1.0.39

  crates.serde_json."1.0.39" = deps: { features?(features_."serde_json"."1.0.39" deps {}) }: buildRustCrate {
    crateName = "serde_json";
    version = "1.0.39";
    description = "A JSON serialization file format";
    authors = [ "Erick Tryzelaar <erick.tryzelaar@gmail.com>" "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "07ydv06hn8x0yl0rc94l2wl9r2xz1fqd97n1s6j3bgdc6gw406a8";
    dependencies = mapFeatures features ([
      (crates."itoa"."${deps."serde_json"."1.0.39"."itoa"}" deps)
      (crates."ryu"."${deps."serde_json"."1.0.39"."ryu"}" deps)
      (crates."serde"."${deps."serde_json"."1.0.39"."serde"}" deps)
    ]);
    features = mkFeatures (features."serde_json"."1.0.39" or {});
  };
  features_."serde_json"."1.0.39" = deps: f: updateFeatures f (rec {
    itoa."${deps.serde_json."1.0.39".itoa}".default = true;
    ryu."${deps.serde_json."1.0.39".ryu}".default = true;
    serde."${deps.serde_json."1.0.39".serde}".default = true;
    serde_json = fold recursiveUpdate {} [
      { "1.0.39"."indexmap" =
        (f.serde_json."1.0.39"."indexmap" or false) ||
        (f.serde_json."1.0.39"."preserve_order" or false) ||
        (serde_json."1.0.39"."preserve_order" or false); }
      { "1.0.39".default = (f.serde_json."1.0.39".default or true); }
    ];
  }) [
    (if deps."serde_json"."1.0.39" ? "itoa" then features_.itoa."${deps."serde_json"."1.0.39"."itoa" or ""}" deps else {})
    (if deps."serde_json"."1.0.39" ? "ryu" then features_.ryu."${deps."serde_json"."1.0.39"."ryu" or ""}" deps else {})
    (if deps."serde_json"."1.0.39" ? "serde" then features_.serde."${deps."serde_json"."1.0.39"."serde" or ""}" deps else {})
  ];


# end
# sha1-0.6.0

  crates.sha1."0.6.0" = deps: { features?(features_."sha1"."0.6.0" deps {}) }: buildRustCrate {
    crateName = "sha1";
    version = "0.6.0";
    description = "Minimal implementation of SHA1 for Rust.";
    authors = [ "Armin Ronacher <armin.ronacher@active-4.com>" ];
    sha256 = "12cp2b8f3hbwhfpnv1j1afl285xxmmbxh9w4npzvwbdh7xfyww8v";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."sha1"."0.6.0" or {});
  };
  features_."sha1"."0.6.0" = deps: f: updateFeatures f (rec {
    sha1."0.6.0".default = (f.sha1."0.6.0".default or true);
  }) [];


# end
# siphasher-0.2.3

  crates.siphasher."0.2.3" = deps: { features?(features_."siphasher"."0.2.3" deps {}) }: buildRustCrate {
    crateName = "siphasher";
    version = "0.2.3";
    description = "SipHash functions from rust-core < 1.13";
    homepage = "https://docs.rs/siphasher";
    authors = [ "Frank Denis <github@pureftpd.org>" ];
    sha256 = "1ganj1grxqnkvv4ds3vby039bm999jrr58nfq2x3kjhzkw2bnqkw";
  };
  features_."siphasher"."0.2.3" = deps: f: updateFeatures f (rec {
    siphasher."0.2.3".default = (f.siphasher."0.2.3".default or true);
  }) [];


# end
# smallvec-0.6.9

  crates.smallvec."0.6.9" = deps: { features?(features_."smallvec"."0.6.9" deps {}) }: buildRustCrate {
    crateName = "smallvec";
    version = "0.6.9";
    description = "'Small vector' optimization: store up to a small number of items on the stack";
    authors = [ "Simon Sapin <simon.sapin@exyr.org>" ];
    sha256 = "0p96l51a2pq5y0vn48nhbm6qslbc6k8h28cxm0pmzkqmj7xynz6w";
    libPath = "lib.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."smallvec"."0.6.9" or {});
  };
  features_."smallvec"."0.6.9" = deps: f: updateFeatures f (rec {
    smallvec = fold recursiveUpdate {} [
      { "0.6.9"."std" =
        (f.smallvec."0.6.9"."std" or false) ||
        (f.smallvec."0.6.9"."default" or false) ||
        (smallvec."0.6.9"."default" or false); }
      { "0.6.9".default = (f.smallvec."0.6.9".default or true); }
    ];
  }) [];


# end
# socket2-0.3.8

  crates.socket2."0.3.8" = deps: { features?(features_."socket2"."0.3.8" deps {}) }: buildRustCrate {
    crateName = "socket2";
    version = "0.3.8";
    description = "Utilities for handling networking sockets with a maximal amount of configuration
possible intended.
";
    homepage = "https://github.com/alexcrichton/socket2-rs";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1a71m20jxmf9kqqinksphc7wj1j7q672q29cpza7p9siyzyfx598";
    dependencies = (if (kernel == "linux" || kernel == "darwin") || kernel == "redox" then mapFeatures features ([
      (crates."cfg_if"."${deps."socket2"."0.3.8"."cfg_if"}" deps)
      (crates."libc"."${deps."socket2"."0.3.8"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."socket2"."0.3.8"."redox_syscall"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."socket2"."0.3.8"."winapi"}" deps)
    ]) else []);
    features = mkFeatures (features."socket2"."0.3.8" or {});
  };
  features_."socket2"."0.3.8" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.socket2."0.3.8".cfg_if}".default = true;
    libc."${deps.socket2."0.3.8".libc}".default = true;
    redox_syscall."${deps.socket2."0.3.8".redox_syscall}".default = true;
    socket2."0.3.8".default = (f.socket2."0.3.8".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.socket2."0.3.8".winapi}"."handleapi" = true; }
      { "${deps.socket2."0.3.8".winapi}"."minwindef" = true; }
      { "${deps.socket2."0.3.8".winapi}"."ws2def" = true; }
      { "${deps.socket2."0.3.8".winapi}"."ws2ipdef" = true; }
      { "${deps.socket2."0.3.8".winapi}"."ws2tcpip" = true; }
      { "${deps.socket2."0.3.8".winapi}".default = true; }
    ];
  }) [
    (if deps."socket2"."0.3.8" ? "cfg_if" then features_.cfg_if."${deps."socket2"."0.3.8"."cfg_if" or ""}" deps else {})
    (if deps."socket2"."0.3.8" ? "libc" then features_.libc."${deps."socket2"."0.3.8"."libc" or ""}" deps else {})
    (if deps."socket2"."0.3.8" ? "redox_syscall" then features_.redox_syscall."${deps."socket2"."0.3.8"."redox_syscall" or ""}" deps else {})
    (if deps."socket2"."0.3.8" ? "winapi" then features_.winapi."${deps."socket2"."0.3.8"."winapi" or ""}" deps else {})
  ];


# end
# strsim-0.9.1

  crates.strsim."0.9.1" = deps: { features?(features_."strsim"."0.9.1" deps {}) }: buildRustCrate {
    crateName = "strsim";
    version = "0.9.1";
    description = "Implementations of string similarity metrics.
Includes Hamming, Levenshtein, OSA, Damerau-Levenshtein, Jaro, and Jaro-Winkler.
";
    homepage = "https://github.com/dguo/strsim-rs";
    authors = [ "Danny Guo <dannyguo91@gmail.com>" ];
    sha256 = "0lpi3lrq6z5slay72ir1sg1ki0bvr3qia82lzx937gpc999i6bah";
    dependencies = mapFeatures features ([
      (crates."hashbrown"."${deps."strsim"."0.9.1"."hashbrown"}" deps)
      (crates."ndarray"."${deps."strsim"."0.9.1"."ndarray"}" deps)
    ]);
  };
  features_."strsim"."0.9.1" = deps: f: updateFeatures f (rec {
    hashbrown."${deps.strsim."0.9.1".hashbrown}".default = true;
    ndarray."${deps.strsim."0.9.1".ndarray}".default = true;
    strsim."0.9.1".default = (f.strsim."0.9.1".default or true);
  }) [
    (if deps."strsim"."0.9.1" ? "hashbrown" then features_.hashbrown."${deps."strsim"."0.9.1"."hashbrown" or ""}" deps else {})
    (if deps."strsim"."0.9.1" ? "ndarray" then features_.ndarray."${deps."strsim"."0.9.1"."ndarray" or ""}" deps else {})
  ];


# end
# syn-0.15.33

  crates.syn."0.15.33" = deps: { features?(features_."syn"."0.15.33" deps {}) }: buildRustCrate {
    crateName = "syn";
    version = "0.15.33";
    description = "Parser for Rust source code";
    authors = [ "David Tolnay <dtolnay@gmail.com>" ];
    sha256 = "19fv7nh1k3adh7dnbz45jg645v358n6kw8zf9xlhfcsc3532wy2j";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."syn"."0.15.33"."proc_macro2"}" deps)
      (crates."unicode_xid"."${deps."syn"."0.15.33"."unicode_xid"}" deps)
    ]
      ++ (if features.syn."0.15.33".quote or false then [ (crates.quote."${deps."syn"."0.15.33".quote}" deps) ] else []));
    features = mkFeatures (features."syn"."0.15.33" or {});
  };
  features_."syn"."0.15.33" = deps: f: updateFeatures f (rec {
    proc_macro2 = fold recursiveUpdate {} [
      { "${deps.syn."0.15.33".proc_macro2}"."proc-macro" =
        (f.proc_macro2."${deps.syn."0.15.33".proc_macro2}"."proc-macro" or false) ||
        (syn."0.15.33"."proc-macro" or false) ||
        (f."syn"."0.15.33"."proc-macro" or false); }
      { "${deps.syn."0.15.33".proc_macro2}".default = (f.proc_macro2."${deps.syn."0.15.33".proc_macro2}".default or false); }
    ];
    quote."${deps.syn."0.15.33".quote}"."proc-macro" =
        (f.quote."${deps.syn."0.15.33".quote}"."proc-macro" or false) ||
        (syn."0.15.33"."proc-macro" or false) ||
        (f."syn"."0.15.33"."proc-macro" or false);
    syn = fold recursiveUpdate {} [
      { "0.15.33"."clone-impls" =
        (f.syn."0.15.33"."clone-impls" or false) ||
        (f.syn."0.15.33"."default" or false) ||
        (syn."0.15.33"."default" or false); }
      { "0.15.33"."derive" =
        (f.syn."0.15.33"."derive" or false) ||
        (f.syn."0.15.33"."default" or false) ||
        (syn."0.15.33"."default" or false); }
      { "0.15.33"."parsing" =
        (f.syn."0.15.33"."parsing" or false) ||
        (f.syn."0.15.33"."default" or false) ||
        (syn."0.15.33"."default" or false); }
      { "0.15.33"."printing" =
        (f.syn."0.15.33"."printing" or false) ||
        (f.syn."0.15.33"."default" or false) ||
        (syn."0.15.33"."default" or false); }
      { "0.15.33"."proc-macro" =
        (f.syn."0.15.33"."proc-macro" or false) ||
        (f.syn."0.15.33"."default" or false) ||
        (syn."0.15.33"."default" or false); }
      { "0.15.33"."quote" =
        (f.syn."0.15.33"."quote" or false) ||
        (f.syn."0.15.33"."printing" or false) ||
        (syn."0.15.33"."printing" or false); }
      { "0.15.33".default = (f.syn."0.15.33".default or true); }
    ];
    unicode_xid."${deps.syn."0.15.33".unicode_xid}".default = true;
  }) [
    (f: if deps."syn"."0.15.33" ? "quote" then recursiveUpdate f { quote."${deps."syn"."0.15.33"."quote"}"."default" = false; } else f)
    (if deps."syn"."0.15.33" ? "proc_macro2" then features_.proc_macro2."${deps."syn"."0.15.33"."proc_macro2" or ""}" deps else {})
    (if deps."syn"."0.15.33" ? "quote" then features_.quote."${deps."syn"."0.15.33"."quote" or ""}" deps else {})
    (if deps."syn"."0.15.33" ? "unicode_xid" then features_.unicode_xid."${deps."syn"."0.15.33"."unicode_xid" or ""}" deps else {})
  ];


# end
# synstructure-0.10.1

  crates.synstructure."0.10.1" = deps: { features?(features_."synstructure"."0.10.1" deps {}) }: buildRustCrate {
    crateName = "synstructure";
    version = "0.10.1";
    description = "Helper methods and macros for custom derives";
    authors = [ "Nika Layzell <nika@thelayzells.com>" ];
    sha256 = "0mx2vwd0d0f7hanz15nkp0ikkfjsx9rfkph7pynxyfbj45ank4g3";
    dependencies = mapFeatures features ([
      (crates."proc_macro2"."${deps."synstructure"."0.10.1"."proc_macro2"}" deps)
      (crates."quote"."${deps."synstructure"."0.10.1"."quote"}" deps)
      (crates."syn"."${deps."synstructure"."0.10.1"."syn"}" deps)
      (crates."unicode_xid"."${deps."synstructure"."0.10.1"."unicode_xid"}" deps)
    ]);
    features = mkFeatures (features."synstructure"."0.10.1" or {});
  };
  features_."synstructure"."0.10.1" = deps: f: updateFeatures f (rec {
    proc_macro2."${deps.synstructure."0.10.1".proc_macro2}".default = true;
    quote."${deps.synstructure."0.10.1".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.synstructure."0.10.1".syn}"."extra-traits" = true; }
      { "${deps.synstructure."0.10.1".syn}"."visit" = true; }
      { "${deps.synstructure."0.10.1".syn}".default = true; }
    ];
    synstructure."0.10.1".default = (f.synstructure."0.10.1".default or true);
    unicode_xid."${deps.synstructure."0.10.1".unicode_xid}".default = true;
  }) [
    (if deps."synstructure"."0.10.1" ? "proc_macro2" then features_.proc_macro2."${deps."synstructure"."0.10.1"."proc_macro2" or ""}" deps else {})
    (if deps."synstructure"."0.10.1" ? "quote" then features_.quote."${deps."synstructure"."0.10.1"."quote" or ""}" deps else {})
    (if deps."synstructure"."0.10.1" ? "syn" then features_.syn."${deps."synstructure"."0.10.1"."syn" or ""}" deps else {})
    (if deps."synstructure"."0.10.1" ? "unicode_xid" then features_.unicode_xid."${deps."synstructure"."0.10.1"."unicode_xid" or ""}" deps else {})
  ];


# end
# tempdir-0.3.7

  crates.tempdir."0.3.7" = deps: { features?(features_."tempdir"."0.3.7" deps {}) }: buildRustCrate {
    crateName = "tempdir";
    version = "0.3.7";
    description = "A library for managing a temporary directory and deleting all contents when it's
dropped.
";
    homepage = "https://github.com/rust-lang/tempdir";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0y53sxybyljrr7lh0x0ysrsa7p7cljmwv9v80acy3rc6n97g67vy";
    dependencies = mapFeatures features ([
      (crates."rand"."${deps."tempdir"."0.3.7"."rand"}" deps)
      (crates."remove_dir_all"."${deps."tempdir"."0.3.7"."remove_dir_all"}" deps)
    ]);
  };
  features_."tempdir"."0.3.7" = deps: f: updateFeatures f (rec {
    rand."${deps.tempdir."0.3.7".rand}".default = true;
    remove_dir_all."${deps.tempdir."0.3.7".remove_dir_all}".default = true;
    tempdir."0.3.7".default = (f.tempdir."0.3.7".default or true);
  }) [
    (if deps."tempdir"."0.3.7" ? "rand" then features_.rand."${deps."tempdir"."0.3.7"."rand" or ""}" deps else {})
    (if deps."tempdir"."0.3.7" ? "remove_dir_all" then features_.remove_dir_all."${deps."tempdir"."0.3.7"."remove_dir_all" or ""}" deps else {})
  ];


# end
# tempfile-3.0.7

  crates.tempfile."3.0.7" = deps: { features?(features_."tempfile"."3.0.7" deps {}) }: buildRustCrate {
    crateName = "tempfile";
    version = "3.0.7";
    description = "A library for managing temporary files and directories.
";
    homepage = "http://stebalien.com/projects/tempfile-rs";
    authors = [ "Steven Allen <steven@stebalien.com>" "The Rust Project Developers" "Ashley Mannix <ashleymannix@live.com.au>" "Jason White <jasonaw0@gmail.com>" ];
    sha256 = "19h7ch8fvisxrrmabcnhlfj6b8vg34zaw8491x141p0n0727niaf";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."tempfile"."3.0.7"."cfg_if"}" deps)
      (crates."rand"."${deps."tempfile"."3.0.7"."rand"}" deps)
      (crates."remove_dir_all"."${deps."tempfile"."3.0.7"."remove_dir_all"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."tempfile"."3.0.7"."redox_syscall"}" deps)
    ]) else [])
      ++ (if (kernel == "linux" || kernel == "darwin") then mapFeatures features ([
      (crates."libc"."${deps."tempfile"."3.0.7"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."tempfile"."3.0.7"."winapi"}" deps)
    ]) else []);
  };
  features_."tempfile"."3.0.7" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.tempfile."3.0.7".cfg_if}".default = true;
    libc."${deps.tempfile."3.0.7".libc}".default = true;
    rand."${deps.tempfile."3.0.7".rand}".default = true;
    redox_syscall."${deps.tempfile."3.0.7".redox_syscall}".default = true;
    remove_dir_all."${deps.tempfile."3.0.7".remove_dir_all}".default = true;
    tempfile."3.0.7".default = (f.tempfile."3.0.7".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.tempfile."3.0.7".winapi}"."fileapi" = true; }
      { "${deps.tempfile."3.0.7".winapi}"."handleapi" = true; }
      { "${deps.tempfile."3.0.7".winapi}"."winbase" = true; }
      { "${deps.tempfile."3.0.7".winapi}".default = true; }
    ];
  }) [
    (if deps."tempfile"."3.0.7" ? "cfg_if" then features_.cfg_if."${deps."tempfile"."3.0.7"."cfg_if" or ""}" deps else {})
    (if deps."tempfile"."3.0.7" ? "rand" then features_.rand."${deps."tempfile"."3.0.7"."rand" or ""}" deps else {})
    (if deps."tempfile"."3.0.7" ? "remove_dir_all" then features_.remove_dir_all."${deps."tempfile"."3.0.7"."remove_dir_all" or ""}" deps else {})
    (if deps."tempfile"."3.0.7" ? "redox_syscall" then features_.redox_syscall."${deps."tempfile"."3.0.7"."redox_syscall" or ""}" deps else {})
    (if deps."tempfile"."3.0.7" ? "libc" then features_.libc."${deps."tempfile"."3.0.7"."libc" or ""}" deps else {})
    (if deps."tempfile"."3.0.7" ? "winapi" then features_.winapi."${deps."tempfile"."3.0.7"."winapi" or ""}" deps else {})
  ];


# end
# term-0.5.2

  crates.term."0.5.2" = deps: { features?(features_."term"."0.5.2" deps {}) }: buildRustCrate {
    crateName = "term";
    version = "0.5.2";
    description = "A terminal formatting library
";
    homepage = "https://github.com/Stebalien/term";
    authors = [ "The Rust Project Developers" "Steven Allen" ];
    sha256 = "1c3pjrkl9sy4b62xlvilszlrksjn3c4zfhrdfg7247c2il3lnn9x";
    dependencies = mapFeatures features ([
      (crates."byteorder"."${deps."term"."0.5.2"."byteorder"}" deps)
      (crates."dirs"."${deps."term"."0.5.2"."dirs"}" deps)
    ])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."term"."0.5.2"."winapi"}" deps)
    ]) else []);
  };
  features_."term"."0.5.2" = deps: f: updateFeatures f (rec {
    byteorder."${deps.term."0.5.2".byteorder}".default = true;
    dirs."${deps.term."0.5.2".dirs}".default = true;
    term."0.5.2".default = (f.term."0.5.2".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.term."0.5.2".winapi}"."consoleapi" = true; }
      { "${deps.term."0.5.2".winapi}"."fileapi" = true; }
      { "${deps.term."0.5.2".winapi}"."handleapi" = true; }
      { "${deps.term."0.5.2".winapi}"."wincon" = true; }
      { "${deps.term."0.5.2".winapi}".default = true; }
    ];
  }) [
    (if deps."term"."0.5.2" ? "byteorder" then features_.byteorder."${deps."term"."0.5.2"."byteorder" or ""}" deps else {})
    (if deps."term"."0.5.2" ? "dirs" then features_.dirs."${deps."term"."0.5.2"."dirs" or ""}" deps else {})
    (if deps."term"."0.5.2" ? "winapi" then features_.winapi."${deps."term"."0.5.2"."winapi" or ""}" deps else {})
  ];


# end
# termcolor-1.0.4

  crates.termcolor."1.0.4" = deps: { features?(features_."termcolor"."1.0.4" deps {}) }: buildRustCrate {
    crateName = "termcolor";
    version = "1.0.4";
    description = "A simple cross platform library for writing colored text to a terminal.
";
    homepage = "https://github.com/BurntSushi/termcolor";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0xydrjc0bxg08llcbcmkka29szdrfklk4vh6l6mdd67ajifqw1mv";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."wincolor"."${deps."termcolor"."1.0.4"."wincolor"}" deps)
    ]) else []);
  };
  features_."termcolor"."1.0.4" = deps: f: updateFeatures f (rec {
    termcolor."1.0.4".default = (f.termcolor."1.0.4".default or true);
    wincolor."${deps.termcolor."1.0.4".wincolor}".default = true;
  }) [
    (if deps."termcolor"."1.0.4" ? "wincolor" then features_.wincolor."${deps."termcolor"."1.0.4"."wincolor" or ""}" deps else {})
  ];


# end
# termion-1.5.2

  crates.termion."1.5.2" = deps: { features?(features_."termion"."1.5.2" deps {}) }: buildRustCrate {
    crateName = "termion";
    version = "1.5.2";
    description = "A bindless library for manipulating terminals.";
    authors = [ "ticki <Ticki@users.noreply.github.com>" "gycos <alexandre.bury@gmail.com>" "IGI-111 <igi-111@protonmail.com>" ];
    sha256 = "0a8znl9hdnr9d21xskb2q77r6pkvrabh71b43371vy9wq97m78d9";
    dependencies = mapFeatures features ([
      (crates."numtoa"."${deps."termion"."1.5.2"."numtoa"}" deps)
    ])
      ++ (if !(kernel == "redox") then mapFeatures features ([
      (crates."libc"."${deps."termion"."1.5.2"."libc"}" deps)
    ]) else [])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."termion"."1.5.2"."redox_syscall"}" deps)
      (crates."redox_termios"."${deps."termion"."1.5.2"."redox_termios"}" deps)
    ]) else []);
  };
  features_."termion"."1.5.2" = deps: f: updateFeatures f (rec {
    libc."${deps.termion."1.5.2".libc}".default = true;
    numtoa = fold recursiveUpdate {} [
      { "${deps.termion."1.5.2".numtoa}"."std" = true; }
      { "${deps.termion."1.5.2".numtoa}".default = true; }
    ];
    redox_syscall."${deps.termion."1.5.2".redox_syscall}".default = true;
    redox_termios."${deps.termion."1.5.2".redox_termios}".default = true;
    termion."1.5.2".default = (f.termion."1.5.2".default or true);
  }) [
    (if deps."termion"."1.5.2" ? "numtoa" then features_.numtoa."${deps."termion"."1.5.2"."numtoa" or ""}" deps else {})
    (if deps."termion"."1.5.2" ? "libc" then features_.libc."${deps."termion"."1.5.2"."libc" or ""}" deps else {})
    (if deps."termion"."1.5.2" ? "redox_syscall" then features_.redox_syscall."${deps."termion"."1.5.2"."redox_syscall" or ""}" deps else {})
    (if deps."termion"."1.5.2" ? "redox_termios" then features_.redox_termios."${deps."termion"."1.5.2"."redox_termios" or ""}" deps else {})
  ];


# end
# thread_local-0.3.6

  crates.thread_local."0.3.6" = deps: { features?(features_."thread_local"."0.3.6" deps {}) }: buildRustCrate {
    crateName = "thread_local";
    version = "0.3.6";
    description = "Per-object thread-local storage";
    authors = [ "Amanieu d'Antras <amanieu@gmail.com>" ];
    sha256 = "02rksdwjmz2pw9bmgbb4c0bgkbq5z6nvg510sq1s6y2j1gam0c7i";
    dependencies = mapFeatures features ([
      (crates."lazy_static"."${deps."thread_local"."0.3.6"."lazy_static"}" deps)
    ]);
  };
  features_."thread_local"."0.3.6" = deps: f: updateFeatures f (rec {
    lazy_static."${deps.thread_local."0.3.6".lazy_static}".default = true;
    thread_local."0.3.6".default = (f.thread_local."0.3.6".default or true);
  }) [
    (if deps."thread_local"."0.3.6" ? "lazy_static" then features_.lazy_static."${deps."thread_local"."0.3.6"."lazy_static" or ""}" deps else {})
  ];


# end
# threadpool-1.7.1

  crates.threadpool."1.7.1" = deps: { features?(features_."threadpool"."1.7.1" deps {}) }: buildRustCrate {
    crateName = "threadpool";
    version = "1.7.1";
    description = "A thread pool for running a number of jobs on a fixed set of worker threads.
";
    homepage = "https://github.com/rust-threadpool/rust-threadpool";
    authors = [ "The Rust Project Developers" "Corey Farwell <coreyf@rwell.org>" "Stefan Schindler <dns2utf8@estada.ch>" ];
    sha256 = "09g715plrn59kasvigqjrjqzcgqnaf6v6pia0xx03f18kvfmkq06";
    dependencies = mapFeatures features ([
      (crates."num_cpus"."${deps."threadpool"."1.7.1"."num_cpus"}" deps)
    ]);
  };
  features_."threadpool"."1.7.1" = deps: f: updateFeatures f (rec {
    num_cpus."${deps.threadpool."1.7.1".num_cpus}".default = true;
    threadpool."1.7.1".default = (f.threadpool."1.7.1".default or true);
  }) [
    (if deps."threadpool"."1.7.1" ? "num_cpus" then features_.num_cpus."${deps."threadpool"."1.7.1"."num_cpus" or ""}" deps else {})
  ];


# end
# time-0.1.42

  crates.time."0.1.42" = deps: { features?(features_."time"."0.1.42" deps {}) }: buildRustCrate {
    crateName = "time";
    version = "0.1.42";
    description = "Utilities for working with time-related functions in Rust.
";
    homepage = "https://github.com/rust-lang/time";
    authors = [ "The Rust Project Developers" ];
    sha256 = "1ny809kmdjwd4b478ipc33dz7q6nq7rxk766x8cnrg6zygcksmmx";
    dependencies = mapFeatures features ([
      (crates."libc"."${deps."time"."0.1.42"."libc"}" deps)
    ])
      ++ (if kernel == "redox" then mapFeatures features ([
      (crates."redox_syscall"."${deps."time"."0.1.42"."redox_syscall"}" deps)
    ]) else [])
      ++ (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."time"."0.1.42"."winapi"}" deps)
    ]) else []);
  };
  features_."time"."0.1.42" = deps: f: updateFeatures f (rec {
    libc."${deps.time."0.1.42".libc}".default = true;
    redox_syscall."${deps.time."0.1.42".redox_syscall}".default = true;
    time."0.1.42".default = (f.time."0.1.42".default or true);
    winapi = fold recursiveUpdate {} [
      { "${deps.time."0.1.42".winapi}"."minwinbase" = true; }
      { "${deps.time."0.1.42".winapi}"."minwindef" = true; }
      { "${deps.time."0.1.42".winapi}"."ntdef" = true; }
      { "${deps.time."0.1.42".winapi}"."profileapi" = true; }
      { "${deps.time."0.1.42".winapi}"."std" = true; }
      { "${deps.time."0.1.42".winapi}"."sysinfoapi" = true; }
      { "${deps.time."0.1.42".winapi}"."timezoneapi" = true; }
      { "${deps.time."0.1.42".winapi}".default = true; }
    ];
  }) [
    (if deps."time"."0.1.42" ? "libc" then features_.libc."${deps."time"."0.1.42"."libc" or ""}" deps else {})
    (if deps."time"."0.1.42" ? "redox_syscall" then features_.redox_syscall."${deps."time"."0.1.42"."redox_syscall" or ""}" deps else {})
    (if deps."time"."0.1.42" ? "winapi" then features_.winapi."${deps."time"."0.1.42"."winapi" or ""}" deps else {})
  ];


# end
# tiny_http-0.6.2

  crates.tiny_http."0.6.2" = deps: { features?(features_."tiny_http"."0.6.2" deps {}) }: buildRustCrate {
    crateName = "tiny_http";
    version = "0.6.2";
    description = "Low level HTTP server library";
    authors = [ "pierre.krieger1708@gmail.com" "Corey Farwell <coreyf@rwell.org>" ];
    sha256 = "08ws5kzqfd6f8313085ywp5x2s25w6hshy2y9sd656i7vbdpplha";
    dependencies = mapFeatures features ([
      (crates."ascii"."${deps."tiny_http"."0.6.2"."ascii"}" deps)
      (crates."chrono"."${deps."tiny_http"."0.6.2"."chrono"}" deps)
      (crates."chunked_transfer"."${deps."tiny_http"."0.6.2"."chunked_transfer"}" deps)
      (crates."log"."${deps."tiny_http"."0.6.2"."log"}" deps)
      (crates."url"."${deps."tiny_http"."0.6.2"."url"}" deps)
    ]);
    features = mkFeatures (features."tiny_http"."0.6.2" or {});
  };
  features_."tiny_http"."0.6.2" = deps: f: updateFeatures f (rec {
    ascii."${deps.tiny_http."0.6.2".ascii}".default = true;
    chrono."${deps.tiny_http."0.6.2".chrono}".default = true;
    chunked_transfer."${deps.tiny_http."0.6.2".chunked_transfer}".default = true;
    log."${deps.tiny_http."0.6.2".log}".default = true;
    tiny_http = fold recursiveUpdate {} [
      { "0.6.2"."openssl" =
        (f.tiny_http."0.6.2"."openssl" or false) ||
        (f.tiny_http."0.6.2"."ssl" or false) ||
        (tiny_http."0.6.2"."ssl" or false); }
      { "0.6.2".default = (f.tiny_http."0.6.2".default or true); }
    ];
    url."${deps.tiny_http."0.6.2".url}".default = true;
  }) [
    (if deps."tiny_http"."0.6.2" ? "ascii" then features_.ascii."${deps."tiny_http"."0.6.2"."ascii" or ""}" deps else {})
    (if deps."tiny_http"."0.6.2" ? "chrono" then features_.chrono."${deps."tiny_http"."0.6.2"."chrono" or ""}" deps else {})
    (if deps."tiny_http"."0.6.2" ? "chunked_transfer" then features_.chunked_transfer."${deps."tiny_http"."0.6.2"."chunked_transfer" or ""}" deps else {})
    (if deps."tiny_http"."0.6.2" ? "log" then features_.log."${deps."tiny_http"."0.6.2"."log" or ""}" deps else {})
    (if deps."tiny_http"."0.6.2" ? "url" then features_.url."${deps."tiny_http"."0.6.2"."url" or ""}" deps else {})
  ];


# end
# treeline-0.1.0

  crates.treeline."0.1.0" = deps: { features?(features_."treeline"."0.1.0" deps {}) }: buildRustCrate {
    crateName = "treeline";
    version = "0.1.0";
    description = "a library for visualizing tree structured data";
    homepage = "https://github.com/softprops/treeline";
    authors = [ "softprops <d.tangren@gmail.com>" ];
    sha256 = "0122i5hmryjp9ckvxn2n2nng954ppp3154pcglldg77wixqp4ir6";
  };
  features_."treeline"."0.1.0" = deps: f: updateFeatures f (rec {
    treeline."0.1.0".default = (f.treeline."0.1.0".default or true);
  }) [];


# end
# twoway-0.1.8

  crates.twoway."0.1.8" = deps: { features?(features_."twoway"."0.1.8" deps {}) }: buildRustCrate {
    crateName = "twoway";
    version = "0.1.8";
    description = "Fast substring search for strings and byte strings. Optional SSE4.2 acceleration (requires nightly and cargo feature flag pcmp) using pcmpestri. Memchr is the only mandatory dependency. The two way algorithm is also used by rust's libstd itself, but here it is exposed both for byte strings, using memchr, and optionally using a SSE4.2 accelerated version.";
    authors = [ "bluss" ];
    sha256 = "0svrdcy08h0gm884f220hx37g8fsp5z6abaw6jb6g3f7djw1ir1g";
    dependencies = mapFeatures features ([
      (crates."memchr"."${deps."twoway"."0.1.8"."memchr"}" deps)
    ]);
    features = mkFeatures (features."twoway"."0.1.8" or {});
  };
  features_."twoway"."0.1.8" = deps: f: updateFeatures f (rec {
    memchr = fold recursiveUpdate {} [
      { "${deps.twoway."0.1.8".memchr}"."use_std" =
        (f.memchr."${deps.twoway."0.1.8".memchr}"."use_std" or false) ||
        (twoway."0.1.8"."use_std" or false) ||
        (f."twoway"."0.1.8"."use_std" or false); }
      { "${deps.twoway."0.1.8".memchr}".default = (f.memchr."${deps.twoway."0.1.8".memchr}".default or false); }
    ];
    twoway = fold recursiveUpdate {} [
      { "0.1.8"."galil-seiferas" =
        (f.twoway."0.1.8"."galil-seiferas" or false) ||
        (f.twoway."0.1.8"."benchmarks" or false) ||
        (twoway."0.1.8"."benchmarks" or false); }
      { "0.1.8"."jetscii" =
        (f.twoway."0.1.8"."jetscii" or false) ||
        (f.twoway."0.1.8"."all" or false) ||
        (twoway."0.1.8"."all" or false); }
      { "0.1.8"."pattern" =
        (f.twoway."0.1.8"."pattern" or false) ||
        (f.twoway."0.1.8"."all" or false) ||
        (twoway."0.1.8"."all" or false) ||
        (f.twoway."0.1.8"."benchmarks" or false) ||
        (twoway."0.1.8"."benchmarks" or false); }
      { "0.1.8"."pcmp" =
        (f.twoway."0.1.8"."pcmp" or false) ||
        (f.twoway."0.1.8"."all" or false) ||
        (twoway."0.1.8"."all" or false); }
      { "0.1.8"."test-set" =
        (f.twoway."0.1.8"."test-set" or false) ||
        (f.twoway."0.1.8"."all" or false) ||
        (twoway."0.1.8"."all" or false); }
      { "0.1.8"."unchecked-index" =
        (f.twoway."0.1.8"."unchecked-index" or false) ||
        (f.twoway."0.1.8"."benchmarks" or false) ||
        (twoway."0.1.8"."benchmarks" or false) ||
        (f.twoway."0.1.8"."pcmp" or false) ||
        (twoway."0.1.8"."pcmp" or false); }
      { "0.1.8"."use_std" =
        (f.twoway."0.1.8"."use_std" or false) ||
        (f.twoway."0.1.8"."default" or false) ||
        (twoway."0.1.8"."default" or false); }
      { "0.1.8".default = (f.twoway."0.1.8".default or true); }
    ];
  }) [
    (if deps."twoway"."0.1.8" ? "memchr" then features_.memchr."${deps."twoway"."0.1.8"."memchr" or ""}" deps else {})
  ];


# end
# ucd-util-0.1.3

  crates.ucd_util."0.1.3" = deps: { features?(features_."ucd_util"."0.1.3" deps {}) }: buildRustCrate {
    crateName = "ucd-util";
    version = "0.1.3";
    description = "A small utility library for working with the Unicode character database.
";
    homepage = "https://github.com/BurntSushi/ucd-generate";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1n1qi3jywq5syq90z9qd8qzbn58pcjgv1sx4sdmipm4jf9zanz15";
  };
  features_."ucd_util"."0.1.3" = deps: f: updateFeatures f (rec {
    ucd_util."0.1.3".default = (f.ucd_util."0.1.3".default or true);
  }) [];


# end
# unicase-1.4.2

  crates.unicase."1.4.2" = deps: { features?(features_."unicase"."1.4.2" deps {}) }: buildRustCrate {
    crateName = "unicase";
    version = "1.4.2";
    description = "A case-insensitive wrapper around strings.";
    authors = [ "Sean McArthur <sean.monstar@gmail.com>" ];
    sha256 = "0rbnhw2mnhcwrij3vczp0sl8zdfmvf2dlh8hly81kj7132kfj0mf";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);

    buildDependencies = mapFeatures features ([
      (crates."version_check"."${deps."unicase"."1.4.2"."version_check"}" deps)
    ]);
    features = mkFeatures (features."unicase"."1.4.2" or {});
  };
  features_."unicase"."1.4.2" = deps: f: updateFeatures f (rec {
    unicase = fold recursiveUpdate {} [
      { "1.4.2"."heapsize" =
        (f.unicase."1.4.2"."heapsize" or false) ||
        (f.unicase."1.4.2"."heap_size" or false) ||
        (unicase."1.4.2"."heap_size" or false); }
      { "1.4.2"."heapsize_plugin" =
        (f.unicase."1.4.2"."heapsize_plugin" or false) ||
        (f.unicase."1.4.2"."heap_size" or false) ||
        (unicase."1.4.2"."heap_size" or false); }
      { "1.4.2".default = (f.unicase."1.4.2".default or true); }
    ];
    version_check."${deps.unicase."1.4.2".version_check}".default = true;
  }) [
    (if deps."unicase"."1.4.2" ? "version_check" then features_.version_check."${deps."unicase"."1.4.2"."version_check" or ""}" deps else {})
  ];


# end
# unicode-bidi-0.3.4

  crates.unicode_bidi."0.3.4" = deps: { features?(features_."unicode_bidi"."0.3.4" deps {}) }: buildRustCrate {
    crateName = "unicode-bidi";
    version = "0.3.4";
    description = "Implementation of the Unicode Bidirectional Algorithm";
    authors = [ "The Servo Project Developers" ];
    sha256 = "0lcd6jasrf8p9p0q20qyf10c6xhvw40m2c4rr105hbk6zy26nj1q";
    libName = "unicode_bidi";
    dependencies = mapFeatures features ([
      (crates."matches"."${deps."unicode_bidi"."0.3.4"."matches"}" deps)
    ]);
    features = mkFeatures (features."unicode_bidi"."0.3.4" or {});
  };
  features_."unicode_bidi"."0.3.4" = deps: f: updateFeatures f (rec {
    matches."${deps.unicode_bidi."0.3.4".matches}".default = true;
    unicode_bidi = fold recursiveUpdate {} [
      { "0.3.4"."flame" =
        (f.unicode_bidi."0.3.4"."flame" or false) ||
        (f.unicode_bidi."0.3.4"."flame_it" or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4"."flamer" =
        (f.unicode_bidi."0.3.4"."flamer" or false) ||
        (f.unicode_bidi."0.3.4"."flame_it" or false) ||
        (unicode_bidi."0.3.4"."flame_it" or false); }
      { "0.3.4"."serde" =
        (f.unicode_bidi."0.3.4"."serde" or false) ||
        (f.unicode_bidi."0.3.4"."with_serde" or false) ||
        (unicode_bidi."0.3.4"."with_serde" or false); }
      { "0.3.4".default = (f.unicode_bidi."0.3.4".default or true); }
    ];
  }) [
    (if deps."unicode_bidi"."0.3.4" ? "matches" then features_.matches."${deps."unicode_bidi"."0.3.4"."matches" or ""}" deps else {})
  ];


# end
# unicode-normalization-0.1.8

  crates.unicode_normalization."0.1.8" = deps: { features?(features_."unicode_normalization"."0.1.8" deps {}) }: buildRustCrate {
    crateName = "unicode-normalization";
    version = "0.1.8";
    description = "This crate provides functions for normalization of
Unicode strings, including Canonical and Compatible
Decomposition and Recomposition, as described in
Unicode Standard Annex #15.
";
    homepage = "https://github.com/unicode-rs/unicode-normalization";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "1pb26i2xd5zz0icabyqahikpca0iwj2jd4145pczc4bb7p641dsz";
    dependencies = mapFeatures features ([
      (crates."smallvec"."${deps."unicode_normalization"."0.1.8"."smallvec"}" deps)
    ]);
  };
  features_."unicode_normalization"."0.1.8" = deps: f: updateFeatures f (rec {
    smallvec."${deps.unicode_normalization."0.1.8".smallvec}".default = true;
    unicode_normalization."0.1.8".default = (f.unicode_normalization."0.1.8".default or true);
  }) [
    (if deps."unicode_normalization"."0.1.8" ? "smallvec" then features_.smallvec."${deps."unicode_normalization"."0.1.8"."smallvec" or ""}" deps else {})
  ];


# end
# unicode-segmentation-1.2.1

  crates.unicode_segmentation."1.2.1" = deps: { features?(features_."unicode_segmentation"."1.2.1" deps {}) }: buildRustCrate {
    crateName = "unicode-segmentation";
    version = "1.2.1";
    description = "This crate provides Grapheme Cluster and Word boundaries
according to Unicode Standard Annex #29 rules.
";
    homepage = "https://github.com/unicode-rs/unicode-segmentation";
    authors = [ "kwantam <kwantam@gmail.com>" ];
    sha256 = "0pzydlrq019cdiqbbfq205cskxcspwi97zfdi02rma21br1kc59m";
    features = mkFeatures (features."unicode_segmentation"."1.2.1" or {});
  };
  features_."unicode_segmentation"."1.2.1" = deps: f: updateFeatures f (rec {
    unicode_segmentation."1.2.1".default = (f.unicode_segmentation."1.2.1".default or true);
  }) [];


# end
# unicode-xid-0.1.0

  crates.unicode_xid."0.1.0" = deps: { features?(features_."unicode_xid"."0.1.0" deps {}) }: buildRustCrate {
    crateName = "unicode-xid";
    version = "0.1.0";
    description = "Determine whether characters have the XID_Start
or XID_Continue properties according to
Unicode Standard Annex #31.
";
    homepage = "https://github.com/unicode-rs/unicode-xid";
    authors = [ "erick.tryzelaar <erick.tryzelaar@gmail.com>" "kwantam <kwantam@gmail.com>" ];
    sha256 = "05wdmwlfzxhq3nhsxn6wx4q8dhxzzfb9szsz6wiw092m1rjj01zj";
    features = mkFeatures (features."unicode_xid"."0.1.0" or {});
  };
  features_."unicode_xid"."0.1.0" = deps: f: updateFeatures f (rec {
    unicode_xid."0.1.0".default = (f.unicode_xid."0.1.0".default or true);
  }) [];


# end
# url-1.7.2

  crates.url."1.7.2" = deps: { features?(features_."url"."1.7.2" deps {}) }: buildRustCrate {
    crateName = "url";
    version = "1.7.2";
    description = "URL library for Rust, based on the WHATWG URL Standard";
    authors = [ "The rust-url developers" ];
    sha256 = "0qzrjzd9r1niv7037x4cgnv98fs1vj0k18lpxx890ipc47x5gc09";
    dependencies = mapFeatures features ([
      (crates."idna"."${deps."url"."1.7.2"."idna"}" deps)
      (crates."matches"."${deps."url"."1.7.2"."matches"}" deps)
      (crates."percent_encoding"."${deps."url"."1.7.2"."percent_encoding"}" deps)
    ]);
    features = mkFeatures (features."url"."1.7.2" or {});
  };
  features_."url"."1.7.2" = deps: f: updateFeatures f (rec {
    idna."${deps.url."1.7.2".idna}".default = true;
    matches."${deps.url."1.7.2".matches}".default = true;
    percent_encoding."${deps.url."1.7.2".percent_encoding}".default = true;
    url = fold recursiveUpdate {} [
      { "1.7.2"."encoding" =
        (f.url."1.7.2"."encoding" or false) ||
        (f.url."1.7.2"."query_encoding" or false) ||
        (url."1.7.2"."query_encoding" or false); }
      { "1.7.2"."heapsize" =
        (f.url."1.7.2"."heapsize" or false) ||
        (f.url."1.7.2"."heap_size" or false) ||
        (url."1.7.2"."heap_size" or false); }
      { "1.7.2".default = (f.url."1.7.2".default or true); }
    ];
  }) [
    (if deps."url"."1.7.2" ? "idna" then features_.idna."${deps."url"."1.7.2"."idna" or ""}" deps else {})
    (if deps."url"."1.7.2" ? "matches" then features_.matches."${deps."url"."1.7.2"."matches" or ""}" deps else {})
    (if deps."url"."1.7.2" ? "percent_encoding" then features_.percent_encoding."${deps."url"."1.7.2"."percent_encoding" or ""}" deps else {})
  ];


# end
# utf8-ranges-1.0.2

  crates.utf8_ranges."1.0.2" = deps: { features?(features_."utf8_ranges"."1.0.2" deps {}) }: buildRustCrate {
    crateName = "utf8-ranges";
    version = "1.0.2";
    description = "Convert ranges of Unicode codepoints to UTF-8 byte ranges.";
    homepage = "https://github.com/BurntSushi/utf8-ranges";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "1my02laqsgnd8ib4dvjgd4rilprqjad6pb9jj9vi67csi5qs2281";
  };
  features_."utf8_ranges"."1.0.2" = deps: f: updateFeatures f (rec {
    utf8_ranges."1.0.2".default = (f.utf8_ranges."1.0.2".default or true);
  }) [];


# end
# vcpkg-0.2.6

  crates.vcpkg."0.2.6" = deps: { features?(features_."vcpkg"."0.2.6" deps {}) }: buildRustCrate {
    crateName = "vcpkg";
    version = "0.2.6";
    description = "A library to find native dependencies in a vcpkg tree at build
time in order to be used in Cargo build scripts.
";
    authors = [ "Jim McGrath <jimmc2@gmail.com>" ];
    sha256 = "1ig6jqpzzl1z9vk4qywgpfr4hfbd8ny8frqsgm3r449wkc4n1i5x";
  };
  features_."vcpkg"."0.2.6" = deps: f: updateFeatures f (rec {
    vcpkg."0.2.6".default = (f.vcpkg."0.2.6".default or true);
  }) [];


# end
# version_check-0.1.5

  crates.version_check."0.1.5" = deps: { features?(features_."version_check"."0.1.5" deps {}) }: buildRustCrate {
    crateName = "version_check";
    version = "0.1.5";
    description = "Tiny crate to check the version of the installed/running rustc.";
    authors = [ "Sergio Benitez <sb@sergio.bz>" ];
    sha256 = "1yrx9xblmwbafw2firxyqbj8f771kkzfd24n3q7xgwiqyhi0y8qd";
  };
  features_."version_check"."0.1.5" = deps: f: updateFeatures f (rec {
    version_check."0.1.5".default = (f.version_check."0.1.5".default or true);
  }) [];


# end
# walrus-0.5.0

  crates.walrus."0.5.0" = deps: { features?(features_."walrus"."0.5.0" deps {}) }: buildRustCrate {
    crateName = "walrus";
    version = "0.5.0";
    description = "A library for performing WebAssembly transformations
";
    homepage = "https://github.com/rustwasm/walrus";
    authors = [ "Nick Fitzgerald <fitzgen@gmail.com>" ];
    edition = "2018";
    sha256 = "05kwj9c5mvf6fgfkn545vw6zp3dhv882jb1nkmmm5cjnwy1lsigp";
    dependencies = mapFeatures features ([
      (crates."failure"."${deps."walrus"."0.5.0"."failure"}" deps)
      (crates."id_arena"."${deps."walrus"."0.5.0"."id_arena"}" deps)
      (crates."leb128"."${deps."walrus"."0.5.0"."leb128"}" deps)
      (crates."log"."${deps."walrus"."0.5.0"."log"}" deps)
      (crates."rayon"."${deps."walrus"."0.5.0"."rayon"}" deps)
      (crates."walrus_macro"."${deps."walrus"."0.5.0"."walrus_macro"}" deps)
      (crates."wasmparser"."${deps."walrus"."0.5.0"."wasmparser"}" deps)
    ]);
  };
  features_."walrus"."0.5.0" = deps: f: updateFeatures f (rec {
    failure."${deps.walrus."0.5.0".failure}".default = true;
    id_arena = fold recursiveUpdate {} [
      { "${deps.walrus."0.5.0".id_arena}"."rayon" = true; }
      { "${deps.walrus."0.5.0".id_arena}".default = true; }
    ];
    leb128."${deps.walrus."0.5.0".leb128}".default = true;
    log."${deps.walrus."0.5.0".log}".default = true;
    rayon."${deps.walrus."0.5.0".rayon}".default = true;
    walrus."0.5.0".default = (f.walrus."0.5.0".default or true);
    walrus_macro."${deps.walrus."0.5.0".walrus_macro}".default = true;
    wasmparser."${deps.walrus."0.5.0".wasmparser}".default = true;
  }) [
    (if deps."walrus"."0.5.0" ? "failure" then features_.failure."${deps."walrus"."0.5.0"."failure" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "id_arena" then features_.id_arena."${deps."walrus"."0.5.0"."id_arena" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "leb128" then features_.leb128."${deps."walrus"."0.5.0"."leb128" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "log" then features_.log."${deps."walrus"."0.5.0"."log" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "rayon" then features_.rayon."${deps."walrus"."0.5.0"."rayon" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "walrus_macro" then features_.walrus_macro."${deps."walrus"."0.5.0"."walrus_macro" or ""}" deps else {})
    (if deps."walrus"."0.5.0" ? "wasmparser" then features_.wasmparser."${deps."walrus"."0.5.0"."wasmparser" or ""}" deps else {})
  ];


# end
# walrus-macro-0.5.0

  crates.walrus_macro."0.5.0" = deps: { features?(features_."walrus_macro"."0.5.0" deps {}) }: buildRustCrate {
    crateName = "walrus-macro";
    version = "0.5.0";
    description = "Internal macros used by the `walrus` crate, not for public consumption.
";
    homepage = "https://github.com/rustwasm/walrus";
    authors = [ "Nick Fitzgerald <fitzgen@gmail.com>" ];
    edition = "2018";
    sha256 = "0cw6jhqs9g7hcjpcwdjg7v9sawjyy4b2x9g9xp1c6qpnim8ajzwb";
    procMacro = true;
    dependencies = mapFeatures features ([
      (crates."heck"."${deps."walrus_macro"."0.5.0"."heck"}" deps)
      (crates."proc_macro2"."${deps."walrus_macro"."0.5.0"."proc_macro2"}" deps)
      (crates."quote"."${deps."walrus_macro"."0.5.0"."quote"}" deps)
      (crates."syn"."${deps."walrus_macro"."0.5.0"."syn"}" deps)
    ]);
  };
  features_."walrus_macro"."0.5.0" = deps: f: updateFeatures f (rec {
    heck."${deps.walrus_macro."0.5.0".heck}".default = true;
    proc_macro2."${deps.walrus_macro."0.5.0".proc_macro2}".default = true;
    quote."${deps.walrus_macro."0.5.0".quote}".default = true;
    syn = fold recursiveUpdate {} [
      { "${deps.walrus_macro."0.5.0".syn}"."extra-traits" = true; }
      { "${deps.walrus_macro."0.5.0".syn}".default = true; }
    ];
    walrus_macro."0.5.0".default = (f.walrus_macro."0.5.0".default or true);
  }) [
    (if deps."walrus_macro"."0.5.0" ? "heck" then features_.heck."${deps."walrus_macro"."0.5.0"."heck" or ""}" deps else {})
    (if deps."walrus_macro"."0.5.0" ? "proc_macro2" then features_.proc_macro2."${deps."walrus_macro"."0.5.0"."proc_macro2" or ""}" deps else {})
    (if deps."walrus_macro"."0.5.0" ? "quote" then features_.quote."${deps."walrus_macro"."0.5.0"."quote" or ""}" deps else {})
    (if deps."walrus_macro"."0.5.0" ? "syn" then features_.syn."${deps."walrus_macro"."0.5.0"."syn" or ""}" deps else {})
  ];


# end
# wasm-bindgen-anyref-xform-0.2.43

  crates.wasm_bindgen_anyref_xform."0.2.43" = deps: { features?(features_."wasm_bindgen_anyref_xform"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-anyref-xform";
    version = "0.2.43";
    description = "Internal anyref transformations for wasm-bindgen
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "1s9h7h2qb66xdc4p3bp339h8y2fg3v3ha5b5sq6gsm4rcygdf1am";
    dependencies = mapFeatures features ([
      (crates."failure"."${deps."wasm_bindgen_anyref_xform"."0.2.43"."failure"}" deps)
      (crates."walrus"."${deps."wasm_bindgen_anyref_xform"."0.2.43"."walrus"}" deps)
    ]);
  };
  features_."wasm_bindgen_anyref_xform"."0.2.43" = deps: f: updateFeatures f (rec {
    failure."${deps.wasm_bindgen_anyref_xform."0.2.43".failure}".default = true;
    walrus."${deps.wasm_bindgen_anyref_xform."0.2.43".walrus}".default = true;
    wasm_bindgen_anyref_xform."0.2.43".default = (f.wasm_bindgen_anyref_xform."0.2.43".default or true);
  }) [
    (if deps."wasm_bindgen_anyref_xform"."0.2.43" ? "failure" then features_.failure."${deps."wasm_bindgen_anyref_xform"."0.2.43"."failure" or ""}" deps else {})
    (if deps."wasm_bindgen_anyref_xform"."0.2.43" ? "walrus" then features_.walrus."${deps."wasm_bindgen_anyref_xform"."0.2.43"."walrus" or ""}" deps else {})
  ];


# end
# wasm-bindgen-cli-0.2.43

  crates.wasm_bindgen_cli."0.2.43" = deps: { features?(features_."wasm_bindgen_cli"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-cli";
    version = "0.2.43";
    description = "Command line interface of the `#[wasm_bindgen]` attribute and project. For more
information see https://github.com/alexcrichton/wasm-bindgen.
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "06390g8miixckkyll2rsd6xbjpmbm744cajximh6xm41sn824b4f";
    dependencies = mapFeatures features ([
      (crates."curl"."${deps."wasm_bindgen_cli"."0.2.43"."curl"}" deps)
      (crates."docopt"."${deps."wasm_bindgen_cli"."0.2.43"."docopt"}" deps)
      (crates."env_logger"."${deps."wasm_bindgen_cli"."0.2.43"."env_logger"}" deps)
      (crates."failure"."${deps."wasm_bindgen_cli"."0.2.43"."failure"}" deps)
      (crates."log"."${deps."wasm_bindgen_cli"."0.2.43"."log"}" deps)
      (crates."rouille"."${deps."wasm_bindgen_cli"."0.2.43"."rouille"}" deps)
      (crates."serde"."${deps."wasm_bindgen_cli"."0.2.43"."serde"}" deps)
      (crates."serde_derive"."${deps."wasm_bindgen_cli"."0.2.43"."serde_derive"}" deps)
      (crates."serde_json"."${deps."wasm_bindgen_cli"."0.2.43"."serde_json"}" deps)
      (crates."walrus"."${deps."wasm_bindgen_cli"."0.2.43"."walrus"}" deps)
      (crates."wasm_bindgen_cli_support"."${deps."wasm_bindgen_cli"."0.2.43"."wasm_bindgen_cli_support"}" deps)
      (crates."wasm_bindgen_shared"."${deps."wasm_bindgen_cli"."0.2.43"."wasm_bindgen_shared"}" deps)
    ]
      ++ (if features.wasm_bindgen_cli."0.2.43".openssl or false then [ (crates.openssl."${deps."wasm_bindgen_cli"."0.2.43".openssl}" deps) ] else []));
    features = mkFeatures (features."wasm_bindgen_cli"."0.2.43" or {});
  };
  features_."wasm_bindgen_cli"."0.2.43" = deps: f: updateFeatures f (rec {
    curl."${deps.wasm_bindgen_cli."0.2.43".curl}".default = true;
    docopt."${deps.wasm_bindgen_cli."0.2.43".docopt}".default = true;
    env_logger."${deps.wasm_bindgen_cli."0.2.43".env_logger}".default = true;
    failure."${deps.wasm_bindgen_cli."0.2.43".failure}".default = true;
    log."${deps.wasm_bindgen_cli."0.2.43".log}".default = true;
    openssl."${deps.wasm_bindgen_cli."0.2.43".openssl}"."vendored" =
        (f.openssl."${deps.wasm_bindgen_cli."0.2.43".openssl}"."vendored" or false) ||
        (wasm_bindgen_cli."0.2.43"."vendored-openssl" or false) ||
        (f."wasm_bindgen_cli"."0.2.43"."vendored-openssl" or false);
    rouille."${deps.wasm_bindgen_cli."0.2.43".rouille}".default = (f.rouille."${deps.wasm_bindgen_cli."0.2.43".rouille}".default or false);
    serde = fold recursiveUpdate {} [
      { "${deps.wasm_bindgen_cli."0.2.43".serde}"."derive" = true; }
      { "${deps.wasm_bindgen_cli."0.2.43".serde}".default = true; }
    ];
    serde_derive."${deps.wasm_bindgen_cli."0.2.43".serde_derive}".default = true;
    serde_json."${deps.wasm_bindgen_cli."0.2.43".serde_json}".default = true;
    walrus."${deps.wasm_bindgen_cli."0.2.43".walrus}".default = true;
    wasm_bindgen_cli."0.2.43".default = (f.wasm_bindgen_cli."0.2.43".default or true);
    wasm_bindgen_cli_support."${deps.wasm_bindgen_cli."0.2.43".wasm_bindgen_cli_support}".default = true;
    wasm_bindgen_shared."${deps.wasm_bindgen_cli."0.2.43".wasm_bindgen_shared}".default = true;
  }) [
    (f: if deps."wasm_bindgen_cli"."0.2.43" ? "openssl" then recursiveUpdate f { openssl."${deps."wasm_bindgen_cli"."0.2.43"."openssl"}"."default" = true; } else f)
    (if deps."wasm_bindgen_cli"."0.2.43" ? "curl" then features_.curl."${deps."wasm_bindgen_cli"."0.2.43"."curl" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "docopt" then features_.docopt."${deps."wasm_bindgen_cli"."0.2.43"."docopt" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "env_logger" then features_.env_logger."${deps."wasm_bindgen_cli"."0.2.43"."env_logger" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "failure" then features_.failure."${deps."wasm_bindgen_cli"."0.2.43"."failure" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "log" then features_.log."${deps."wasm_bindgen_cli"."0.2.43"."log" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "openssl" then features_.openssl."${deps."wasm_bindgen_cli"."0.2.43"."openssl" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "rouille" then features_.rouille."${deps."wasm_bindgen_cli"."0.2.43"."rouille" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "serde" then features_.serde."${deps."wasm_bindgen_cli"."0.2.43"."serde" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "serde_derive" then features_.serde_derive."${deps."wasm_bindgen_cli"."0.2.43"."serde_derive" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "serde_json" then features_.serde_json."${deps."wasm_bindgen_cli"."0.2.43"."serde_json" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "walrus" then features_.walrus."${deps."wasm_bindgen_cli"."0.2.43"."walrus" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "wasm_bindgen_cli_support" then features_.wasm_bindgen_cli_support."${deps."wasm_bindgen_cli"."0.2.43"."wasm_bindgen_cli_support" or ""}" deps else {})
    (if deps."wasm_bindgen_cli"."0.2.43" ? "wasm_bindgen_shared" then features_.wasm_bindgen_shared."${deps."wasm_bindgen_cli"."0.2.43"."wasm_bindgen_shared" or ""}" deps else {})
  ];


# end
# wasm-bindgen-cli-support-0.2.43

  crates.wasm_bindgen_cli_support."0.2.43" = deps: { features?(features_."wasm_bindgen_cli_support"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-cli-support";
    version = "0.2.43";
    description = "Shared support for the wasm-bindgen-cli package, an internal dependency
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "1ck4z18s9mvgdirj4mdwyxlfv3lj0mhrycbxlz7mp75mdjy8f3bh";
    dependencies = mapFeatures features ([
      (crates."base64"."${deps."wasm_bindgen_cli_support"."0.2.43"."base64"}" deps)
      (crates."failure"."${deps."wasm_bindgen_cli_support"."0.2.43"."failure"}" deps)
      (crates."log"."${deps."wasm_bindgen_cli_support"."0.2.43"."log"}" deps)
      (crates."rustc_demangle"."${deps."wasm_bindgen_cli_support"."0.2.43"."rustc_demangle"}" deps)
      (crates."serde_json"."${deps."wasm_bindgen_cli_support"."0.2.43"."serde_json"}" deps)
      (crates."tempfile"."${deps."wasm_bindgen_cli_support"."0.2.43"."tempfile"}" deps)
      (crates."walrus"."${deps."wasm_bindgen_cli_support"."0.2.43"."walrus"}" deps)
      (crates."wasm_bindgen_anyref_xform"."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_anyref_xform"}" deps)
      (crates."wasm_bindgen_shared"."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_shared"}" deps)
      (crates."wasm_bindgen_threads_xform"."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_threads_xform"}" deps)
      (crates."wasm_bindgen_wasm_interpreter"."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_wasm_interpreter"}" deps)
    ]);
  };
  features_."wasm_bindgen_cli_support"."0.2.43" = deps: f: updateFeatures f (rec {
    base64."${deps.wasm_bindgen_cli_support."0.2.43".base64}".default = true;
    failure."${deps.wasm_bindgen_cli_support."0.2.43".failure}".default = true;
    log."${deps.wasm_bindgen_cli_support."0.2.43".log}".default = true;
    rustc_demangle."${deps.wasm_bindgen_cli_support."0.2.43".rustc_demangle}".default = true;
    serde_json."${deps.wasm_bindgen_cli_support."0.2.43".serde_json}".default = true;
    tempfile."${deps.wasm_bindgen_cli_support."0.2.43".tempfile}".default = true;
    walrus."${deps.wasm_bindgen_cli_support."0.2.43".walrus}".default = true;
    wasm_bindgen_anyref_xform."${deps.wasm_bindgen_cli_support."0.2.43".wasm_bindgen_anyref_xform}".default = true;
    wasm_bindgen_cli_support."0.2.43".default = (f.wasm_bindgen_cli_support."0.2.43".default or true);
    wasm_bindgen_shared."${deps.wasm_bindgen_cli_support."0.2.43".wasm_bindgen_shared}".default = true;
    wasm_bindgen_threads_xform."${deps.wasm_bindgen_cli_support."0.2.43".wasm_bindgen_threads_xform}".default = true;
    wasm_bindgen_wasm_interpreter."${deps.wasm_bindgen_cli_support."0.2.43".wasm_bindgen_wasm_interpreter}".default = true;
  }) [
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "base64" then features_.base64."${deps."wasm_bindgen_cli_support"."0.2.43"."base64" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "failure" then features_.failure."${deps."wasm_bindgen_cli_support"."0.2.43"."failure" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "log" then features_.log."${deps."wasm_bindgen_cli_support"."0.2.43"."log" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "rustc_demangle" then features_.rustc_demangle."${deps."wasm_bindgen_cli_support"."0.2.43"."rustc_demangle" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "serde_json" then features_.serde_json."${deps."wasm_bindgen_cli_support"."0.2.43"."serde_json" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "tempfile" then features_.tempfile."${deps."wasm_bindgen_cli_support"."0.2.43"."tempfile" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "walrus" then features_.walrus."${deps."wasm_bindgen_cli_support"."0.2.43"."walrus" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "wasm_bindgen_anyref_xform" then features_.wasm_bindgen_anyref_xform."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_anyref_xform" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "wasm_bindgen_shared" then features_.wasm_bindgen_shared."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_shared" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "wasm_bindgen_threads_xform" then features_.wasm_bindgen_threads_xform."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_threads_xform" or ""}" deps else {})
    (if deps."wasm_bindgen_cli_support"."0.2.43" ? "wasm_bindgen_wasm_interpreter" then features_.wasm_bindgen_wasm_interpreter."${deps."wasm_bindgen_cli_support"."0.2.43"."wasm_bindgen_wasm_interpreter" or ""}" deps else {})
  ];


# end
# wasm-bindgen-shared-0.2.43

  crates.wasm_bindgen_shared."0.2.43" = deps: { features?(features_."wasm_bindgen_shared"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-shared";
    version = "0.2.43";
    description = "Shared support between wasm-bindgen and wasm-bindgen cli, an internal
dependency.
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "0figmai3m9qlci7h6klyzmsiighg6z5l4bijs8jr03iclrhl37gk";
  };
  features_."wasm_bindgen_shared"."0.2.43" = deps: f: updateFeatures f (rec {
    wasm_bindgen_shared."0.2.43".default = (f.wasm_bindgen_shared."0.2.43".default or true);
  }) [];


# end
# wasm-bindgen-threads-xform-0.2.43

  crates.wasm_bindgen_threads_xform."0.2.43" = deps: { features?(features_."wasm_bindgen_threads_xform"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-threads-xform";
    version = "0.2.43";
    description = "Support for threading-related transformations in wasm-bindgen
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "1ddqaizlab6vr25kbhfcgizhc8vfpzx0mb9gxmmi4fkw207xq3d5";
    dependencies = mapFeatures features ([
      (crates."failure"."${deps."wasm_bindgen_threads_xform"."0.2.43"."failure"}" deps)
      (crates."walrus"."${deps."wasm_bindgen_threads_xform"."0.2.43"."walrus"}" deps)
    ]);
  };
  features_."wasm_bindgen_threads_xform"."0.2.43" = deps: f: updateFeatures f (rec {
    failure."${deps.wasm_bindgen_threads_xform."0.2.43".failure}".default = true;
    walrus."${deps.wasm_bindgen_threads_xform."0.2.43".walrus}".default = true;
    wasm_bindgen_threads_xform."0.2.43".default = (f.wasm_bindgen_threads_xform."0.2.43".default or true);
  }) [
    (if deps."wasm_bindgen_threads_xform"."0.2.43" ? "failure" then features_.failure."${deps."wasm_bindgen_threads_xform"."0.2.43"."failure" or ""}" deps else {})
    (if deps."wasm_bindgen_threads_xform"."0.2.43" ? "walrus" then features_.walrus."${deps."wasm_bindgen_threads_xform"."0.2.43"."walrus" or ""}" deps else {})
  ];


# end
# wasm-bindgen-wasm-interpreter-0.2.43

  crates.wasm_bindgen_wasm_interpreter."0.2.43" = deps: { features?(features_."wasm_bindgen_wasm_interpreter"."0.2.43" deps {}) }: buildRustCrate {
    crateName = "wasm-bindgen-wasm-interpreter";
    version = "0.2.43";
    description = "Micro-interpreter optimized for wasm-bindgen's use case
";
    homepage = "https://rustwasm.github.io/wasm-bindgen/";
    authors = [ "The wasm-bindgen Developers" ];
    edition = "2018";
    sha256 = "0iqp6dccmdbgkh51flykl5w3q3vqprdnjrr803951hr7z6jsn4ks";
    dependencies = mapFeatures features ([
      (crates."failure"."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."failure"}" deps)
      (crates."log"."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."log"}" deps)
      (crates."walrus"."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."walrus"}" deps)
    ]);
  };
  features_."wasm_bindgen_wasm_interpreter"."0.2.43" = deps: f: updateFeatures f (rec {
    failure."${deps.wasm_bindgen_wasm_interpreter."0.2.43".failure}".default = true;
    log."${deps.wasm_bindgen_wasm_interpreter."0.2.43".log}".default = true;
    walrus."${deps.wasm_bindgen_wasm_interpreter."0.2.43".walrus}".default = true;
    wasm_bindgen_wasm_interpreter."0.2.43".default = (f.wasm_bindgen_wasm_interpreter."0.2.43".default or true);
  }) [
    (if deps."wasm_bindgen_wasm_interpreter"."0.2.43" ? "failure" then features_.failure."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."failure" or ""}" deps else {})
    (if deps."wasm_bindgen_wasm_interpreter"."0.2.43" ? "log" then features_.log."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."log" or ""}" deps else {})
    (if deps."wasm_bindgen_wasm_interpreter"."0.2.43" ? "walrus" then features_.walrus."${deps."wasm_bindgen_wasm_interpreter"."0.2.43"."walrus" or ""}" deps else {})
  ];


# end
# wasmparser-0.29.2

  crates.wasmparser."0.29.2" = deps: { features?(features_."wasmparser"."0.29.2" deps {}) }: buildRustCrate {
    crateName = "wasmparser";
    version = "0.29.2";
    description = "A simple event-driven library for parsing WebAssembly binary files.
";
    authors = [ "Yury Delendik <ydelendik@mozilla.com>" ];
    sha256 = "1myv5d0ppl8404qb4v5gbnzyaa40dkxxarvy0ir2lw3jvr5n8s8i";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."wasmparser"."0.29.2" or {});
  };
  features_."wasmparser"."0.29.2" = deps: f: updateFeatures f (rec {
    wasmparser = fold recursiveUpdate {} [
      { "0.29.2"."hashmap_core" =
        (f.wasmparser."0.29.2"."hashmap_core" or false) ||
        (f.wasmparser."0.29.2"."core" or false) ||
        (wasmparser."0.29.2"."core" or false); }
      { "0.29.2"."std" =
        (f.wasmparser."0.29.2"."std" or false) ||
        (f.wasmparser."0.29.2"."default" or false) ||
        (wasmparser."0.29.2"."default" or false); }
      { "0.29.2".default = (f.wasmparser."0.29.2".default or true); }
    ];
  }) [];


# end
# winapi-0.2.8

  crates.winapi."0.2.8" = deps: { features?(features_."winapi"."0.2.8" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.2.8";
    description = "Types and constants for WinAPI bindings. See README for list of crates providing function bindings.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0a45b58ywf12vb7gvj6h3j264nydynmzyqz8d8rqxsj6icqv82as";
  };
  features_."winapi"."0.2.8" = deps: f: updateFeatures f (rec {
    winapi."0.2.8".default = (f.winapi."0.2.8".default or true);
  }) [];


# end
# winapi-0.3.7

  crates.winapi."0.3.7" = deps: { features?(features_."winapi"."0.3.7" deps {}) }: buildRustCrate {
    crateName = "winapi";
    version = "0.3.7";
    description = "Raw FFI bindings for all of Windows API.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1k51gfkp0zqw7nj07y443mscs46icmdhld442s2073niap0kkdr8";
    build = "build.rs";
    dependencies = (if kernel == "i686-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_i686_pc_windows_gnu"."${deps."winapi"."0.3.7"."winapi_i686_pc_windows_gnu"}" deps)
    ]) else [])
      ++ (if kernel == "x86_64-pc-windows-gnu" then mapFeatures features ([
      (crates."winapi_x86_64_pc_windows_gnu"."${deps."winapi"."0.3.7"."winapi_x86_64_pc_windows_gnu"}" deps)
    ]) else []);
    features = mkFeatures (features."winapi"."0.3.7" or {});
  };
  features_."winapi"."0.3.7" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "0.3.7"."impl-debug" =
        (f.winapi."0.3.7"."impl-debug" or false) ||
        (f.winapi."0.3.7"."debug" or false) ||
        (winapi."0.3.7"."debug" or false); }
      { "0.3.7".default = (f.winapi."0.3.7".default or true); }
    ];
    winapi_i686_pc_windows_gnu."${deps.winapi."0.3.7".winapi_i686_pc_windows_gnu}".default = true;
    winapi_x86_64_pc_windows_gnu."${deps.winapi."0.3.7".winapi_x86_64_pc_windows_gnu}".default = true;
  }) [
    (if deps."winapi"."0.3.7" ? "winapi_i686_pc_windows_gnu" then features_.winapi_i686_pc_windows_gnu."${deps."winapi"."0.3.7"."winapi_i686_pc_windows_gnu" or ""}" deps else {})
    (if deps."winapi"."0.3.7" ? "winapi_x86_64_pc_windows_gnu" then features_.winapi_x86_64_pc_windows_gnu."${deps."winapi"."0.3.7"."winapi_x86_64_pc_windows_gnu" or ""}" deps else {})
  ];


# end
# winapi-build-0.1.1

  crates.winapi_build."0.1.1" = deps: { features?(features_."winapi_build"."0.1.1" deps {}) }: buildRustCrate {
    crateName = "winapi-build";
    version = "0.1.1";
    description = "Common code for build.rs in WinAPI -sys crates.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "1lxlpi87rkhxcwp2ykf1ldw3p108hwm24nywf3jfrvmff4rjhqga";
    libName = "build";
  };
  features_."winapi_build"."0.1.1" = deps: f: updateFeatures f (rec {
    winapi_build."0.1.1".default = (f.winapi_build."0.1.1".default or true);
  }) [];


# end
# winapi-i686-pc-windows-gnu-0.4.0

  crates.winapi_i686_pc_windows_gnu."0.4.0" = deps: { features?(features_."winapi_i686_pc_windows_gnu"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the i686-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "05ihkij18r4gamjpxj4gra24514can762imjzlmak5wlzidplzrp";
    build = "build.rs";
  };
  features_."winapi_i686_pc_windows_gnu"."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_i686_pc_windows_gnu."0.4.0".default = (f.winapi_i686_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# winapi-util-0.1.2

  crates.winapi_util."0.1.2" = deps: { features?(features_."winapi_util"."0.1.2" deps {}) }: buildRustCrate {
    crateName = "winapi-util";
    version = "0.1.2";
    description = "A dumping ground for high level safe wrappers over winapi.";
    homepage = "https://github.com/BurntSushi/winapi-util";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "07jj7rg7nndd7bqhjin1xphbv8kb5clvhzpqpxkvm3wl84r3mj1h";
    dependencies = (if kernel == "windows" then mapFeatures features ([
      (crates."winapi"."${deps."winapi_util"."0.1.2"."winapi"}" deps)
    ]) else []);
  };
  features_."winapi_util"."0.1.2" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.winapi_util."0.1.2".winapi}"."consoleapi" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."errhandlingapi" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."fileapi" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."minwindef" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."processenv" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."std" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."winbase" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."wincon" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."winerror" = true; }
      { "${deps.winapi_util."0.1.2".winapi}"."winnt" = true; }
      { "${deps.winapi_util."0.1.2".winapi}".default = true; }
    ];
    winapi_util."0.1.2".default = (f.winapi_util."0.1.2".default or true);
  }) [
    (if deps."winapi_util"."0.1.2" ? "winapi" then features_.winapi."${deps."winapi_util"."0.1.2"."winapi" or ""}" deps else {})
  ];


# end
# winapi-x86_64-pc-windows-gnu-0.4.0

  crates.winapi_x86_64_pc_windows_gnu."0.4.0" = deps: { features?(features_."winapi_x86_64_pc_windows_gnu"."0.4.0" deps {}) }: buildRustCrate {
    crateName = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    description = "Import libraries for the x86_64-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
    authors = [ "Peter Atashian <retep998@gmail.com>" ];
    sha256 = "0n1ylmlsb8yg1v583i4xy0qmqg42275flvbc51hdqjjfjcl9vlbj";
    build = "build.rs";
  };
  features_."winapi_x86_64_pc_windows_gnu"."0.4.0" = deps: f: updateFeatures f (rec {
    winapi_x86_64_pc_windows_gnu."0.4.0".default = (f.winapi_x86_64_pc_windows_gnu."0.4.0".default or true);
  }) [];


# end
# wincolor-1.0.1

  crates.wincolor."1.0.1" = deps: { features?(features_."wincolor"."1.0.1" deps {}) }: buildRustCrate {
    crateName = "wincolor";
    version = "1.0.1";
    description = "A simple Windows specific API for controlling text color in a Windows console.
";
    homepage = "https://github.com/BurntSushi/termcolor/tree/master/wincolor";
    authors = [ "Andrew Gallant <jamslam@gmail.com>" ];
    sha256 = "0gr7v4krmjba7yq16071rfacz42qbapas7mxk5nphjwb042a8gvz";
    dependencies = mapFeatures features ([
      (crates."winapi"."${deps."wincolor"."1.0.1"."winapi"}" deps)
      (crates."winapi_util"."${deps."wincolor"."1.0.1"."winapi_util"}" deps)
    ]);
  };
  features_."wincolor"."1.0.1" = deps: f: updateFeatures f (rec {
    winapi = fold recursiveUpdate {} [
      { "${deps.wincolor."1.0.1".winapi}"."minwindef" = true; }
      { "${deps.wincolor."1.0.1".winapi}"."wincon" = true; }
      { "${deps.wincolor."1.0.1".winapi}".default = true; }
    ];
    winapi_util."${deps.wincolor."1.0.1".winapi_util}".default = true;
    wincolor."1.0.1".default = (f.wincolor."1.0.1".default or true);
  }) [
    (if deps."wincolor"."1.0.1" ? "winapi" then features_.winapi."${deps."wincolor"."1.0.1"."winapi" or ""}" deps else {})
    (if deps."wincolor"."1.0.1" ? "winapi_util" then features_.winapi_util."${deps."wincolor"."1.0.1"."winapi_util" or ""}" deps else {})
  ];


# end
}
