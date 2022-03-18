include ../common.mk

.PHONY: all
all: \
	bin/pb_la_kernels_atax.out \
	bin/pb_la_kernels_atax.wasm \
	bin/pb_la_kernels_atax.cwasm \
	bin/pb_la_kernels_atax.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_kernels_atax.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_kernels_atax.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_kernels_atax.wasm
	wasmtime bin/pb_la_kernels_atax.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_kernels_atax.cwasm
	wasmtime run --allow-precompiled bin/pb_la_kernels_atax.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_kernels_atax.wasm
	wasm3 bin/pb_la_kernels_atax.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_kernels_atax.wasm
	iwasm bin/pb_la_kernels_atax.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_kernels_atax.aot
	iwasm bin/pb_la_kernels_atax.aot

.PHONY: run_native
run_native: bin/pb_la_kernels_atax.out
	./bin/pb_la_kernels_atax.out

bench.csv: bin/pb_la_kernels_atax.wasm bin/pb_la_kernels_atax.cwasm bin/pb_la_kernels_atax.out bin/pb_la_kernels_atax.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_kernels_atax_native       './bin/pb_la_kernels_atax.out' \
		-n pb_la_kernels_atax_wasmtime_jit 'wasmtime run bin/pb_la_kernels_atax.wasm' \
		-n pb_la_kernels_atax_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_kernels_atax.cwasm' \
		-n pb_la_kernels_atax_wasm3        'wasm3 bin/pb_la_kernels_atax.wasm' \
		-n pb_la_kernels_atax_wamr_int     'iwasm bin/pb_la_kernels_atax.wasm' \
		-n pb_la_kernels_atax_wamr_aot     'iwasm bin/pb_la_kernels_atax.aot'
