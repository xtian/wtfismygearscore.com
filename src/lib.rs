extern crate pretty_env_logger;
extern crate thruster;

use hyper::Body;
use thruster::hyper_server::HyperServer;
use thruster::thruster_context::basic_hyper_context::{
    generate_context, BasicHyperContext as Ctx, HyperRequest,
};
use thruster::thruster_proc::{middleware_fn, async_middleware};
use thruster::{ThrusterServer, App, MiddlewareNext, MiddlewareReturnValue};

#[middleware_fn]
async fn root(mut context: Ctx, _next: MiddlewareNext<Ctx>) -> Ctx {
    let val = "Hello, World!";
    context.body = Body::from(val);
    context
}

pub fn server(host: &str, port: u16) -> () {
    pretty_env_logger::init();

    let mut app = App::<HyperRequest, Ctx>::create(generate_context);

    app.get("/", async_middleware!(Ctx, [root]));

    HyperServer::new(app).start(host, port)
}
