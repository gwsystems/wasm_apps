include ../common.mk

LDFLAGS+= -lm
ARGS= 8 32768

.PHONY: all
all: \
	bin/mi_fft.out \
	bin/mi_fft.wasm \
	bin/mi_fft.cwasm \
	bin/mi_fft.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_fft.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_fft.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_fft.wasm
	wasmtime bin/mi_fft.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_fft.cwasm
	wasmtime run --allow-precompiled bin/mi_fft.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_fft.wasm
	wasm3 bin/mi_fft.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_fft.wasm
	iwasm bin/mi_fft.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_fft.aot
	iwasm bin/mi_fft.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_fft.out
	./bin/mi_fft.out ${ARGS}

bench.csv: bin/mi_fft.wasm bin/mi_fft.cwasm bin/mi_fft.out bin/mi_fft.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_fft_native       './bin/mi_fft.out ${ARGS}' \
	-n mi_fft_wasmtime_jit 'wasmtime run bin/mi_fft.wasm ${ARGS}' \
	-n mi_fft_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_fft.cwasm ${ARGS}' \
	-n mi_fft_wasm3        'wasm3 bin/mi_fft.wasm ${ARGS}' \
	-n mi_fft_wamr_int     'iwasm bin/mi_fft.wasm  ${ARGS}' \
	-n mi_fft_wamr_aot     'iwasm bin/mi_fft.aot ${ARGS}'
