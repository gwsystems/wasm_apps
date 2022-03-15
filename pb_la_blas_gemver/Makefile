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
	bin/pb_la_blas_gemver.out \
	bin/pb_la_blas_gemver.wasm \
	bin/pb_la_blas_gemver.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_gemver.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

bin/pb_la_blas_gemver.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_jit
run_jit: bin/pb_la_blas_gemver.wasm
	wasmtime $<

.PHONY: run_aot
run_aot: bin/pb_la_blas_gemver.cwasm
	wasmtime run --allow-precompiled $<

.PHONY: run_native
run_native: bin/pb_la_blas_gemver.out
	./bin/pb_la_blas_gemver.out

bench.csv: bin/pb_la_blas_gemver.wasm bin/pb_la_blas_gemver.cwasm bin/pb_la_blas_gemver.out
	hyperfine -N -w 10 \
	-n pb_la_blas_gemver_native './bin/pb_la_blas_gemver.out' \
	-n pb_la_blas_gemver_wasmtime_jit 'wasmtime run bin/pb_la_blas_gemver.wasm' \
	-n pb_la_blas_gemver_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_gemver.cwasm' \
	--export-csv bench.csv
