include ../common.mk

.PHONY: all
all: \
	bin/pb_la_blas_syr2k.out \
	bin/pb_la_blas_syr2k.wasm \
	bin/pb_la_blas_syr2k.cwasm \
	bin/pb_la_blas_syr2k.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_syr2k.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_syr2k.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_syr2k.wasm
	wasmtime bin/pb_la_blas_syr2k.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_syr2k.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_syr2k.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_syr2k.wasm
	wasm3 bin/pb_la_blas_syr2k.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_syr2k.wasm
	iwasm bin/pb_la_blas_syr2k.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_syr2k.aot
	iwasm bin/pb_la_blas_syr2k.aot

.PHONY: run_native
run_native: bin/pb_la_blas_syr2k.out
	./bin/pb_la_blas_syr2k.out

bench.csv: bin/pb_la_blas_syr2k.wasm bin/pb_la_blas_syr2k.cwasm bin/pb_la_blas_syr2k.out bin/pb_la_blas_syr2k.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_syr2k_native       './bin/pb_la_blas_syr2k.out' \
		-n pb_la_blas_syr2k_wasmtime_jit 'wasmtime run bin/pb_la_blas_syr2k.wasm' \
		-n pb_la_blas_syr2k_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_syr2k.cwasm' \
		-n pb_la_blas_syr2k_wasm3        'wasm3 bin/pb_la_blas_syr2k.wasm' \
		-n pb_la_blas_syr2k_wamr_int     'iwasm bin/pb_la_blas_syr2k.wasm' \
		-n pb_la_blas_syr2k_wamr_aot     'iwasm bin/pb_la_blas_syr2k.aot'
