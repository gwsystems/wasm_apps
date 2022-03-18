include ../common.mk

.PHONY: all
all: \
	trap_divzero.out \
	trap_divzero.wasm \
	trap_divzero.cwasm \
	trap_divzero.aot

.PHONY: clean
clean:
	@rm -f trap_divzero.out
	@rm -f trap_divzero.wasm
	@rm -f trap_divzero.cwasm
	@rm -f trap_divzero.aot
	@rm -f bench.csv

trap_divzero.wasm: trap_divzero.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

trap_divzero.out: trap_divzero.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
	
.PHONY: run_wasmtime_jit
run_wasmtime_jit: trap_divzero.wasm
	@echo "0" | wasmtime trap_divzero.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: trap_divzero.cwasm
	@echo "0" | wasmtime run --allow-precompiled trap_divzero.cwasm

.PHONY: run_wasm3
run_wasm3: trap_divzero.wasm
	echo "0" | wasm3 trap_divzero.wasm

.PHONY: run_wamr_int
run_wamr_int: trap_divzero.wasm
	echo "0" | iwasm trap_divzero.wasm

.PHONY: run_wamr_aot
run_wamr_aot: trap_divzero.aot
	echo "0" | iwasm trap_divzero.aot

.PHONY: run_native
run_native: trap_divzero.out
	@echo "0" | ./trap_divzero.out

bench.csv: trap_divzero.wasm trap_divzero.cwasm trap_divzero.out trap_divzero.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n trap_divzero_native       'echo "0" | ./trap_divzero.out' \
	-n trap_divzero_wasmtime_jit 'echo "0" | wasmtime run trap_divzero.wasm' \
	-n trap_divzero_wasmtime_aot 'echo "0" | wasmtime run --allow-precompiled trap_divzero.cwasm' \
	-n trap_divzero_wamr_int     'echo "0" | iwasm trap_divzero.wasm' \
	-n trap_divzero_wamr_aot     'echo "0" | iwasm trap_divzero.aot' \
	-n trap_divzero_wasm3        'echo "0" | wasm3 trap_divzero.wasm'
