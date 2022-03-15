CC=clang
CFLAGS=-O3 -I. -Wall -Wno-return-type
LDFLAGS=-flto


WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMCFLAGS=${CFLAGS} ${WASMLDFLAGS} ${CFLAGS}

# See https://lld.llvm.org/WebAssembly.html
WASMLDFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1

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
	bin/mi_stringsearch.out \
	bin/mi_stringsearch.wasm \
	bin/mi_stringsearch.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_stringsearch.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_jit
run_jit: bin/mi_stringsearch.wasm
	wasmtime bin/mi_stringsearch.wasm

.PHONY: run_aot
run_aot: bin/mi_stringsearch.cwasm
	wasmtime run --allow-precompiled bin/mi_stringsearch.cwasm

bin/mi_stringsearch.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/mi_stringsearch.out
	./bin/mi_stringsearch.out

bench.csv: bin/mi_stringsearch.wasm bin/mi_stringsearch.cwasm bin/mi_stringsearch.out
	hyperfine -N -w 10 \
	-n mi_stringsearch_native './bin/mi_stringsearch.out' \
	-n mi_stringsearch_wasmtime_jit 'wasmtime run bin/mi_stringsearch.wasm' \
	-n mi_stringsearch_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_stringsearch.cwasm' \
	--export-csv bench.csv
