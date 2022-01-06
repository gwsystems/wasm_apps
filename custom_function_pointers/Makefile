WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I.

# A Name Section is emitted when optimization level is 0 and -g is set
# OPTFLAGS+= -O0 -g

# Clang 12 WebAssembly Options
# See https://clang.llvm.org/docs/ClangCommandLineReference.html#webassembly


WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

# Disable WebAssembly Proposals aWsm does not support
WASMCFLAGS+= -mno-atomics # https://github.com/WebAssembly/threads
WASMCFLAGS+= -mno-bulk-memory # https://github.com/WebAssembly/bulk-memory-operations
WASMCFLAGS+= -mno-exception-handling # https://github.com/WebAssembly/exception-handling
WASMCFLAGS+= -mno-multivalue # https://github.com/WebAssembly/multi-value
# Mutable globals still exist, but disables the ability to import mutable globals
WASMCFLAGS+= -mno-mutable-globals # https://github.com/WebAssembly/mutable-global
WASMCFLAGS+= -mno-nontrapping-fptoint # https://github.com/WebAssembly/nontrapping-float-to-int-conversions
WASMCFLAGS+= -mno-reference-types # https://github.com/WebAssembly/reference-types
WASMCFLAGS+= -mno-sign-ext # https://github.com/WebAssembly/sign-extension-ops
WASMCFLAGS+= -mno-tail-call # https://github.com/WebAssembly/tail-call
WASMCFLAGS+= -mno-unimplemented-simd128 # https://github.com/webassembly/simd

.PHONY: all
all: bin/custom_function_pointers.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_function_pointers.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

bin/custom_function_pointers.out: *.c
	@mkdir -p bin
	${CC} ${OPTFLAGS} $^ -o $@

run: bin/custom_function_pointers.wasm
	wasmtime bin/custom_function_pointers.wasm

run_native: bin/custom_function_pointers.out
	./bin/custom_function_pointers.out
