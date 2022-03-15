CC=clang
CFLAGS=-O3 -I. -Wall
LDFLAGS=-flto

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMCFLAGS=${CFLAGS}

# See https://lld.llvm.org/WebAssembly.html
WASMLDFLAGS=${LDFLAGS} -Wl,--allow-undefined,-z,stack-size=32768,--threads=1

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
WASMCFLAGS+= -mno-simd128 # https://github.com/webassembly/simd

.PHONY: all
all: \
	fibonacci.out \
	fibonacci.wasm \
	fibonacci.cwasm

fibonacci.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

fibonacci.out: main.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
.PHONY: clean
clean:
	@rm -f fibonacci.wasm
	@rm -f fibonacci.out
	@rm -f bench.csv

# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run_jit
run_jit: fibonacci.wasm
	@wasmtime fibonacci.wasm

.PHONY: run_aot
run_aot: fibonacci.cwasm
	wasmtime run --allow-precompiled fibonacci.cwasm

.PHONY: run_native
run_native: fibonacci.out
	@./fibonacci.out

bench.csv: fibonacci.wasm fibonacci.cwasm fibonacci.out
	hyperfine -N -w 10 \
	-n fibonacci_native './fibonacci.out' \
	-n fibonacci_wasmtime_jit 'wasmtime run fibonacci.wasm' \
	-n fibonacci_wasmtime_aot 'wasmtime run --allow-precompiled fibonacci.cwasm' \
	--export-csv bench.csv
