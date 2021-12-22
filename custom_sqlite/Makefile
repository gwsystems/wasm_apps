WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-I. -O3 -flto -Wall -DSQLITE_MUTEX_NOOP -D_WASI_EMULATED_MMAN
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1  -lwasi-emulated-mman
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/custom_sqlite.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_sqlite.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/custom_sqlite.wasm
	wasmtime bin/custom_sqlite.wasm
