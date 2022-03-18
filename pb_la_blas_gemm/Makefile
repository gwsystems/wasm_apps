include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_la_blas_gemm.out \
	bin/pb_la_blas_gemm.wasm \
	bin/pb_la_blas_gemm.cwasm \
	bin/pb_la_blas_gemm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_gemm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_gemm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_gemm.wasm
	wasmtime bin/pb_la_blas_gemm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_gemm.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_gemm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_gemm.wasm
	wasm3 bin/pb_la_blas_gemm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_gemm.wasm
	iwasm bin/pb_la_blas_gemm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_gemm.aot
	iwasm bin/pb_la_blas_gemm.aot

.PHONY: run_native
run_native: bin/pb_la_blas_gemm.out
	./bin/pb_la_blas_gemm.out

bench.csv: bin/pb_la_blas_gemm.wasm bin/pb_la_blas_gemm.cwasm bin/pb_la_blas_gemm.out bin/pb_la_blas_gemm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_blas_gemm_native       './bin/pb_la_blas_gemm.out' \
		-n pb_la_blas_gemm_wasmtime_jit 'wasmtime run bin/pb_la_blas_gemm.wasm' \
		-n pb_la_blas_gemm_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_gemm.cwasm' \
		-n pb_la_blas_gemm_wasm3        'wasm3 bin/pb_la_blas_gemm.wasm' \
		-n pb_la_blas_gemm_wamr_int     'iwasm bin/pb_la_blas_gemm.wasm' \
		-n pb_la_blas_gemm_wamr_aot     'iwasm bin/pb_la_blas_gemm.aot'
