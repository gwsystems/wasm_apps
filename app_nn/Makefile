include csrc.mk

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC = clang
INCLUDE=-I.
OPTFLAGS=-O3 -flto -Wall

# A Name Section is emitted when optimization level is 0 and -g is set
# OPTFLAGS+= -O0 -g

# Clang 12 WebAssembly Options
# See https://clang.llvm.org/docs/ClangCommandLineReference.html#webassembly

# Disable WebAssembly Proposals aWsm does not support
OPTFLAGS+= -mno-atomics # https://github.com/WebAssembly/threads
OPTFLAGS+= -mno-bulk-memory # https://github.com/WebAssembly/bulk-memory-operations
OPTFLAGS+= -mno-exception-handling # https://github.com/WebAssembly/exception-handling
OPTFLAGS+= -mno-multivalue # https://github.com/WebAssembly/multi-value
# Mutable globals still exist, but disables the ability to import mutable globals
OPTFLAGS+= -mno-mutable-globals # https://github.com/WebAssembly/mutable-global
OPTFLAGS+= -mno-nontrapping-fptoint # https://github.com/WebAssembly/nontrapping-float-to-int-conversions
OPTFLAGS+= -mno-reference-types # https://github.com/WebAssembly/reference-types
OPTFLAGS+= -mno-sign-ext # https://github.com/WebAssembly/sign-extension-ops
OPTFLAGS+= -mno-tail-call # https://github.com/WebAssembly/tail-call
OPTFLAGS+= -mno-unimplemented-simd128 # https://github.com/webassembly/simd

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
