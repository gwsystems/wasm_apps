include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/mi_basic_math.out \
	bin/mi_basic_math.wasm \
	bin/mi_basic_math.cwasm \
	bin/mi_basic_math.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_basic_math.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS }$^ -o $@

bin/mi_basic_math.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_basic_math.wasm
	wasmtime bin/mi_basic_math.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_basic_math.cwasm
	wasmtime run --allow-precompiled bin/mi_basic_math.cwasm

.PHONY: run_wasm3
run_wasm3: bin/mi_basic_math.wasm
	wasm3 bin/mi_basic_math.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_basic_math.wasm
	iwasm bin/mi_basic_math.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_basic_math.aot
	iwasm bin/mi_basic_math.aot

.PHONY: run_native
run_native: bin/mi_basic_math.out
	./bin/mi_basic_math.out

bench.csv: bin/mi_basic_math.wasm bin/mi_basic_math.cwasm bin/mi_basic_math.out
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_basic_math_native       './bin/mi_basic_math.out' \
		-n mi_basic_math_wasmtime_jit 'wasmtime run bin/mi_basic_math.wasm' \
		-n mi_basic_math_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_basic_math.cwasm' \
		-n mi_basic_math_wamr_int     'iwasm bin/mi_basic_math.wasm' \
		-n mi_basic_math_wamr_aot     'iwasm bin/mi_basic_math.aot' \
		-n mi_basic_math_wasm3        'wasm3 bin/mi_basic_math.wasm'
