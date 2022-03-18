include ../common.mk

.PHONY: all
all: \
	bin/mi_stringsearch.out \
	bin/mi_stringsearch.wasm \
	bin/mi_stringsearch.cwasm \
	bin/mi_stringsearch.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_stringsearch.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_stringsearch.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_stringsearch.wasm
	wasmtime bin/mi_stringsearch.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_stringsearch.cwasm
	wasmtime run --allow-precompiled bin/mi_stringsearch.cwasm

.PHONY: run_wasm3
run_wasm3: bin/mi_stringsearch.wasm
	wasm3 bin/mi_stringsearch.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_stringsearch.wasm
	iwasm --dir=. bin/mi_stringsearch.wasm input_large.asc

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_stringsearch.aot
	iwasm --dir=. bin/mi_stringsearch.aot input_large.asc

.PHONY: run_native
run_native: bin/mi_stringsearch.out
	./bin/mi_stringsearch.out

bench.csv: bin/mi_stringsearch.wasm bin/mi_stringsearch.cwasm bin/mi_stringsearch.out
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_stringsearch_native       './bin/mi_stringsearch.out' \
		-n mi_stringsearch_wasmtime_jit 'wasmtime run bin/mi_stringsearch.wasm' \
		-n mi_stringsearch_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_stringsearch.cwasm' \
		-n mi_stringsearch_wasm3        'wasm3 bin/mi_stringsearch.wasm' \
		-n mi_stringsearch_wamr_int     'iwasm bin/mi_stringsearch.wasm' \
		-n mi_stringsearch_wamr_aot     'iwasm bin/mi_stringsearch.aot'
