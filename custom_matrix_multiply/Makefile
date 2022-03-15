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
	bin/custom_libjpeg.out \
	bin/custom_libjpeg.wasm \
	bin/custom_libjpeg.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_matrix_multiply.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_matrix_multiply.wasm
	wasmtime bin/custom_matrix_multiply.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_matrix_multiply.cwasm
	wasmtime run --allow-precompiled bin/custom_matrix_multiply.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_matrix_multiply.wasm
	wasm3 bin/custom_matrix_multiply.wasm

bin/custom_matrix_multiply.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/custom_matrix_multiply.out
	./bin/custom_matrix_multiply.out

bench.csv: bin/custom_matrix_multiply.wasm bin/custom_matrix_multiply.cwasm bin/custom_matrix_multiply.out
	hyperfine -N -w 10 \
	-n custom_matrix_multiply_native './bin/custom_matrix_multiply.out' \
	-n custom_matrix_multiply_wasmtime_jit 'wasmtime run bin/custom_matrix_multiply.wasm' \
	-n custom_matrix_multiply_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_matrix_multiply.cwasm' \
	-n custom_matrix_multiply_wasm3 'wasm3 bin/custom_matrix_multiply.wasm' \
	--export-csv bench.csv
