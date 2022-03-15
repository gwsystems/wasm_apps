CC=clang
CFLAGS=-O3 -I. -Wall
LDFLAGS=-flto -lm

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
	bin/pb_la_solvers_cholesky.out \
	bin/pb_la_solvers_cholesky.wasm \
	bin/pb_la_solvers_cholesky.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_cholesky.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_cholesky.wasm
	wasmtime bin/pb_la_solvers_cholesky.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_cholesky.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_cholesky.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_cholesky.wasm
	wasm3 bin/pb_la_solvers_cholesky.wasm

bin/pb_la_solvers_cholesky.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/pb_la_solvers_cholesky.out
	./bin/pb_la_solvers_cholesky.out

bench.csv: bin/pb_la_solvers_cholesky.wasm bin/pb_la_solvers_cholesky.cwasm bin/pb_la_solvers_cholesky.out
	hyperfine -N -w 10 \
	-n pb_la_solvers_cholesky_native './bin/pb_la_solvers_cholesky.out' \
	-n pb_la_solvers_cholesky_wasmtime_jit 'wasmtime run bin/pb_la_solvers_cholesky.wasm' \
	-n pb_la_solvers_cholesky_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_cholesky.cwasm' \
	-n pb_la_solvers_cholesky_wasm3 'wasm3 bin/pb_la_solvers_cholesky.wasm' \
	--export-csv bench.csv
