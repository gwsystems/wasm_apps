include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_la_solvers_gramschmidt.out \
	bin/pb_la_solvers_gramschmidt.wasm \
	bin/pb_la_solvers_gramschmidt.cwasm \
	bin/pb_la_solvers_gramschmidt.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_la_solvers_gramschmidt.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_la_solvers_gramschmidt.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_la_solvers_gramschmidt.wasm
	wasmtime bin/pb_la_solvers_gramschmidt.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_la_solvers_gramschmidt.cwasm
	wasmtime run --allow-precompiled bin/pb_la_solvers_gramschmidt.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_la_solvers_gramschmidt.wasm
	wasm3 bin/pb_la_solvers_gramschmidt.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_la_solvers_gramschmidt.wasm
	iwasm bin/pb_la_solvers_gramschmidt.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_la_solvers_gramschmidt.aot
	iwasm bin/pb_la_solvers_gramschmidt.aot

.PHONY: run_native
run_native: bin/pb_la_solvers_gramschmidt.out
	./bin/pb_la_solvers_gramschmidt.out

bench.csv: bin/pb_la_solvers_gramschmidt.wasm bin/pb_la_solvers_gramschmidt.cwasm bin/pb_la_solvers_gramschmidt.out bin/pb_la_solvers_gramschmidt.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_la_solvers_gramschmidt_native       './bin/pb_la_solvers_gramschmidt.out' \
		-n pb_la_solvers_gramschmidt_wasmtime_jit 'wasmtime run bin/pb_la_solvers_gramschmidt.wasm' \
		-n pb_la_solvers_gramschmidt_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_la_solvers_gramschmidt.cwasm' \
		-n pb_la_solvers_gramschmidt_wasm3        'wasm3 bin/pb_la_solvers_gramschmidt.wasm' \
		-n pb_la_solvers_gramschmidt_wamr_int     'iwasm bin/pb_la_solvers_gramschmidt.wasm' \
		-n pb_la_solvers_gramschmidt_wamr_aot     'iwasm bin/pb_la_solvers_gramschmidt.aot'
