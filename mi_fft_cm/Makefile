include ../common.mk

LDFLAGS+= -lm
WASMLDFLAGS+= -Wl,--export=malloc -Wl,--export=free

ARGS= 8 32768


# WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288,--allow-undefined,--threads=1

.PHONY: all
all: \
	bin/mi_fft_cm.out \
	bin/mi_fft_cm.wasm \
	bin/mi_fft_cm.cwasm \
	bin/mi_fft_cm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_fft_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_fft_cm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_fft_cm.wasm
	wasmtime bin/mi_fft_cm.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_fft_cm.cwasm
	wasmtime run --allow-precompiled bin/mi_fft_cm.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_fft_cm.wasm
	wasm3 bin/mi_fft_cm.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_fft_cm.wasm
	iwasm bin/mi_fft_cm.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_fft_cm.aot
	iwasm bin/mi_fft_cm.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_fft_cm.out
	./bin/mi_fft_cm.out ${ARGS}

bench.csv: bin/mi_fft_cm.wasm bin/mi_fft_cm.cwasm bin/mi_fft_cm.out bin/mi_fft_cm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_fft_cm_native       './bin/mi_fft_cm.out ${ARGS}' \
	-n mi_fft_cm_wasmtime_jit 'wasmtime run bin/mi_fft_cm.wasm ${ARGS}' \
	-n mi_fft_cm_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_fft_cm.cwasm ${ARGS}' \
	-n mi_fft_cm_wasm3        'wasm3 bin/mi_fft_cm.wasm ${ARGS}' \
	-n mi_fft_cm_wamr_int     'iwasm bin/mi_fft_cm.wasm  ${ARGS}' \
	-n mi_fft_cm_wamr_aot     'iwasm bin/mi_fft_cm.aot ${ARGS}'
