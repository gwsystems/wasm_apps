CC=clang
OPTFLAGS=-O3 -flto -Wall -I.

# A Name Section is emitted when optimization level is 0 and -g is set
# OPTFLAGS+= -O0 -g

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

# Clang 12 WebAssembly Options
# See https://clang.llvm.org/docs/ClangCommandLineReference.html#webassembly

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
all: bin/pb_la_blas_trmm.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/pb_la_blas_trmm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

.PHONY: run
run: bin/pb_la_blas_trmm.wasm
	wasmtime bin/pb_la_blas_trmm.wasm

bin/pb_la_blas_trmm.out: *.c
	@mkdir -p bin
	${CC} ${OPTFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/pb_la_blas_trmm.out
	./bin/pb_la_blas_trmm.out
