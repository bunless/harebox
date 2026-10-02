use fmt;
use os;
use fs;
use io;

export fn rm(file: str) void = {
	match (os::stat(file)) {
	case let fst: fs::filestat =>
		if (fs::isfile(fst.mode)) {
			// fmt::println("file")!;	
			os::remove(file)!;
		};
	};
};
