use std::fs;
use std::io::Read;
use std::io::Write;
use std::net::TcpListener;
use std::net::TcpStream;
use std::thread;
use std::time::Duration;

use minihttp::ThreadPool;

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    let pool = ThreadPool::new(4);

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        pool.execute(|| handle_connection(stream));
    }
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 512];
    stream.read(&mut buffer).unwrap();

    let headers = "";
    let (status, content_file) = router(buffer);
    let body = fs::read_to_string(content_file).unwrap();

    let response = format!("{}\r\n{}\r\n{}", status, headers, body);

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}

fn router(buffer: [u8; 512]) -> (&'static str, &'static str) {
    // routes
    let root_route = b"GET / HTTP/1.1";
    let sleep_route = b"GET /sleep HTTP/1.1";

    // response status
    let status_ok = "HTTP/1.1 200 OK";
    let status_not_found = "HTTP/1.1 404 NOT FOUND";

    if buffer.starts_with(root_route) {
        (status_ok, "hello.html")
    } else if buffer.starts_with(sleep_route) {
        thread::sleep(Duration::from_secs(5));
        (status_ok, "hello.html")
    } else {
        (status_not_found, "404.html")
    }
}
