include ../common.mk

.PHONY: all
all: \
	bin/mi_bitcount.out \
	bin/mi_bitcount.wasm \
	bin/mi_bitcount.cwasm \
	bin/mi_bitcount.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_bitcount.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_bitcount.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_bitcount.wasm
	wasmtime bin/mi_bitcount.wasm 16777216

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_bitcount.cwasm
	wasmtime run --allow-precompiled bin/mi_bitcount.cwasm 16777216

.PHONY: run_wasm3
run_wasm3: bin/mi_bitcount.wasm
	wasm3 bin/mi_bitcount.wasm 16777216

.PHONY: run_wamr_int
run_wamr_int: bin/mi_bitcount.wasm
	iwasm bin/mi_bitcount.wasm 16777216

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_bitcount.aot
	iwasm bin/mi_bitcount.aot 16777216

.PHONY: run_native
run_native: bin/mi_bitcount.out
	./bin/mi_bitcount.out 16777216

bench.csv: bin/mi_bitcount.wasm bin/mi_bitcount.cwasm bin/mi_bitcount.out bin/mi_bitcount.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_bitcount_native       './bin/mi_bitcount.out 16777216' \
		-n mi_bitcount_wasmtime_jit 'wasmtime run bin/mi_bitcount.wasm 16777216' \
		-n mi_bitcount_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_bitcount.cwasm 16777216' \
		-n mi_bitcount_wasm3        'wasm3 bin/mi_bitcount.wasm 16777216' \
		-n mi_bitcount_wamr_int     'iwasm bin/mi_bitcount.wasm 16777216' \
		-n mi_bitcount_wamr_aot     'iwasm bin/mi_bitcount.wasm 16777216'
