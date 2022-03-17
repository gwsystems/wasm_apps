include ../common.mk

.PHONY: all
all: \
	echo.out \
	echo.wasm \
	echo.cwasm \
	echo.aot

.PHONY: clean
clean:
	@rm -f echo.out
	@rm -f echo.wasm
	@rm -f echo.cwasm
	@rm -f echo.aot
	@rm -f bench.csv

echo.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

echo.out: main.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
	
# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run_wasmtime_jit
run_wasmtime_jit: echo.wasm
	echo "hi" | wasmtime echo.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: echo.cwasm
	echo "hi" | wasmtime run --allow-precompiled echo.cwasm

.PHONY: run_wasm3
run_wasm3: echo.wasm
	echo "hi" | wasm3 echo.wasm

.PHONY: run_wamr_int
run_wamr_int: echo.wasm
	echo "hi" | iwasm echo.wasm

.PHONY: run_wamr_aot
run_wamr_aot: echo.aot
	echo "hi" | iwasm echo.aot

.PHONY: run_native
run_native: echo.out
	echo "hi" | ./echo.out

bench.csv: echo.wasm echo.cwasm echo.out echo.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n echo_native       'echo "hi" | ./echo.out' \
	-n echo_wasmtime_jit 'echo "hi" | wasmtime run echo.wasm' \
	-n echo_wasmtime_aot 'echo "hi" | wasmtime run --allow-precompiled echo.cwasm' \
	-n echo_wamr_int     'echo "hi" | iwasm fibonacci.wasm' \
	-n echo_wamr_aot     'echo "hi" | iwasm fibonacci.aot' \
	-n echo_wasm3        'echo "hi" | wasm3 echo.wasm'
