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
.PHONY: run_wasmtime_jit
run_wasmtime_jit: fibonacci.wasm
	@echo "40" | wasmtime fibonacci.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: fibonacci.cwasm
	@echo "40" | wasmtime run --allow-precompiled fibonacci.cwasm

.PHONY: run_wasm3
run_wasm3: fibonacci.wasm
	@echo "40" | wasm3 fibonacci.wasm

.PHONY: run_native
run_native: fibonacci.out
	@./fibonacci.out

bench.csv: fibonacci.wasm fibonacci.cwasm fibonacci.out
	hyperfine -w 10 \
	-n fibonacci_native 'echo "40" | ./fibonacci.out' \
	-n fibonacci_wasmtime_jit 'echo "40" | wasmtime run fibonacci.wasm' \
	-n fibonacci_wasmtime_aot 'echo "40" | wasmtime run --allow-precompiled fibonacci.cwasm' \
	-n fibonacci_wasm3 'echo "40" | wasm3 fibonacci.wasm' \
	--export-csv bench.csv
