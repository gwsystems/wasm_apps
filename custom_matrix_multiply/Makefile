include ../common.mk

.PHONY: all
all: \
	bin/custom_matrix_multiply.out \
	bin/custom_matrix_multiply.wasm \
	bin/custom_matrix_multiply.cwasm \
	bin/custom_matrix_multiply.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_matrix_multiply.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_matrix_multiply.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_matrix_multiply.wasm
	wasmtime bin/custom_matrix_multiply.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_matrix_multiply.cwasm
	wasmtime run --allow-precompiled bin/custom_matrix_multiply.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_matrix_multiply.wasm
	wasm3 bin/custom_matrix_multiply.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/custom_matrix_multiply.wasm
	iwasm bin/custom_matrix_multiply.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/custom_matrix_multiply.aot
	iwasm bin/custom_matrix_multiply.aot

.PHONY: run_native
run_native: bin/custom_matrix_multiply.out
	./bin/custom_matrix_multiply.out

bench.csv: bin/custom_matrix_multiply.wasm bin/custom_matrix_multiply.cwasm bin/custom_matrix_multiply.out bin/custom_matrix_multiply.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n custom_matrix_multiply_native       './bin/custom_matrix_multiply.out' \
		-n custom_matrix_multiply_wasmtime_jit 'wasmtime run bin/custom_matrix_multiply.wasm' \
		-n custom_matrix_multiply_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_matrix_multiply.cwasm' \
		-n custom_matrix_multiply_wamr_int     'iwasm bin/custom_matrix_multiply.wasm' \
		-n custom_matrix_multiply_wamr_aot     'iwasm bin/custom_matrix_multiply.aot' \
		-n custom_matrix_multiply_wasm3        'wasm3 bin/custom_matrix_multiply.wasm'
