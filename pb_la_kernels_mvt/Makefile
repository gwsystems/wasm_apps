include ../common.mk

.PHONY: all
all: \
	bin/pb_la_kernels_mvt.out \
	bin/pb_la_kernels_mvt.wasm \
	bin/pb_la_kernels_mvt.cwasm \
	bin/pb_la_kernels_mvt.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_kernels_mvt.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_kernels_mvt.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_kernels_mvt.wasm
	wasmtime bin/pb_la_kernels_mvt.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_kernels_mvt.cwasm
	wasmtime run --allow-precompiled bin/pb_la_kernels_mvt.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_kernels_mvt.wasm
	wasm3 bin/pb_la_kernels_mvt.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_kernels_mvt.wasm
	iwasm bin/pb_la_kernels_mvt.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_kernels_mvt.aot
	iwasm bin/pb_la_kernels_mvt.aot

.PHONY: run_native
run_native: bin/pb_la_kernels_mvt.out
	./bin/pb_la_kernels_mvt.out

bench.csv: bin/pb_la_kernels_mvt.wasm bin/pb_la_kernels_mvt.cwasm bin/pb_la_kernels_mvt.out bin/pb_la_kernels_mvt.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_kernels_mvt_native       './bin/pb_la_kernels_mvt.out' \
		-n pb_la_kernels_mvt_wasmtime_jit 'wasmtime run bin/pb_la_kernels_mvt.wasm' \
		-n pb_la_kernels_mvt_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_kernels_mvt.cwasm' \
		-n pb_la_kernels_mvt_wasm3        'wasm3 bin/pb_la_kernels_mvt.wasm' \
		-n pb_la_kernels_mvt_wamr_int     'iwasm bin/pb_la_kernels_mvt.wasm' \
		-n pb_la_kernels_mvt_wamr_aot     'iwasm bin/pb_la_kernels_mvt.aot'
