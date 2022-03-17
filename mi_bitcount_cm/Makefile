include ../common.mk

.PHONY: all
all: \
	bin/mi_bitcount_cm.wasm \
	bin/mi_bitcount_cm.wasm \
	bin/mi_bitcount_cm.cwasm \
	bin/mi_bitcount_cm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_bitcount_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${LDFLAGS} $^ -o $@

bin/mi_bitcount_cm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_bitcount_cm.wasm
	wasmtime bin/mi_bitcount_cm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_bitcount_cm.cwasm
	wasmtime run --allow-precompiled bin/mi_bitcount_cm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/mi_bitcount_cm.wasm
	wasm3 bin/mi_bitcount_cm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_bitcount_cm.wasm
	iwasm bin/mi_bitcount_cm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_bitcount_cm.aot
	iwasm bin/mi_bitcount_cm.aot

.PHONY: run_native
run_native: bin/mi_bitcount_cm.out
	./bin/mi_bitcount_cm.out

bench.csv: bin/mi_bitcount_cm.wasm bin/mi_bitcount_cm.cwasm bin/mi_bitcount_cm.out bin/mi_bitcount_cm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_bitcount_cm_native       './bin/mi_bitcount_cm.out' \
	-n mi_bitcount_cm_wasmtime_jit 'wasmtime run bin/mi_bitcount_cm.wasm' \
	-n mi_bitcount_cm_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_bitcount_cm.cwasm' \
	-n mi_bitcount_cm_wasm3        'wasm3 bin/mi_bitcount_cm.wasm' \
	-n mi_bitcount_cm_wamr_int     'iwasm bin/mi_bitcount_cm.wasm' \
	-n mi_bitcount_cm_wamr_aot     'iwasm bin/mi_bitcount_cm.aot'
