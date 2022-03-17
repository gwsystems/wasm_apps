include ../common.mk

.PHONY: all
all: \
	fibonacci.out \
	fibonacci.wasm \
	fibonacci.cwasm \
	fibonacci.aot

fibonacci.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

fibonacci.out: main.c
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

# fibonacci.wasm.out: fibonacci.wasm.c
# 	${CC} ${CFLAGS} ${LDFLAGS} -Wl,-e,w2c_main -I. $^ -o $@

.PHONY: clean
clean:
	@rm -f fibonacci.wasm
	@rm -f fibonacci.cwasm
	@rm -f fibonacci.wasm.out
	@rm -f fibonacci.wasm.c
	@rm -f fibonacci.out
	@rm -f fibonacci.aot
	@rm -f bench.csv

# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run_wasmtime_jit
run_wasmtime_jit: fibonacci.wasm
	@echo "40" | wasmtime fibonacci.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: fibonacci.cwasm
	@echo "40" | wasmtime run --allow-precompiled fibonacci.cwasm

.PHONY: run_wasm3
run_wasm3: fibonacci.wasm
	@echo "40" | wasm3 fibonacci.wasm

.PHONY: run_wamr_int
run_wamr_int: fibonacci.wasm
	@echo "40" | iwasm fibonacci.wasm

.PHONY: run_wamr_aot
run_wamr_aot: fibonacci.aot
	@echo "40" | iwasm fibonacci.aot

.PHONY: run_native
run_native: fibonacci.out
	@./fibonacci.out

bench.csv: fibonacci.wasm fibonacci.cwasm fibonacci.out fibonacci.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n fibonacci_native       'echo "40" | ./fibonacci.out' \
		-n fibonacci_wasmtime_jit 'echo "40" | wasmtime run fibonacci.wasm' \
		-n fibonacci_wasmtime_aot 'echo "40" | wasmtime run --allow-precompiled fibonacci.cwasm' \
		-n fibonacci_wamr_int     'echo "40" | iwasm fibonacci.wasm' \
		-n fibonacci_wamr_aot     'echo "40" | iwasm fibonacci.aot' \
		-n fibonacci_wasm3        'echo "40" | wasm3 fibonacci.wasm'
