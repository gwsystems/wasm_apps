include ../common.mk

.PHONY: all
all: \
	bin/pb_stencils_jacobi_1d.out \
	bin/pb_stencils_jacobi_1d.wasm \
	bin/pb_stencils_jacobi_1d.cwasm \
	bin/pb_stencils_jacobi_1d.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_stencils_jacobi_1d.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_stencils_jacobi_1d.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_stencils_jacobi_1d.wasm
	wasmtime bin/pb_stencils_jacobi_1d.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_stencils_jacobi_1d.cwasm
	wasmtime run --allow-precompiled bin/pb_stencils_jacobi_1d.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_stencils_jacobi_1d.wasm
	wasm3 bin/pb_stencils_jacobi_1d.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_stencils_jacobi_1d.wasm
	iwasm bin/pb_stencils_jacobi_1d.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_stencils_jacobi_1d.aot
	iwasm bin/pb_stencils_jacobi_1d.aot

.PHONY: run_native
run_native: bin/pb_stencils_jacobi_1d.out
	./bin/pb_stencils_jacobi_1d.out

bench.csv: bin/pb_stencils_jacobi_1d.wasm bin/pb_stencils_jacobi_1d.cwasm bin/pb_stencils_jacobi_1d.out bin/pb_stencils_jacobi_1d.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_stencils_jacobi_1d_native       './bin/pb_stencils_jacobi_1d.out' \
	-n pb_stencils_jacobi_1d_wasmtime_jit 'wasmtime run bin/pb_stencils_jacobi_1d.wasm' \
	-n pb_stencils_jacobi_1d_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_stencils_jacobi_1d.cwasm' \
	-n pb_stencils_jacobi_1d_wasm3        'wasm3 bin/pb_stencils_jacobi_1d.wasm' \
	-n pb_stencils_jacobi_1d_wamr_int     'iwasm bin/pb_stencils_jacobi_1d.wasm' \
	-n pb_stencils_jacobi_1d_wamr_aot     'iwasm bin/pb_stencils_jacobi_1d.aot'
