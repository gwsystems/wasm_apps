CC=clang
CFLAGS=-O3 -I. -Wall
LDFLAGS=-flto

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMCFLAGS=${CFLAGS}

# See https://lld.llvm.org/WebAssembly.html
WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288,--allow-undefined,--threads=1

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
	bin/app_nn.out \
	bin/app_nn.wasm \
	bin/app_nn.cwasm

bin/app_nn.wasm: *.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_jit
run_jit: bin/app_nn.wasm
	wasmtime bin/app_nn.wasm

.PHONY: run_aot
run_aot: bin/app_nn.cwasm
	wasmtime run --allow-precompiled bin/app_nn.cwasm

bin/app_nn.out: *.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/app_nn.out
	./bin/app_nn.out

.PHONY: clean
clean:
	@rm -rf bin/*
	@rm -f bench.csv

bench.csv: bin/app_nn.wasm bin/app_nn.cwasm bin/app_nn.out
	hyperfine -N -w 10 -n app_nn_native './bin/app_nn.out' -n app_nn_wasmtime_jit 'wasmtime run bin/app_nn.wasm' -n app_nn_wasmtime_aot 'wasmtime run --allow-precompiled bin/app_nn.cwasm' --export-csv bench.csv
