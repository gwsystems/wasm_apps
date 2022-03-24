include ../common.mk

.PHONY: all
all: \
	stack_overflow.out \
	stack_overflow.wasm \
	stack_overflow.cwasm \
	stack_overflow.aot

.PHONY: clean
clean:
	@rm -f stack_overflow.out
	@rm -f stack_overflow.wasm
	@rm -f stack_overflow.cwasm
	@rm -f stack_overflow.aot
	@rm -f bench.csv

stack_overflow.wasm: stack_overflow.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} -Wl,-z,stack-size=16,--stack-first $^ -o $@

stack_overflow.out: stack_overflow.c
	@${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@
	
.PHONY: run_wasmtime_jit
run_wasmtime_jit: stack_overflow.wasm
	wasmtime stack_overflow.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: stack_overflow.cwasm
	wasmtime run --allow-precompiled stack_overflow.cwasm

.PHONY: run_wasm3
run_wasm3: stack_overflow.wasm
	wasm3 stack_overflow.wasm

.PHONY: run_wamr_int
run_wamr_int: stack_overflow.wasm
	iwasm stack_overflow.wasm

.PHONY: run_wamr_aot
run_wamr_aot: stack_overflow.aot
	iwasm stack_overflow.aot

.PHONY: run_native
run_native: stack_overflow.out
	./stack_overflow.out

bench.csv: stack_overflow.wasm stack_overflow.cwasm stack_overflow.out stack_overflow.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n stack_overflow_native       './stack_overflow.out' \
	-n stack_overflow_wasmtime_jit 'wasmtime run stack_overflow.wasm' \
	-n stack_overflow_wasmtime_aot 'wasmtime run --allow-precompiled stack_overflow.cwasm' \
	-n stack_overflow_wamr_int     'iwasm stack_overflow.wasm' \
	-n stack_overflow_wamr_aot     'iwasm stack_overflow.aot' \
	-n stack_overflow_wasm3        'wasm3 stack_overflow.wasm'
