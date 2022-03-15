CC=clang
CFLAGS=-O3 -I. -Wall -Wno-implicit-int -Wno-format
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
	bin/mi_blowfish.out \
	bin/mi_blowfish.wasm \
	bin/mi_blowfish.cwasm

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_blowfish.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

%.cwasm: %.wasm
	wasmtime compile $< -o $@

.PHONY: run_jit
run_jit: bin/mi_blowfish.wasm
	wasmtime --dir=. bin/mi_blowfish.wasm -- e input_large.asc /dev/null 1234567890abcdeffedcba0987654321

.PHONY: run_aot
run_aot: bin/mi_blowfish.cwasm
	wasmtime run --allow-precompiled --dir=. bin/mi_blowfish.cwasm bin/mi_blowfish.wasm -- e input_large.asc /dev/null 1234567890abcdeffedcba0987654321

bin/mi_blowfish.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_native
run_native: bin/mi_blowfish.out
	./bin/mi_blowfish.out e input_large.asc /dev/null 1234567890abcdeffedcba0987654321

bench.csv: bin/mi_blowfish.wasm bin/mi_blowfish.cwasm bin/mi_blowfish.out
	hyperfine -N -w 10 \
	-n mi_blowfish_native './bin/mi_blowfish.out e input_large.asc /dev/null 1234567890abcdeffedcba0987654321' \
	-n mi_blowfish_wasmtime_jit 'wasmtime run bin/mi_blowfish.wasm -- e input_large.asc /dev/null 1234567890abcdeffedcba0987654321' \
	-n mi_blowfish_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_blowfish.cwasm -- e input_large.asc /dev/null 1234567890abcdeffedcba0987654321' \
	--export-csv bench.csv
