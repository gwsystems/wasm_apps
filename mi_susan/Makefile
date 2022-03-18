include ../common.mk

LDFLAGS+= -lm
ARGS= input_large.pgm output.pgm -s
WASMLDFLAGS+=-Wl,-z,stack-size=4096000 -Wl,--export=malloc -Wl,--export=free

.PHONY: all
all: \
	bin/mi_susan.out \
	bin/mi_susan.wasm \
	bin/mi_susan.cwasm \
	bin/mi_susan.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_susan.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_susan.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_susan.wasm
	wasmtime --dir=. bin/mi_susan.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_susan.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_susan.cwasm ${ARGS}

# Error: [trap] out of bounds memory access
.PHONY: run_wasm3
run_wasm3: bin/mi_susan.wasm
	wasm3 bin/mi_susan.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_susan.wasm
	iwasm --dir=. bin/mi_susan.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_susan.aot
	iwasm --dir=. bin/mi_susan.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_susan.out
	./bin/mi_susan.out ${ARGS}

bench.csv: bin/mi_susan.wasm bin/mi_susan.cwasm bin/mi_susan.out bin/mi_susan.aot
	hyperfine -N -w 10 --export-csv bench.csv -c 'rm output.pgm' \
		-n mi_susan_native       './bin/mi_susan.out ${ARGS}' \
		-n mi_susan_wasmtime_jit 'wasmtime run --dir=. bin/mi_susan.wasm ${ARGS}' \
		-n mi_susan_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_susan.cwasm ${ARGS}' \
		-n mi_susan_wamr_int     'iwasm --dir=. bin/mi_susan.wasm ${ARGS}' \
		-n mi_susan_wamr_aot     'iwasm --dir=. bin/mi_susan.aot ${ARGS}'
# -n mi_susan_wasm3           'wasm3 bin/mi_susan.wasm ${ARGS}'
