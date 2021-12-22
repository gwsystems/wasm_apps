WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I.
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/pb_stencils_jacobi_1d.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/pb_stencils_jacobi_1d.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/pb_stencils_jacobi_1d.wasm
	wasmtime bin/pb_stencils_jacobi_1d.wasm
