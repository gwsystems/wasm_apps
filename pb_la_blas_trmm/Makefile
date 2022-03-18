include ../common.mk

.PHONY: all
all: \
	bin/pb_la_blas_trmm.out \
	bin/pb_la_blas_trmm.wasm \
	bin/pb_la_blas_trmm.cwasm \
	bin/pb_la_blas_trmm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_trmm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_trmm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_trmm.wasm
	wasmtime bin/pb_la_blas_trmm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_trmm.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_trmm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_trmm.wasm
	wasm3 bin/pb_la_blas_trmm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_trmm.wasm
	iwasm bin/pb_la_blas_trmm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_trmm.aot
	iwasm bin/pb_la_blas_trmm.aot

.PHONY: run_native
run_native: bin/pb_la_blas_trmm.out
	./bin/pb_la_blas_trmm.out

bench.csv: bin/pb_la_blas_trmm.wasm bin/pb_la_blas_trmm.cwasm bin/pb_la_blas_trmm.out bin/pb_la_blas_trmm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_trmm_native       './bin/pb_la_blas_trmm.out' \
		-n pb_la_blas_trmm_wasmtime_jit 'wasmtime run bin/pb_la_blas_trmm.wasm' \
		-n pb_la_blas_trmm_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_trmm.cwasm' \
		-n pb_la_blas_trmm_wasm3        'wasm3 bin/pb_la_blas_trmm.wasm' \
		-n pb_la_blas_trmm_wamr_int     'iwasm bin/pb_la_blas_trmm.wasm' \
		-n pb_la_blas_trmm_wamr_aot     'iwasm bin/pb_la_blas_trmm.aot'
