include ../common.mk

.PHONY: all
all: \
	bin/mi_dijkstra.out \
	bin/mi_dijkstra.wasm \
	bin/mi_dijkstra.cwasm \
	bin/mi_dijkstra.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_dijkstra.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_dijkstra.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_dijkstra.wasm
	wasmtime --dir=. bin/mi_dijkstra.wasm input.dat

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_dijkstra.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_dijkstra.cwasm input.dat

.PHONY: run_wasm3
run_wasm3: bin/mi_dijkstra.wasm
	wasm3 bin/mi_dijkstra.wasm input.dat

.PHONY: run_wamr_int
run_wamr_int: bin/mi_dijkstra.wasm
	iwasm --dir=. bin/mi_dijkstra.wasm input.dat

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_dijkstra.aot
	iwasm --dir=. bin/mi_dijkstra.aot input.dat

.PHONY: run_native
run_native: bin/mi_dijkstra.out
	./bin/mi_dijkstra.out input.dat

bench.csv: bin/mi_dijkstra.wasm bin/mi_dijkstra.cwasm bin/mi_dijkstra.out bin/mi_dijkstra.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_dijkstra_native       './bin/mi_dijkstra.out input.dat' \
	-n mi_dijkstra_wasmtime_jit 'wasmtime --dir=. bin/mi_dijkstra.wasm input.dat' \
	-n mi_dijkstra_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_dijkstra.cwasm input.dat' \
	-n mi_dijkstra_wamr_int     'iwasm --dir=. bin/mi_dijkstra.wasm input.dat' \
	-n mi_dijkstra_wamr_aot     'iwasm --dir=. bin/mi_dijkstra.aot input.dat' \
	-n mi_dijkstra_wasm3        'wasm3 bin/mi_dijkstra.wasm input.dat'
