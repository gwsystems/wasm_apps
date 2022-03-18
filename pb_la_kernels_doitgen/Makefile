include ../common.mk

.PHONY: all
all: \
	bin/pb_la_kernels_doitgen.out \
	bin/pb_la_kernels_doitgen.wasm \
	bin/pb_la_kernels_doitgen.cwasm \
	bin/pb_la_kernels_doitgen.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_kernels_doitgen.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_kernels_doitgen.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_kernels_doitgen.wasm
	wasmtime bin/pb_la_kernels_doitgen.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_kernels_doitgen.cwasm
	wasmtime run --allow-precompiled bin/pb_la_kernels_doitgen.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_kernels_doitgen.wasm
	wasm3 bin/pb_la_kernels_doitgen.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_kernels_doitgen.wasm
	iwasm bin/pb_la_kernels_doitgen.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_kernels_doitgen.aot
	iwasm bin/pb_la_kernels_doitgen.aot

.PHONY: run_native
run_native: bin/pb_la_kernels_doitgen.out
	./bin/pb_la_kernels_doitgen.out

bench.csv: bin/pb_la_kernels_doitgen.wasm bin/pb_la_kernels_doitgen.cwasm bin/pb_la_kernels_doitgen.out bin/pb_la_kernels_doitgen.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_kernels_doitgen_native       './bin/pb_la_kernels_doitgen.out' \
		-n pb_la_kernels_doitgen_wasmtime_jit 'wasmtime run bin/pb_la_kernels_doitgen.wasm' \
		-n pb_la_kernels_doitgen_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_kernels_doitgen.cwasm' \
		-n pb_la_kernels_doitgen_wasm3        'wasm3 bin/pb_la_kernels_doitgen.wasm' \
		-n pb_la_kernels_doitgen_wamr_int     'iwasm bin/pb_la_kernels_doitgen.wasm' \
		-n pb_la_kernels_doitgen_wamr_aot     'iwasm bin/pb_la_kernels_doitgen.aot'
