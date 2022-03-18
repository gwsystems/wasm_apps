include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_la_blas_gemver.out \
	bin/pb_la_blas_gemver.wasm \
	bin/pb_la_blas_gemver.cwasm \
	bin/pb_la_blas_gemver.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_blas_gemver.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_blas_gemver.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_blas_gemver.wasm
	wasmtime bin/pb_la_blas_gemver.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_blas_gemver.cwasm
	wasmtime run --allow-precompiled bin/pb_la_blas_gemver.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_blas_gemver.wasm
	wasm3 bin/pb_la_blas_gemver.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_blas_gemver.wasm
	iwasm bin/pb_la_blas_gemver.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_blas_gemver.aot
	iwasm bin/pb_la_blas_gemver.aot

.PHONY: run_native
run_native: bin/pb_la_blas_gemver.out
	./bin/pb_la_blas_gemver.out

bench.csv: bin/pb_la_blas_gemver.wasm bin/pb_la_blas_gemver.cwasm bin/pb_la_blas_gemver.out bin/pb_la_blas_gemver.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_la_blas_gemver_native       './bin/pb_la_blas_gemver.out' \
	-n pb_la_blas_gemver_wasmtime_jit 'wasmtime run bin/pb_la_blas_gemver.wasm' \
	-n pb_la_blas_gemver_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_blas_gemver.cwasm' \
	-n pb_la_blas_gemver_wasm3        'wasm3 bin/pb_la_blas_gemver.wasm' \
	-n pb_la_blas_gemver_wamr_int     'iwasm bin/pb_la_blas_gemver.wasm' \
	-n pb_la_blas_gemver_wamr_aot     'iwasm bin/pb_la_blas_gemver.aot'
