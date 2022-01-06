CC = clang
OPTFLAGS= -O3 -flto -I.

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

bin/app_nn.wasm: *.c
	@${WASMCC} ${WASMCFLAGS}  $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

run: bin/app_nn.wasm
	wasmtime bin/app_nn.wasm

bin/app_nn.out: *.c
	@${CC} ${OPTFLAGS} $^ -o $@

run_native: bin/app_nn.out
	./bin/app_nn.out

clean:
	rm -rf bin/*
