bin := "result/harebox"
srcdir := "src"

default: build

build:
	mkdir -p result
	hare build -o {{bin}} {{srcdir}}

run *args: build
	./{{bin}} {{args}}

clean:
	rm -rf result
	
