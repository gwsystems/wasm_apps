include ../common.mk

.PHONY: all
all: \
	bin/pb_medely_deriche.out \
	bin/pb_medely_deriche.wasm \
	bin/pb_medely_deriche.cwasm \
	bin/pb_medely_deriche.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_medely_deriche.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_medely_deriche.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_medely_deriche.wasm
	wasmtime bin/pb_medely_deriche.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_medely_deriche.cwasm
	wasmtime run --allow-precompiled bin/pb_medely_deriche.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_medely_deriche.wasm
	wasm3 bin/pb_medely_deriche.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_medely_deriche.wasm
	iwasm bin/pb_medely_deriche.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_medely_deriche.aot
	iwasm bin/pb_medely_deriche.aot

.PHONY: run_native
run_native: bin/pb_medely_deriche.out
	./bin/pb_medely_deriche.out

bench.csv: bin/pb_medely_deriche.wasm bin/pb_medely_deriche.cwasm bin/pb_medely_deriche.out bin/pb_medely_deriche.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_medely_deriche_native       './bin/pb_medely_deriche.out' \
		-n pb_medely_deriche_wasmtime_jit 'wasmtime run bin/pb_medely_deriche.wasm' \
		-n pb_medely_deriche_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_medely_deriche.cwasm' \
		-n pb_medely_deriche_wasm3        'wasm3 bin/pb_medely_deriche.wasm' \
		-n pb_medely_deriche_wamr_int     'iwasm bin/pb_medely_deriche.wasm' \
		-n pb_medely_deriche_wamr_aot     'iwasm bin/pb_medely_deriche.aot'
