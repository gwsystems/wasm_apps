include ../common.mk

.PHONY: all
all: \
	dummy_tpcc.out \
	dummy_tpcc.wasm \
	dummy_tpcc.cwasm \
	dummy_tpcc.aot

dummy_tpcc.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

dummy_tpcc.out: main.c
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

# dummy_tpcc.wasm.out: dummy_tpcc.wasm.c
# 	${CC} ${CFLAGS} ${LDFLAGS} -Wl,-e,w2c_main -I. $^ -o $@

.PHONY: clean
clean:
	@rm -f dummy_tpcc.wasm
	@rm -f dummy_tpcc.cwasm
	@rm -f dummy_tpcc.wasm.out
	@rm -f dummy_tpcc.wasm.c
	@rm -f dummy_tpcc.out
	@rm -f dummy_tpcc.aot
	@rm -f bench.csv

# Serverless style app that uses stdin and stdout
# echo "10" | make run
.PHONY: run_wasmtime_jit
run_wasmtime_jit: dummy_tpcc.wasm
	@echo "40" | wasmtime dummy_tpcc.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: dummy_tpcc.cwasm
	@echo "40" | wasmtime run --allow-precompiled dummy_tpcc.cwasm

.PHONY: run_wasm3
run_wasm3: dummy_tpcc.wasm
	@echo "40" | wasm3 dummy_tpcc.wasm

.PHONY: run_wamr_int
run_wamr_int: dummy_tpcc.wasm
	@echo "40" | iwasm dummy_tpcc.wasm

.PHONY: run_wamr_aot
run_wamr_aot: dummy_tpcc.aot
	@echo "40" | iwasm dummy_tpcc.aot

.PHONY: run_native
run_native: dummy_tpcc.out
	@./dummy_tpcc.out

bench.csv: dummy_tpcc.wasm dummy_tpcc.cwasm dummy_tpcc.out dummy_tpcc.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n dummy_tpcc_native       'echo "40" | ./dummy_tpcc.out' \
		-n dummy_tpcc_wasmtime_jit 'echo "40" | wasmtime run dummy_tpcc.wasm' \
		-n dummy_tpcc_wasmtime_aot 'echo "40" | wasmtime run --allow-precompiled dummy_tpcc.cwasm' \
		-n dummy_tpcc_wamr_int     'echo "40" | iwasm dummy_tpcc.wasm' \
		-n dummy_tpcc_wamr_aot     'echo "40" | iwasm dummy_tpcc.aot' \
		-n dummy_tpcc_wasm3        'echo "40" | wasm3 dummy_tpcc.wasm'
