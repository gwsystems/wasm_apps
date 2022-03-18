include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_la_solvers_cholesky.out \
	bin/pb_la_solvers_cholesky.wasm \
	bin/pb_la_solvers_cholesky.cwasm \
	bin/pb_la_solvers_cholesky.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_cholesky.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_cholesky.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_cholesky.wasm
	wasmtime bin/pb_la_solvers_cholesky.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_cholesky.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_cholesky.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_cholesky.wasm
	wasm3 bin/pb_la_solvers_cholesky.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_cholesky.wasm
	iwasm bin/pb_la_solvers_cholesky.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_cholesky.aot
	iwasm bin/pb_la_solvers_cholesky.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_cholesky.out
	./bin/pb_la_solvers_cholesky.out

bench.csv: bin/pb_la_solvers_cholesky.wasm bin/pb_la_solvers_cholesky.cwasm bin/pb_la_solvers_cholesky.out bin/pb_la_solvers_cholesky.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_solvers_cholesky_native       './bin/pb_la_solvers_cholesky.out' \
		-n pb_la_solvers_cholesky_wasmtime_jit 'wasmtime run bin/pb_la_solvers_cholesky.wasm' \
		-n pb_la_solvers_cholesky_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_cholesky.cwasm' \
		-n pb_la_solvers_cholesky_wasm3        'wasm3 bin/pb_la_solvers_cholesky.wasm' \
		-n pb_la_solvers_cholesky_wamr_int     'iwasm bin/pb_la_solvers_cholesky.wasm' \
		-n pb_la_solvers_cholesky_wamr_aot     'iwasm bin/pb_la_solvers_cholesky.aot'
