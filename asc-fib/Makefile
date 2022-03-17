include ../common.mk

clean:
	rm -f *.wasm
	rm -f *.wasm.map
	rm -f *.wat
	rm -f pnpm-lock.yaml
	rm -rf node_modules

pnpm-lock.yaml:
	pnpm install

fibonacci.wasm: pnpm-lock.yaml
	pnpm asbuild
	cp optimized.wasm fibonacci.wasm

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

bench.csv: fibonacci.wasm fibonacci.cwasm fibonacci.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n fibonacci_assemblyscript_wasmtime_jit 'echo "40" | wasmtime run fibonacci.wasm' \
		-n fibonacci_assemblyscript_wasmtime_aot 'echo "40" | wasmtime run --allow-precompiled fibonacci.cwasm' \
		-n fibonacci_assemblyscript_wamr_int     'echo "40" | iwasm fibonacci.wasm' \
		-n fibonacci_assemblyscript_wamr_aot     'echo "40" | iwasm fibonacci.aot' \
		-n fibonacci_assemblyscript_wasm3        'echo "40" | wasm3 fibonacci.wasm'
