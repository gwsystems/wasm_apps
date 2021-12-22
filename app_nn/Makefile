include csrc.mk

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC = clang
INCLUDE=-I.
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

cifar10.out: ${C_SRC}
	@${CC} ${OPTFLAGS} ${INCLUDE} ${DEFINES} $^ -o $@

cifar10.wasm: ${C_SRC}
	@${WASMCC} ${WASMCFLAGS} ${OPTFLAGS} ${INCLUDE} ${DEFINES} $^ -o $@

.PHONY: clean
clean:
	@rm -f cifar10.out cifar10.wasm

.PHONY: all
all: cifar10.out cifar10.wasm

run: cifar10.wasm
	wasmtime cifar10.wasm < images/bmp/airplane1.bmp
	wasmtime cifar10.wasm < images/bmp/automobile1.bmp
	wasmtime cifar10.wasm < images/bmp/bird1.bmp
	wasmtime cifar10.wasm < images/bmp/cat1.bmp
	wasmtime cifar10.wasm < images/bmp/horse1.bmp
	wasmtime cifar10.wasm < images/bmp/ship1.bmp
	wasmtime cifar10.wasm < images/bmp/truck1.bmp

run_native: cifar10.out
	./cifar10.out < images/bmp/airplane1.bmp
	./cifar10.out < images/bmp/automobile1.bmp
	./cifar10.out < images/bmp/bird1.bmp
	./cifar10.out < images/bmp/cat1.bmp
	./cifar10.out < images/bmp/horse1.bmp
	./cifar10.out < images/bmp/ship1.bmp
	./cifar10.out < images/bmp/truck1.bmp
