WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I. -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE -Wno-everything -D_WASI_EMULATED_SIGNAL-D_WASI_EMULATED_SIGNAL
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -lwasi-emulated-signal
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/mi_qsort.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/mi_qsort.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/mi_qsort.wasm
	wasmtime --dir=. bin/mi_qsort.wasm input_small.dat
