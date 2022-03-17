include ../common.mk

ARGS= large.udp

.PHONY: all
all: \
	bin/mi_patricia.out \
	bin/mi_patricia.wasm \
	bin/mi_patricia.cwasm \
	bin/mi_patricia.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_patricia.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_patricia.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_patricia.wasm
	wasmtime --dir=. bin/mi_patricia.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_patricia.cwasm
	wasmtime --dir=. run --allow-precompiled bin/mi_patricia.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_patricia.wasm
	wasm3 bin/mi_patricia.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_patricia.wasm
	iwasm --dir=. bin/mi_patricia.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_patricia.aot
	iwasm --dir=. bin/mi_patricia.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_patricia.out
	./bin/mi_patricia.out ${ARGS}

bench.csv: bin/mi_patricia.wasm bin/mi_patricia.cwasm bin/mi_patricia.out bin/mi_patricia.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_patricia_native       './bin/mi_patricia.out' \
	-n mi_patricia_wasmtime_jit 'wasmtime run --dir=. bin/mi_patricia.wasm ${ARGS}' \
	-n mi_patricia_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_patricia.cwasm ${ARGS}' \
	-n mi_patricia_wasm3        'wasm3 bin/mi_patricia.wasm ${ARGS}' \
	-n mi_patricia_wamr_int     'iwasm --dir=. bin/mi_patricia.wasm ${ARGS}' \
	-n mi_patricia_wamr_aot     'iwasm --dir=. bin/mi_patricia.aot ${ARGS}'
