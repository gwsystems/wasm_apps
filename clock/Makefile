include ../common.mk

.PHONY: all
all: \
	clock_res.out \
	clock_res.wasm \
	clock_res.cwasm \
	clock_res.aot

.PHONY: clean
clean:
	@rm -rf clock_res.out clock_res.wasm clock_res.wat clock_res.cwasm clock_res.aot

clock_res.out: clock_res.c
	clang ${CFLAGS} -o $@ $^

clock_res.wasm: clock_res.c
	${WASMCC} ${WASMCFLAGS} -o $@ $^

# Takes an integer argument
.PHONY: run_wasmtime_jit
run_wasmtime_jit: clock_res.wasm 
	wasmtime clock_res.wasm 

.PHONY: run_wasmtime_aot
run_wasmtime_aot: clock_res.cwasm
	wasmtime run --allow-precompiled clock_res.cwasm

.PHONY: run_wasm3
run_wasm3: clock_res.wasm
	wasm3 clock_res.wasm

.PHONY: run_wamr_int
run_wamr_int: clock_res.wasm
	iwasm clock_res.wasm

.PHONY: run_wamr_aot
run_wamr_aot: clock_res.aot
	iwasm clock_res.aot

# Takes an integer argument
.PHONY: run_native
run_native: clock_res.out
	./clock_res.out

bench.csv: clock_res.wasm clock_res.cwasm clock_res.out clock_res.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n clock_res_native       './clock_res.out' \
		-n clock_res_wasmtime_jit 'wasmtime run clock_res.wasm' \
		-n clock_res_wasmtime_aot 'wasmtime run --allow-precompiled clock_res.cwasm' \
		-n clock_res_wamr_int     'iwasm clock_res.wasm' \
		-n clock_res_wamr_aot     'iwasm clock_res.aot' \
		-n clock_res_wasm3        'wasm3 clock_res.wasm'
