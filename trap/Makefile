include ../common.mk

.PHONY: all
all: \
	trap.out \
	trap.wasm \
	trap.cwasm \
	trap.aot

trap.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

trap.out: main.c
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

# trap.wasm.out: trap.wasm.c
# 	${CC} ${CFLAGS} ${LDFLAGS} -Wl,-e,w2c_main -I. $^ -o $@

.PHONY: clean
clean:
	@rm -f trap.wasm
	@rm -f trap.cwasm
	@rm -f trap.wasm.out
	@rm -f trap.wasm.c
	@rm -f trap.out
	@rm -f trap.aot
	@rm -f bench.csv

# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run_wasmtime_jit
run_wasmtime_jit: trap.wasm
	@echo "40" | wasmtime trap.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: trap.cwasm
	@echo "40" | wasmtime run --allow-precompiled trap.cwasm

.PHONY: run_wasm3
run_wasm3: trap.wasm
	@echo "40" | wasm3 trap.wasm

.PHONY: run_wamr_int
run_wamr_int: trap.wasm
	@echo "40" | iwasm trap.wasm

.PHONY: run_wamr_aot
run_wamr_aot: trap.aot
	@echo "40" | iwasm trap.aot

.PHONY: run_native
run_native: trap.out
	@./trap.out

bench.csv: trap.wasm trap.cwasm trap.out trap.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n trap_native       'echo "40" | ./trap.out' \
		-n trap_wasmtime_jit 'echo "40" | wasmtime run trap.wasm' \
		-n trap_wasmtime_aot 'echo "40" | wasmtime run --allow-precompiled trap.cwasm' \
		-n trap_wamr_int     'echo "40" | iwasm trap.wasm' \
		-n trap_wamr_aot     'echo "40" | iwasm trap.aot' \
		-n trap_wasm3        'echo "40" | wasm3 trap.wasm'
