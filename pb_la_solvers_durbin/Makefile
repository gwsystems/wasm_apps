include ../common.mk

.PHONY: all
all: \
	bin/pb_la_solvers_durbin.out \
	bin/pb_la_solvers_durbin.wasm \
	bin/pb_la_solvers_durbin.cwasm \
	bin/pb_la_solvers_durbin.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_durbin.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_durbin.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_durbin.wasm
	wasmtime bin/pb_la_solvers_durbin.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_durbin.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_durbin.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_durbin.wasm
	wasm3 bin/pb_la_solvers_durbin.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_durbin.wasm
	iwasm bin/pb_la_solvers_durbin.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_durbin.aot
	iwasm bin/pb_la_solvers_durbin.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_durbin.out
	./bin/pb_la_solvers_durbin.out

bench.csv: bin/pb_la_solvers_durbin.wasm bin/pb_la_solvers_durbin.cwasm bin/pb_la_solvers_durbin.out bin/pb_la_solvers_durbin.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_solvers_durbin_native       './bin/pb_la_solvers_durbin.out' \
		-n pb_la_solvers_durbin_wasmtime_jit 'wasmtime run bin/pb_la_solvers_durbin.wasm' \
		-n pb_la_solvers_durbin_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_durbin.cwasm' \
		-n pb_la_solvers_durbin_wasm3        'wasm3 bin/pb_la_solvers_durbin.wasm' \
		-n pb_la_solvers_durbin_wamr_int     'iwasm bin/pb_la_solvers_durbin.wasm' \
		-n pb_la_solvers_durbin_wamr_aot     'iwasm bin/pb_la_solvers_durbin.aot'
