include ../common.mk

ARGS= large.udp

.PHONY: all
all: \
	bin/mi_patricia_cm.out \
	bin/mi_patricia_cm.wasm \
	bin/mi_patricia_cm.cwasm \
	bin/mi_patricia_cm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_patricia_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_patricia_cm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_patricia_cm.wasm
	wasmtime --dir=. bin/mi_patricia_cm.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_patricia_cm.cwasm
	wasmtime --dir=. run --allow-precompiled bin/mi_patricia_cm.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_patricia_cm.wasm
	wasm3 bin/mi_patricia_cm.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_patricia_cm.wasm
	iwasm --dir=. bin/mi_patricia_cm.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_patricia_cm.aot
	iwasm --dir=. bin/mi_patricia_cm.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_patricia_cm.out
	./bin/mi_patricia_cm.out ${ARGS}

bench.csv: bin/mi_patricia_cm.wasm bin/mi_patricia_cm.cwasm bin/mi_patricia_cm.out bin/mi_patricia_cm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_patricia_cm_native       './bin/mi_patricia_cm.out' \
		-n mi_patricia_cm_wasmtime_jit 'wasmtime run --dir=. bin/mi_patricia_cm.wasm ${ARGS}' \
		-n mi_patricia_cm_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_patricia_cm.cwasm ${ARGS}' \
		-n mi_patricia_cm_wasm3        'wasm3 bin/mi_patricia_cm.wasm ${ARGS}' \
		-n mi_patricia_cm_wamr_int     'iwasm --dir=. bin/mi_patricia_cm.wasm ${ARGS}' \
		-n mi_patricia_cm_wamr_aot     'iwasm --dir=. bin/mi_patricia_cm.aot ${ARGS}'
