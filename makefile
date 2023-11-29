build:
	zig build-exe ./src/main.zig --name shannon -O ReleaseSmall

test:
	zig test ./src/main.zig -O Debug
