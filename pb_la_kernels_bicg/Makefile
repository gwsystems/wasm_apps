include ../common.mk

.PHONY: all
all: \
	bin/pb_la_kernels_bicg.out \
	bin/pb_la_kernels_bicg.wasm \
	bin/pb_la_kernels_bicg.cwasm \
	bin/pb_la_kernels_bicg.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_kernels_bicg.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_kernels_bicg.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_kernels_bicg.wasm
	wasmtime bin/pb_la_kernels_bicg.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_kernels_bicg.cwasm
	wasmtime run --allow-precompiled bin/pb_la_kernels_bicg.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_kernels_bicg.wasm
	wasm3 bin/pb_la_kernels_bicg.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_kernels_bicg.wasm
	iwasm bin/pb_la_kernels_bicg.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_kernels_bicg.aot
	iwasm bin/pb_la_kernels_bicg.aot

.PHONY: run_native
run_native: bin/pb_la_kernels_bicg.out
	./bin/pb_la_kernels_bicg.out

bench.csv: bin/pb_la_kernels_bicg.wasm bin/pb_la_kernels_bicg.cwasm bin/pb_la_kernels_bicg.out bin/pb_la_kernels_bicg.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_la_kernels_bicg_native       './bin/pb_la_kernels_bicg.out' \
	-n pb_la_kernels_bicg_wasmtime_jit 'wasmtime run bin/pb_la_kernels_bicg.wasm' \
	-n pb_la_kernels_bicg_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_kernels_bicg.cwasm' \
	-n pb_la_kernels_bicg_wasm3        'wasm3 bin/pb_la_kernels_bicg.wasm' \
	-n pb_la_kernels_bicg_wamr_int     'iwasm bin/pb_la_kernels_bicg.wasm' \
	-n pb_la_kernels_bicg_wamr_aot     'iwasm bin/pb_la_kernels_bicg.aot'
