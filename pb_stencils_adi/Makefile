include ../common.mk

.PHONY: all
all: \
	bin/pb_stencils_adi.out \
	bin/pb_stencils_adi.wasm \
	bin/pb_stencils_adi.cwasm \
	bin/pb_stencils_adi.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_stencils_adi.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_stencils_adi.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_stencils_adi.wasm
	wasmtime bin/pb_stencils_adi.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_stencils_adi.cwasm
	wasmtime run --allow-precompiled bin/pb_stencils_adi.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_stencils_adi.wasm
	wasm3 bin/pb_stencils_adi.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_stencils_adi.wasm
	iwasm bin/pb_stencils_adi.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_stencils_adi.aot
	iwasm bin/pb_stencils_adi.aot

.PHONY: run_native
run_native: bin/pb_stencils_adi.out
	./bin/pb_stencils_adi.out

bench.csv: bin/pb_stencils_adi.wasm bin/pb_stencils_adi.cwasm bin/pb_stencils_adi.out bin/pb_stencils_adi.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_stencils_adi_native       './bin/pb_stencils_adi.out' \
		-n pb_stencils_adi_wasmtime_jit 'wasmtime run bin/pb_stencils_adi.wasm' \
		-n pb_stencils_adi_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_stencils_adi.cwasm' \
		-n pb_stencils_adi_wasm3        'wasm3 bin/pb_stencils_adi.wasm' \
		-n pb_stencils_adi_wamr_int     'iwasm bin/pb_stencils_adi.wasm' \
		-n pb_stencils_adi_wamr_aot     'iwasm bin/pb_stencils_adi.aot'
