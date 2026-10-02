use fmt;
use time::date;

export fn date() void = {
	const now = date::now();
	const s = date::asformat("%a %e %b %H:%M:%S %Z %Y", &now)!;
	defer free(s);
	fmt::println(s)!;
};
