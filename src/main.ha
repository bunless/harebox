use fmt;
use os;
use bufio;
use io;
use strings;

fn cat(file: str) void = {
	const content: io::file = os::open(file)!;
	const content: []u8  = io::drain(content)!;
	const content: str  = strings::fromutf8(content)!;
	const content: []str = strings::split(content, "\n")!;

	for (let a .. content) fmt::println(a)!;
};

export fn main() void = {
	if (len(os::args) < 2 || len(os::args) > 2) {
		fmt::println("usage: cat <file>")!;
		return;
	};
	cat(os::args[1]);
};
