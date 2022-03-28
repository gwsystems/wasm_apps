include ../common.mk

.PHONY: all
all: \
	exit.out \
	exit.wasm \
	exit.cwasm \
	exit.aot

.PHONY: clean
clean:
	@rm -f exit.wasm 
	@rm -f exit.out
	@rm -f exit.cwasm
	@rm -f exit.aot
	@rm -f bench.csv

exit.out: main.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

exit.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

# Should return 0 exit status
.PHONY: run_wasmtime_jit
run_wasmtime_jit: exit.wasm
	@wasmtime exit.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: exit.cwasm
	wasmtime run --allow-precompiled exit.cwasm

.PHONY: run_wasm3
run_wasm3: exit.wasm
	wasm3 exit.wasm

.PHONY: run_wamr_int
run_wamr_int: exit.wasm
	iwasm exit.wasm

.PHONY: run_wamr_aot
run_wamr_aot: exit.aot
	iwasm exit.aot

.PHONY: run_native
run_native: exit.out
	@./exit.out

bench.csv: exit.wasm exit.cwasm exit.out exit.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n exit_native       './exit.out' \
		-n exit_wasmtime_jit 'wasmtime run exit.wasm' \
		-n exit_wasmtime_aot 'wasmtime run --allow-precompiled exit.cwasm' \
		-n exit_wasm3        'wasm3 exit.wasm' \
		-n exit_wamr_int     'iwasm exit.wasm' \
		-n exit_wamr_aot     'iwasm exit.aot'
