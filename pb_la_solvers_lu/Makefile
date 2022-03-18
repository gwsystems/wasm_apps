include ../common.mk

.PHONY: all
all: \
	bin/pb_la_solvers_lu.out \
	bin/pb_la_solvers_lu.wasm \
	bin/pb_la_solvers_lu.cwasm \
	bin/pb_la_solvers_lu.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_lu.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_lu.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_lu.wasm
	wasmtime bin/pb_la_solvers_lu.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_lu.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_lu.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_lu.wasm
	wasm3 bin/pb_la_solvers_lu.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_lu.wasm
	iwasm bin/pb_la_solvers_lu.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_lu.aot
	iwasm bin/pb_la_solvers_lu.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_lu.out
	./bin/pb_la_solvers_lu.out

bench.csv: bin/pb_la_solvers_lu.wasm bin/pb_la_solvers_lu.cwasm bin/pb_la_solvers_lu.out bin/pb_la_solvers_lu.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_solvers_lu_native       './bin/pb_la_solvers_lu.out' \
		-n pb_la_solvers_lu_wasmtime_jit 'wasmtime run bin/pb_la_solvers_lu.wasm' \
		-n pb_la_solvers_lu_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_lu.cwasm' \
		-n pb_la_solvers_lu_wasm3        'wasm3 bin/pb_la_solvers_lu.wasm' \
		-n pb_la_solvers_lu_wamr_int     'iwasm bin/pb_la_solvers_lu.wasm' \
		-n pb_la_solvers_lu_wamr_aot     'iwasm bin/pb_la_solvers_lu.aot'
