use fmt;
use os;
use fs;
use io;
use strings;

export fn cat(file: str) void = {
	const f = match (os::open(file)) {
	case let f: io::file =>
		yield f;
	case let e: fs::error =>
		fmt::printfln("cat: {}: {}", file, fs::strerror(e))!;
		return;
	};
	defer io::close(f)!;
	const content: []u8 = io::drain(f)!;
	const content: str  = strings::fromutf8(content)!;
	const content: []str = strings::split(content, "\n")!;

	for (let a .. content) fmt::println(a)!;
};
