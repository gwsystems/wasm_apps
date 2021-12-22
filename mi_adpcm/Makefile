WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I.
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -Wno-implicit-int -Wno-implicit-function-declaration
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/mi_adpcm.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/mi_adpcm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/mi_adpcm.wasm
	wasmtime bin/mi_adpcm.wasm < large.pcm
