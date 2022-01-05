WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMLINKFLAGS=-Wl,--allow-undefined,-z,stack-size=32768,--threads=1
CC=clang
OPTFLAGS=-O3 -flto

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

echo.wasm: main.c
	@${WASMCC} ${WASMLINKFLAGS} ${OPTFLAGS} $^ -o $@

echo.out: main.c
	@${CC} ${OPTFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -f echo.wasm

# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run
run: echo.wasm
	@wasmtime echo.wasm

.PHONY: run_native
run_native: echo.out
	@./echo.out
