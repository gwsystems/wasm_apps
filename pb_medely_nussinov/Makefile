include ../common.mk

.PHONY: all
all: \
	bin/pb_medely_nussinov.out \
	bin/pb_medely_nussinov.wasm \
	bin/pb_medely_nussinov.cwasm \
	bin/pb_medely_nussinov.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_medely_nussinov.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_medely_nussinov.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_medely_nussinov.wasm
	wasmtime bin/pb_medely_nussinov.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_medely_nussinov.cwasm
	wasmtime run --allow-precompiled bin/pb_medely_nussinov.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_medely_nussinov.wasm
	wasm3 bin/pb_medely_nussinov.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_medely_nussinov.wasm
	iwasm bin/pb_medely_nussinov.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_medely_nussinov.aot
	iwasm bin/pb_medely_nussinov.aot

.PHONY: run_native
run_native: bin/pb_medely_nussinov.out
	./bin/pb_medely_nussinov.out

bench.csv: bin/pb_medely_nussinov.wasm bin/pb_medely_nussinov.cwasm bin/pb_medely_nussinov.out bin/pb_medely_nussinov.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_medely_nussinov_native       './bin/pb_medely_nussinov.out' \
		-n pb_medely_nussinov_wasmtime_jit 'wasmtime run bin/pb_medely_nussinov.wasm' \
		-n pb_medely_nussinov_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_medely_nussinov.cwasm' \
		-n pb_medely_nussinov_wasm3        'wasm3 bin/pb_medely_nussinov.wasm' \
		-n pb_medely_nussinov_wamr_int     'iwasm bin/pb_medely_nussinov.wasm' \
		-n pb_medely_nussinov_wamr_aot     'iwasm bin/pb_medely_nussinov.aot'
