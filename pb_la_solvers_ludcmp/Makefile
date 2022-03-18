include ../common.mk

.PHONY: all
all: \
	bin/pb_la_solvers_ludcmp.out \
	bin/pb_la_solvers_ludcmp.wasm \
	bin/pb_la_solvers_ludcmp.cwasm \
	bin/pb_la_solvers_ludcmp.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_ludcmp.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_ludcmp.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_ludcmp.wasm
	wasmtime bin/pb_la_solvers_ludcmp.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_ludcmp.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_ludcmp.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_ludcmp.wasm
	wasm3 bin/pb_la_solvers_ludcmp.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_ludcmp.wasm
	iwasm bin/pb_la_solvers_ludcmp.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_ludcmp.aot
	iwasm bin/pb_la_solvers_ludcmp.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_ludcmp.out
	./bin/pb_la_solvers_ludcmp.out

bench.csv: bin/pb_la_solvers_ludcmp.wasm bin/pb_la_solvers_ludcmp.cwasm bin/pb_la_solvers_ludcmp.out bin/pb_la_solvers_ludcmp.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_la_solvers_ludcmp_native       './bin/pb_la_solvers_ludcmp.out' \
	-n pb_la_solvers_ludcmp_wasmtime_jit 'wasmtime run bin/pb_la_solvers_ludcmp.wasm' \
	-n pb_la_solvers_ludcmp_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_ludcmp.cwasm' \
	-n pb_la_solvers_ludcmp_wasm3        'wasm3 bin/pb_la_solvers_ludcmp.wasm' \
	-n pb_la_solvers_ludcmp_wamr_int     'iwasm bin/pb_la_solvers_ludcmp.wasm' \
	-n pb_la_solvers_ludcmp_wamr_aot     'iwasm bin/pb_la_solvers_ludcmp.aot'
