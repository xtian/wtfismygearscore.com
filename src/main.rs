extern crate clap;
extern crate wtfismygs_lib;

fn main() {
    let default_port = "4000";
    let matches = clap::App::new("wtfismygs")
        .arg(
            clap::Arg::with_name("port")
                .short("p")
                .long("port")
                .env("PORT")
                .value_name("PORT")
                .help(format!("set port, default={}", &default_port).as_str())
                .takes_value(true),
        )
        .get_matches();

    let host = "127.0.0.1";
    let port = matches
        .value_of("port")
        .unwrap_or(&default_port)
        .parse::<u16>()
        .unwrap();

    println!(
        "{}  {} > Starting server http://{}:{}",
        "INFO", "wtfismygs", &host, &port
    );

    wtfismygs_lib::server(&host, port);
}
