include ../common.mk

.PHONY: all
all: \
	bin/pb_la_solvers_trisolv.out \
	bin/pb_la_solvers_trisolv.wasm \
	bin/pb_la_solvers_trisolv.cwasm \
	bin/pb_la_solvers_trisolv.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_trisolv.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_trisolv.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_trisolv.wasm
	wasmtime bin/pb_la_solvers_trisolv.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_trisolv.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_trisolv.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_trisolv.wasm
	wasm3 bin/pb_la_solvers_trisolv.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_trisolv.wasm
	iwasm bin/pb_la_solvers_trisolv.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_trisolv.aot
	iwasm bin/pb_la_solvers_trisolv.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_trisolv.out
	./bin/pb_la_solvers_trisolv.out

bench.csv: bin/pb_la_solvers_trisolv.wasm bin/pb_la_solvers_trisolv.cwasm bin/pb_la_solvers_trisolv.out bin/pb_la_solvers_trisolv.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_solvers_trisolv_native       './bin/pb_la_solvers_trisolv.out' \
		-n pb_la_solvers_trisolv_wasmtime_jit 'wasmtime run bin/pb_la_solvers_trisolv.wasm' \
		-n pb_la_solvers_trisolv_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_trisolv.cwasm' \
		-n pb_la_solvers_trisolv_wasm3        'wasm3 bin/pb_la_solvers_trisolv.wasm' \
		-n pb_la_solvers_trisolv_wamr_int     'iwasm bin/pb_la_solvers_trisolv.wasm' \
		-n pb_la_solvers_trisolv_wamr_aot     'iwasm bin/pb_la_solvers_trisolv.aot'
