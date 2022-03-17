include ../common.mk

.PHONY: all
all: \
	bin/app_nn.out \
	bin/app_nn.wasm \
	bin/app_nn.cwasm \
	app_nn.aot

bin/app_nn.wasm: *.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/app_nn.out: *.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -rf bin/*
	@rm -f bench.csv

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/app_nn.wasm
	wasmtime bin/app_nn.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/app_nn.cwasm
	wasmtime run --allow-precompiled bin/app_nn.cwasm

.PHONY: run_wasm3
run_wasm3: bin/app_nn.wasm
	wasm3 bin/app_nn.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/app_nn.wasm
	iwasm bin/app_nn.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/app_nn.aot
	iwasm bin/app_nn.aot

.PHONY: run_native
run_native: bin/app_nn.out
	./bin/app_nn.out

bench.csv: bin/app_nn.wasm bin/app_nn.cwasm bin/app_nn.out bin/app_nn.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n app_nn_native       './bin/app_nn.out' \
		-n app_nn_wasmtime_jit 'wasmtime run bin/app_nn.wasm' \
		-n app_nn_wasmtime_aot 'wasmtime run --allow-precompiled bin/app_nn.cwasm' \
		-n app_nn_wamr_int     'iwasm bin/app_nn.wasm' \
		-n app_nn_wamr_aot     'iwasm bin/app_nn.aot' \
		-n app_nn_wasm3        'wasm3 bin/app_nn.wasm'
	