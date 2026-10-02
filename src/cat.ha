use fmt;
use os;
use fs;
use io;
use bufio;
use encoding::utf8;

export fn cat(file: str) void = {
	const f = match (os::open_buffered(file)) {
	case let f: bufio::stream =>
		yield f;
	case let e: fs::error =>
		fmt::printfln("cat: {}: {}", file, fs::strerror(e))!;
		return;
	case nomem =>
		fmt::printfln("cat: {}: out of memory", file)!;
		return;
	};
	defer io::close(f.source)!;

	let scan = bufio::newscanner(f.source);
	defer bufio::finish(&scan);

	for (true) {
		match (bufio::scan_line(&scan)) {
		case let line: str =>
			fmt::println(line)!;
		case io::EOF =>
			break;
		case let e: io::error =>
			fmt::printfln("cat: {}: {}", file, io::strerror(e))!;
			return;
		case utf8::invalid =>
			fmt::printfln("cat: {}: invalid UTF-8", file)!;
			return;
		};
	};
};