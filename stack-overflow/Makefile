include ../common.mk

.PHONY: all
all: \
	stack-overflow.out \
	stack-overflow.wasm \
	stack-overflow.cwasm \
	stack-overflow.aot

.PHONY: clean
clean:
	@rm -f stack-overflow.out
	@rm -f stack-overflow.wasm
	@rm -f stack-overflow.cwasm
	@rm -f stack-overflow.aot
	@rm -f bench.csv

stack-overflow.wasm: stack-overflow.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} -Wl,-z,stack-size=16,--stack-first $^ -o $@

stack-overflow.out: stack-overflow.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
	
.PHONY: run_wasmtime_jit
run_wasmtime_jit: stack-overflow.wasm
	wasmtime stack-overflow.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: stack-overflow.cwasm
	wasmtime run --allow-precompiled stack-overflow.cwasm

.PHONY: run_wasm3
run_wasm3: stack-overflow.wasm
	wasm3 stack-overflow.wasm

.PHONY: run_wamr_int
run_wamr_int: stack-overflow.wasm
	iwasm stack-overflow.wasm

.PHONY: run_wamr_aot
run_wamr_aot: stack-overflow.aot
	iwasm stack-overflow.aot

.PHONY: run_native
run_native: stack-overflow.out
	./stack-overflow.out

bench.csv: stack-overflow.wasm stack-overflow.cwasm stack-overflow.out stack-overflow.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n stack-overflow_native       './stack-overflow.out' \
	-n stack-overflow_wasmtime_jit 'wasmtime run stack-overflow.wasm' \
	-n stack-overflow_wasmtime_aot 'wasmtime run --allow-precompiled stack-overflow.cwasm' \
	-n stack-overflow_wamr_int     'iwasm stack-overflow.wasm' \
	-n stack-overflow_wamr_aot     'iwasm stack-overflow.aot' \
	-n stack-overflow_wasm3        'wasm3 stack-overflow.wasm'
