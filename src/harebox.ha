use fmt;
use os;
use bufio;
use io;
use strings;
use errors;

fn run_applet(cmd: []str) (errors::invalid | void) = {
	if (len(cmd) == 0) {
		return errors::invalid;
	};

	switch(cmd[0]) {
	case "sort" =>
		if (len(cmd) < 2) {
			return errors::invalid;
		};
		sort(cmd[1]);
	case => fmt::printfln("harebox: unknown applet: {}", cmd[0])!; 
	};
};

export fn main() void = {

	match (run_applet(os::args[1..])) {
	case void =>
		yield;
	case let err: errors::invalid =>
		fmt::println("usage: harebox <applet> [args...]")!;
	};
};
