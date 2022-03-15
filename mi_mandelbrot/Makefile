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
	bin/mi_mandelbrot.out \
	bin/mi_mandelbrot.wasm \
	bin/mi_mandelbrot.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_mandelbrot.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_mandelbrot.wasm
	wasmtime bin/mi_mandelbrot.wasm 5000

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_mandelbrot.cwasm
	wasmtime run --allow-precompiled bin/mi_mandelbrot.cwasm 5000

.PHONY: run_wasm3
run_wasm3: bin/mi_mandelbrot.wasm
	wasm3 bin/mi_mandelbrot.wasm 5000

bin/mi_mandelbrot.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/mi_mandelbrot.out
	./bin/mi_mandelbrot.out 5000

bench.csv: bin/mi_mandelbrot.wasm bin/mi_mandelbrot.cwasm bin/mi_mandelbrot.out
	hyperfine -N -w 10 \
	-n mi_mandelbrot_native './bin/mi_mandelbrot.out 5000' \
	-n mi_mandelbrot_wasmtime_jit 'wasmtime run bin/mi_mandelbrot.wasm 5000' \
	-n mi_mandelbrot_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_mandelbrot.cwasm 5000' \
	-n mi_mandelbrot_wasm3 'wasm3 bin/mi_mandelbrot.wasm 5000' \
	--export-csv bench.csv
