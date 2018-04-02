use std::io::Write;
use std::path::Path;
use std::io::prelude::*;
use std::fs::File;
use std::env;
use std::process::exit;
use std::error::Error;

#[macro_use]
extern crate lazy_static;

lazy_static! {
    static ref MAX_BRIGHTNESS: f32 =
        read_u32_from_file("/sys/class/backlight/intel_backlight/max_brightness") as f32;
}

fn main() {
    let args: Vec<String> = env::args().collect();

    match args.len() {
        1 => println!("{}", get_current_brightness().round() as u32),
        2 => {
            let desired_brightness = match str_to_num(args[1].trim()) {
                None => print_help(),
                Some(num) => num as f32,
            };
            set_brightness(desired_brightness);
        },
        3 => {
            let desired_change = match str_to_num(args[2].trim()) {
                None => print_help(),
                Some(num) => num as f32,
            };
            match args[1].trim() {
                "+" => change_brightness_by(desired_change),
                "-" => change_brightness_by(-desired_change),
                _ => print_help(),
            };
        },
        _ => print_help(),
    }
}

fn change_brightness_by(num: f32) {
    set_brightness((get_current_brightness() + num).min(100 as f32).max(0 as f32));
}

fn get_current_brightness() -> f32 {
    read_u32_from_file("/sys/class/backlight/intel_backlight/brightness") as f32 / *MAX_BRIGHTNESS * 100 as f32
}

fn set_brightness(brightness: f32) {
    write_u32_to_file("/sys/class/backlight/intel_backlight/brightness", (brightness * *MAX_BRIGHTNESS / (100 as f32)) as u32);
}

fn str_to_num(string: &str) -> Option<u32> {
    match u32::from_str_radix(string, 10) {
        Err(_) => None,
        Ok(num) => Some(num)
    }
}

fn read_u32_from_file(path: &str) -> u32 {
    let file_path = Path::new(path);

    let mut file = match File::open(&file_path) {
        Err(_) => return 937,
        Ok(file) => file,
    };

    let mut s = String::new();
    match file.read_to_string(&mut s) {
        Err(_) => return 937,
        Ok(_) => (),
    };

    str_to_num(s.trim()).expect("Invalid max brightness.")
}

fn write_u32_to_file(path: &str, num: u32) {
    let file_path = Path::new(path);

    let mut file = match File::create(&file_path) {
        Err(why) => panic!("Couldn't open brightness file: {}", why.description()),
        Ok(file) => file,
    };

    let _ = writeln!(&mut file, "{}", num);
}

fn print_help() -> ! {
    let args: Vec<String> = env::args().collect();
    let _ = writeln!(&mut std::io::stderr(),
"usage: {} [+|-] value\n\
\n\
Modifies the screen brightness.\n\
When a + or - is present, the modification is relative. When none is present, it's absolute. Possible values range from 0 to 100.\n\
When no arguments are present the current brightness is printed.",
        args[0]);
    exit(1);
}
