extern crate clap;
extern crate glob;
extern crate rayon;

use clap::{App, Arg};
use glob::glob;
use rayon::prelude::*;
use std::process::Command;

fn main() {
    let matches = App::new("Plonk Honk")
        .version("1.0")
        .author("Daniel Pagan <dpagan@ibm.com>")
        .arg(
            Arg::with_name("target")
                .required(true)
                .help("target name or IP")
                .index(1),
        )
        .arg(
            Arg::with_name("results")
                .short("o")
                .long("output")
                .value_name("DIR")
                .help("optional results directory with a default of ./results"),
        )
        .arg(
            Arg::with_name("plugins")
                .short("P")
                .value_name("DIR")
                .help("optional location of the plugin directory"),
        )
        .arg(
            Arg::with_name("port")
                .short("p")
                .help("list of ports to scan")
                .multiple(true),
        )
        .arg(
            Arg::with_name("seclist")
                .short("w")
                .help("directory where SecLists are installed")
                .value_name("DIR"),
        )
        .get_matches();

    // loop through the plugin directory
    let plugindir = matches.value_of("plugins").unwrap_or("./plugins");
    let pluginglob = format!("{}{}", plugindir, "/*.fish");
    let paths: Vec<String> = glob(&pluginglob)
        .expect("Failed to read glob pattern")
        .map(|entry| match entry {
            Ok(path) => String::from(path.to_str().unwrap()),
            Err(_) => panic!("fatal"),
        })
        .collect();
    paths.par_iter().for_each(|path| {
        println!("Running {:?}", path);
        Command::new("fish")
            .arg("-c")
            .arg(format!("echo {}", path))
            .status()
            .expect("Failed to execute plugin");
    })
}
