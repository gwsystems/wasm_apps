include ../common.mk

WASMLDFLAGS+=-Wl,-z,stack-size=524288

.PHONY: all
all: \
	bin/custom_function_pointers.out \
	bin/custom_function_pointers.wasm \
	bin/custom_function_pointers.cwasm \
	bin/custom_function_pointers.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_function_pointers.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_function_pointers.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_function_pointers.wasm
	wasmtime bin/custom_function_pointers.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_function_pointers.cwasm
	wasmtime run --allow-precompiled bin/custom_function_pointers.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_function_pointers.wasm
	wasm3 bin/custom_function_pointers.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/custom_function_pointers.wasm
	iwasm bin/custom_function_pointers.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/custom_function_pointers.aot
	iwasm bin/custom_function_pointers.aot

.PHONY: run_native
run_native: bin/custom_function_pointers.out
	./bin/custom_function_pointers.out

bench.csv: bin/custom_function_pointers.wasm bin/custom_function_pointers.cwasm bin/custom_function_pointers.out bin/custom_function_pointers.aot
	hyperfine -N -w 1 -r 2 --export-csv bench.csv \
		-n custom_function_pointers_native       './bin/custom_function_pointers.out' \
		-n custom_function_pointers_wasmtime_jit 'wasmtime run bin/custom_function_pointers.wasm' \
		-n custom_function_pointers_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_function_pointers.cwasm' \
		-n custom_function_pointers_wamr_int     'iwasm bin/custom_function_pointers.wasm' \
		-n custom_function_pointers_wamr_aot     'iwasm bin/custom_function_pointers.aot' \
		-n custom_function_pointers_wasm3        'wasm3 bin/custom_function_pointers.wasm'
