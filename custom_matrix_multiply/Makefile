WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
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

WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -I.
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/custom_libjpeg.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_matrix_multiply.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/custom_matrix_multiply.wasm
	wasmtime bin/custom_matrix_multiply.wasm
