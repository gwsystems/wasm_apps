include ../common.mk

.PHONY: all
all: \
	bin/pb_la_blas_gesummv.out \
	bin/pb_la_blas_gesummv.wasm \
	bin/pb_la_blas_gesummv.cwasm \
	bin/pb_la_blas_gesummv.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_gesummv.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_gesummv.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_gesummv.wasm
	wasmtime bin/pb_la_blas_gesummv.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_gesummv.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_gesummv.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_gesummv.wasm
	wasm3 bin/pb_la_blas_gesummv.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_gesummv.wasm
	iwasm bin/pb_la_blas_gesummv.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_gesummv.aot
	iwasm bin/pb_la_blas_gesummv.aot

.PHONY: run_native
run_native: bin/pb_la_blas_gesummv.out
	./bin/pb_la_blas_gesummv.out

bench.csv: bin/pb_la_blas_gesummv.wasm bin/pb_la_blas_gesummv.cwasm bin/pb_la_blas_gesummv.out bin/pb_la_blas_gesummv.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_gesummv_native       './bin/pb_la_blas_gesummv.out' \
		-n pb_la_blas_gesummv_wasmtime_jit 'wasmtime run bin/pb_la_blas_gesummv.wasm' \
		-n pb_la_blas_gesummv_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_gesummv.cwasm' \
		-n pb_la_blas_gesummv_wasm3        'wasm3 bin/pb_la_blas_gesummv.wasm' \
		-n pb_la_blas_gesummv_wamr_int     'iwasm bin/pb_la_blas_gesummv.wasm' \
		-n pb_la_blas_gesummv_wamr_aot     'iwasm bin/pb_la_blas_gesummv.aot'
