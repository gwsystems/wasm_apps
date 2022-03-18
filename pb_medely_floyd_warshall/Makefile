include ../common.mk

.PHONY: all
all: \
	bin/pb_medely_floyd_warshall.out \
	bin/pb_medely_floyd_warshall.wasm \
	bin/pb_medely_floyd_warshall.cwasm \
	bin/pb_medely_floyd_warshall.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_medely_floyd_warshall.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_medely_floyd_warshall.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_medely_floyd_warshall.wasm
	wasmtime bin/pb_medely_floyd_warshall.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_medely_floyd_warshall.cwasm
	wasmtime run --allow-precompiled bin/pb_medely_floyd_warshall.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_medely_floyd_warshall.wasm
	wasm3 bin/pb_medely_floyd_warshall.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_medely_floyd_warshall.wasm
	iwasm bin/pb_medely_floyd_warshall.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_medely_floyd_warshall.aot
	iwasm bin/pb_medely_floyd_warshall.aot

.PHONY: run_native
run_native: bin/pb_medely_floyd_warshall.out
	./bin/pb_medely_floyd_warshall.out

bench.csv: bin/pb_medely_floyd_warshall.wasm bin/pb_medely_floyd_warshall.cwasm bin/pb_medely_floyd_warshall.out bin/pb_medely_floyd_warshall.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_medely_floyd_warshall_native       './bin/pb_medely_floyd_warshall.out' \
	-n pb_medely_floyd_warshall_wasmtime_jit 'wasmtime run bin/pb_medely_floyd_warshall.wasm' \
	-n pb_medely_floyd_warshall_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_medely_floyd_warshall.cwasm' \
	-n pb_medely_floyd_warshall_wasm3        'wasm3 bin/pb_medely_floyd_warshall.wasm' \
	-n pb_medely_floyd_warshall_wamr_int     'iwasm bin/pb_medely_floyd_warshall.wasm' \
	-n pb_medely_floyd_warshall_wamr_aot     'iwasm bin/pb_medely_floyd_warshall.aot'
