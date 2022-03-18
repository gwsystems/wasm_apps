include ../common.mk

.PHONY: all
all: \
	bin/pb_la_blas_syrk.out \
	bin/pb_la_blas_syrk.wasm \
	bin/pb_la_blas_syrk.cwasm \
	bin/pb_la_blas_syrk.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_syrk.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_syrk.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_syrk.wasm
	wasmtime bin/pb_la_blas_syrk.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_syrk.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_syrk.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_syrk.wasm
	wasm3 bin/pb_la_blas_syrk.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_syrk.wasm
	iwasm bin/pb_la_blas_syrk.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_syrk.aot
	iwasm bin/pb_la_blas_syrk.aot

.PHONY: run_native
run_native: bin/pb_la_blas_syrk.out
	./bin/pb_la_blas_syrk.out

bench.csv: bin/pb_la_blas_syrk.wasm bin/pb_la_blas_syrk.cwasm bin/pb_la_blas_syrk.out bin/pb_la_blas_syrk.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_syrk_native       './bin/pb_la_blas_syrk.out' \
		-n pb_la_blas_syrk_wasmtime_jit 'wasmtime run bin/pb_la_blas_syrk.wasm' \
		-n pb_la_blas_syrk_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_syrk.cwasm' \
		-n pb_la_blas_syrk_wasm3        'wasm3 bin/pb_la_blas_syrk.wasm' \
		-n pb_la_blas_syrk_wamr_int     'iwasm bin/pb_la_blas_syrk.wasm' \
		-n pb_la_blas_syrk_wamr_aot     'iwasm bin/pb_la_blas_syrk.aot'
