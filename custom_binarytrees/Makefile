include ../common.mk

WASMLDFLAGS+=-Wl,-z,stack-size=524288 -Wl,--export=malloc -Wl,--export=free

LDFLAGS+=-lm 

.PHONY: all
all: \
	bin/custom_binarytrees.out \
	bin/custom_binarytrees.wasm \
	bin/custom_binarytrees.cwasm \
	bin/custom_binarytrees.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_binarytrees.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_binarytrees.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

# Takes an integer argument
.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_binarytrees.wasm
	wasmtime bin/custom_binarytrees.wasm 16

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_binarytrees.cwasm
	wasmtime run --allow-precompiled bin/custom_binarytrees.cwasm 16

.PHONY: run_wasm3
run_wasm3: bin/custom_binarytrees.wasm
	wasm3 bin/custom_binarytrees.wasm 16

.PHONY: run_wamr_int
run_wamr_int: bin/custom_binarytrees.wasm
	iwasm bin/custom_binarytrees.wasm 16

.PHONY: run_wamr_aot
run_wamr_aot: bin/custom_binarytrees.aot
	iwasm bin/custom_binarytrees.aot 16

# Takes an integer argument
.PHONY: run_native
run_native: bin/custom_binarytrees.out
	./bin/custom_binarytrees.out 16

bench.csv: bin/custom_binarytrees.wasm bin/custom_binarytrees.cwasm bin/custom_binarytrees.out bin/custom_binarytrees.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n custom_binarytrees_native       './bin/custom_binarytrees.out 16' \
		-n custom_binarytrees_wasmtime_jit 'wasmtime run bin/custom_binarytrees.wasm 16' \
		-n custom_binarytrees_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_binarytrees.cwasm 16' \
		-n custom_binarytrees_wamr_int     'iwasm bin/custom_binarytrees.wasm 16' \
		-n custom_binarytrees_wamr_aot     'iwasm bin/custom_binarytrees.aot 16' \
		-n custom_binarytrees_wasm3        'wasm3 bin/custom_binarytrees.wasm 16'
