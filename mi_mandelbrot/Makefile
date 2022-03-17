include ../common.mk

ARGS=5000

.PHONY: all
all: \
	bin/mi_mandelbrot.out \
	bin/mi_mandelbrot.wasm \
	bin/mi_mandelbrot.cwasm \
	bin/mi_mandelbrot.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_mandelbrot.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_mandelbrot.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_mandelbrot.wasm
	wasmtime bin/mi_mandelbrot.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_mandelbrot.cwasm
	wasmtime run --allow-precompiled bin/mi_mandelbrot.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_mandelbrot.wasm
	wasm3 bin/mi_mandelbrot.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_mandelbrot.wasm
	iwasm bin/mi_mandelbrot.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_mandelbrot.aot
	iwasm bin/mi_mandelbrot.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_mandelbrot.out
	./bin/mi_mandelbrot.out ${ARGS}

bench.csv: bin/mi_mandelbrot.wasm bin/mi_mandelbrot.cwasm bin/mi_mandelbrot.out bin/mi_mandelbrot.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_mandelbrot_native       './bin/mi_mandelbrot.out ${ARGS}' \
		-n mi_mandelbrot_wasmtime_jit 'wasmtime run bin/mi_mandelbrot.wasm ${ARGS}' \
		-n mi_mandelbrot_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_mandelbrot.cwasm ${ARGS}' \
		-n mi_mandelbrot_wamr_int     'iwasm bin/mi_mandelbrot.wasm ${ARGS}' \
		-n mi_mandelbrot_wamr_aot     'iwasm bin/mi_mandelbrot.aot ${ARGS}' \
		-n mi_mandelbrot_wasm3        'wasm3 bin/mi_mandelbrot.wasm ${ARGS}'
