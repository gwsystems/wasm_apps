include ../common.mk

.PHONY: all
all: \
	bin/custom_memcmp.out \
	bin/custom_memcmp.wasm \
	bin/custom_memcmp.cwasm \
	bin/custom_memcmp.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_memcmp.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_memcmp.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_memcmp.wasm
	wasmtime bin/custom_memcmp.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_memcmp.cwasm
	wasmtime run --allow-precompiled bin/custom_memcmp.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_memcmp.wasm
	wasm3 bin/custom_memcmp.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/custom_memcmp.wasm
	iwasm bin/custom_memcmp.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/custom_memcmp.aot
	iwasm bin/custom_memcmp.aot

.PHONY: run_native
run_native: bin/custom_memcmp.out
	./bin/custom_memcmp.out

bench.csv: bin/custom_memcmp.wasm bin/custom_memcmp.cwasm bin/custom_memcmp.out bin/custom_memcmp.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n custom_memcmp_native        './bin/custom_memcmp.out' \
	-n custom_memcmp_wasmtime_jit  'wasmtime run bin/custom_memcmp.wasm' \
	-n custom_memcmp_wasmtime_aot  'wasmtime run --allow-precompiled bin/custom_memcmp.cwasm' \
	-n custom_binarytrees_wamr_int 'iwasm bin/custom_binarytrees.wasm' \
	-n custom_binarytrees_wamr_aot 'iwasm bin/custom_binarytrees.aot' \
	-n custom_memcmp_wasm3         'wasm3 bin/custom_memcmp.wasm'
