CC=clang
CFLAGS=-O3 -I. -Wno-return-type
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
	bin/mi_patricia.out \
	bin/mi_patricia.wasm \
	bin/mi_patricia.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_patricia.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_patricia.wasm
	wasmtime --dir=. bin/mi_patricia.wasm large.udp

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_patricia.cwasm
	wasmtime --dir=. run --allow-precompiled bin/mi_patricia.cwasm large.udp

.PHONY: run_wasm3
run_wasm3: bin/mi_patricia.wasm
	wasm3 bin/mi_patricia.wasm large.udp

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

bin/mi_patricia.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/mi_patricia.out
	./bin/mi_patricia.out large.udp

bench.csv: bin/mi_patricia.wasm bin/mi_patricia.cwasm bin/mi_patricia.out
	hyperfine -N -w 10 \
	-n mi_patricia_native './bin/mi_patricia.out' \
	-n mi_patricia_wasmtime_jit 'wasmtime run bin/mi_patricia.wasm large.udp' \
	-n mi_patricia_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_patricia.cwasm large.udp' \
	-n mi_patricia_wasm3 'wasm3 bin/mi_patricia.wasm large.udp' \
	--export-csv bench.csv
