use fmt;
use os;
use fs;
use io;

export fn rmdir(file: str) void = {
	match (os::stat(file)) {
	case let fst: fs::filestat =>
		if (fs::isdir(fst.mode)) {
			// fmt::println("file")!;	
			os::rmdir(file)!;
		};
	};
};
