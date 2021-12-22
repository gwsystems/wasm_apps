WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -I.
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/app_tinycrypt.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_binarytrees.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

# Takes an integer argument
run: bin/custom_binarytrees.wasm
	wasmtime bin/custom_binarytrees.wasm 16
