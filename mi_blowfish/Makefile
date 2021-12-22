WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I. -Wno-implicit-int -Wno-format
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/mi_blowfish.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/mi_blowfish.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/mi_blowfish.wasm
	wasmtime --dir=. bin/mi_blowfish.wasm -- e input_large.asc /dev/null 1234567890abcdeffedcba0987654321
