WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I. -Wno-return-type
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/mi_dijkstra_cm.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/mi_dijkstra_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/mi_dijkstra_cm.wasm
	wasmtime bin/mi_dijkstra_cm.wasm