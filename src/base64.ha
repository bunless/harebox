use fmt;
use os;
use fs;
use io;
use encoding::base64;

def BUFSZ = 57 * 1024z;

export fn base64(file: str) void = {
	const f = match (os::open(file)) {
	case let f: io::file =>
		yield f;
	case let e: fs::error =>
		fmt::printfln("base64: {}: {}", file, fs::strerror(e))!;
		return;
	case nomem =>
		fmt::printfln("base64: {}: out of memory", file)!;
		return;
	};
	defer io::close(f)!;

	let buf: *[BUFSZ]u8 = alloc([0...])!;
	defer free(buf);

	for (true) {
		let n = match (io::read(f, buf)) {
		case let n: size =>
			yield n;
		case io::EOF =>
			break;
		case let e: io::error =>
			fmt::printfln("base64: {}: {}", file, io::strerror(e))!;
			return;
		};

		match (base64::encode(os::stdout, &base64::std_encoding, buf[..n])) {
		case let n: size =>
			yield n;
		case let e: io::error =>
			fmt::printfln("base64: {}: {}", file, io::strerror(e))!;
			return;
		};
	};

	fmt::println("")!;
};
