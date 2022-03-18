include ../common.mk

.PHONY: all
all: \
	bin/pb_la_blas_symm.out \
	bin/pb_la_blas_symm.wasm \
	bin/pb_la_blas_symm.cwasm \
	bin/pb_la_blas_symm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_symm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_symm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_symm.wasm
	wasmtime bin/pb_la_blas_symm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_symm.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_symm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_symm.wasm
	wasm3 bin/pb_la_blas_symm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_symm.wasm
	iwasm bin/pb_la_blas_symm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_symm.aot
	iwasm bin/pb_la_blas_symm.aot

.PHONY: run_native
run_native: bin/pb_la_blas_symm.out
	./bin/pb_la_blas_symm.out

bench.csv: bin/pb_la_blas_symm.wasm bin/pb_la_blas_symm.cwasm bin/pb_la_blas_symm.out bin/pb_la_blas_symm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_symm_native       './bin/pb_la_blas_symm.out' \
		-n pb_la_blas_symm_wasmtime_jit 'wasmtime run bin/pb_la_blas_symm.wasm' \
		-n pb_la_blas_symm_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_symm.cwasm' \
		-n pb_la_blas_symm_wasm3        'wasm3 bin/pb_la_blas_symm.wasm' \
		-n pb_la_blas_symm_wamr_int     'iwasm bin/pb_la_blas_symm.wasm' \
		-n pb_la_blas_symm_wamr_aot     'iwasm bin/pb_la_blas_symm.aot'
