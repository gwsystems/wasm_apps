include ../common.mk

.PHONY: all
all: \
	empty.out \
	empty.wasm \
	empty.cwasm \
	empty.aot

.PHONY: clean
clean:
	@rm -f empty.out
	@rm -f empty.wasm 
	@rm -f empty.cwasm 
	@rm -f empty.aot 
	@rm -f bench.csv

empty.out: main.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

empty.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

# Should return 0 exit status
.PHONY: run_wasmtime_jit
run_wasmtime_jit: empty.wasm
	@wasmtime empty.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: empty.cwasm
	wasmtime run --allow-precompiled empty.cwasm

.PHONY: run_wasm3
run_wasm3: empty.wasm
	wasm3 empty.wasm

.PHONY: run_wamr_int
run_wamr_int: empty.wasm
	iwasm empty.wasm

.PHONY: run_wamr_aot
run_wamr_aot: empty.aot
	iwasm empty.aot

.PHONY: run_native
run_native: empty.out
	./empty.out

bench.csv: empty.wasm empty.cwasm empty.out empty.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n empty_native       './empty.out' \
	-n empty_wasmtime_jit 'wasmtime run empty.wasm' \
	-n empty_wasmtime_aot 'wasmtime run --allow-precompiled empty.cwasm' \
	-n empty_wamr_int     'iwasm empty.wasm' \
	-n empty_wamr_aot     'iwasm empty.aot' \
	-n empty_wasm3        'wasm3 empty.wasm'
