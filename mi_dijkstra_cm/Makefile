include ../common.mk

.PHONY: all
all: \
	bin/mi_dijkstra_cm.out \
	bin/mi_dijkstra_cm.wasm \
	bin/mi_dijkstra_cm.cwasm \
	bin/mi_dijkstra_cm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_dijkstra_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_dijkstra_cm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_dijkstra_cm.wasm
	wasmtime bin/mi_dijkstra_cm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_dijkstra_cm.cwasm
	wasmtime run --allow-precompiled bin/mi_dijkstra_cm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/mi_dijkstra_cm.wasm
	wasm3 bin/mi_dijkstra_cm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_dijkstra_cm.wasm
	iwasm bin/mi_dijkstra_cm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_dijkstra_cm.aot
	iwasm bin/mi_dijkstra_cm.aot

.PHONY: run_native
run_native: bin/mi_dijkstra_cm.out
	./bin/mi_dijkstra_cm.out

bench.csv: bin/mi_dijkstra_cm.out bin/mi_dijkstra_cm.wasm bin/mi_dijkstra_cm.cwasm bin/mi_dijkstra_cm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_dijkstra_cm_native       './bin/mi_dijkstra_cm.out' \
	-n mi_dijkstra_cm_wasmtime_jit 'wasmtime run bin/mi_dijkstra_cm.wasm' \
	-n mi_dijkstra_cm_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_dijkstra_cm.cwasm' \
	-n mi_dijkstra_cm_wasm3        'wasm3 bin/mi_dijkstra_cm.wasm' \
	-n mi_dijkstra_cm_wamr_int     'iwasm bin/mi_dijkstra_cm.wasm' \
	-n mi_dijkstra_cm_wamr_aot     'iwasm bin/mi_dijkstra_cm.aot' \
