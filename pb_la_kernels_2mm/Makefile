include ../common.mk

.PHONY: all
all: \
	bin/pb_la_kernels_2mm.out \
	bin/pb_la_kernels_2mm.wasm \
	bin/pb_la_kernels_2mm.cwasm \
	bin/pb_la_kernels_2mm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_kernels_2mm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_kernels_2mm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_kernels_2mm.wasm
	wasmtime bin/pb_la_kernels_2mm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_kernels_2mm.cwasm
	wasmtime run --allow-precompiled bin/pb_la_kernels_2mm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_kernels_2mm.wasm
	wasm3 bin/pb_la_kernels_2mm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_kernels_2mm.wasm
	iwasm bin/pb_la_kernels_2mm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_kernels_2mm.aot
	iwasm bin/pb_la_kernels_2mm.aot

.PHONY: run_native
run_native: bin/pb_la_kernels_2mm.out
	./bin/pb_la_kernels_2mm.out

bench.csv: bin/pb_la_kernels_2mm.wasm bin/pb_la_kernels_2mm.cwasm bin/pb_la_kernels_2mm.out bin/pb_la_kernels_2mm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_la_kernels_2mm_native       './bin/pb_la_kernels_2mm.out' \
	-n pb_la_kernels_2mm_wasmtime_jit 'wasmtime run bin/pb_la_kernels_2mm.wasm' \
	-n pb_la_kernels_2mm_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_kernels_2mm.cwasm' \
	-n pb_la_kernels_2mm_wasm3        'wasm3 bin/pb_la_kernels_2mm.wasm' \
	-n pb_la_kernels_2mm_wamr_int     'iwasm bin/pb_la_kernels_2mm.wasm' \
	-n pb_la_kernels_2mm_wamr_aot     'iwasm bin/pb_la_kernels_2mm.aot'
