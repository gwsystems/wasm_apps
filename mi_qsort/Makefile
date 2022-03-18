include ../common.mk

CFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE 
WASMCFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE -D_WASI_EMULATED_SIGNAL
WASMLDFLAGS+= -lwasi-emulated-signal
WASMLDFLAGS+=-Wl,-z,stack-size=128000 -Wl,--export=malloc -Wl,--export=free

ARGS= input_small.dat

.PHONY: all
all: \
	bin/mi_qsort.out \ 
	bin/mi_qsort.wasm \
	bin/mi_qsort.cwasm \
	bin/mi_qsort.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_qsort.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_qsort.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_qsort.wasm
	wasmtime --dir=. bin/mi_qsort.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_qsort.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_qsort.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_qsort.wasm
	wasm3 bin/mi_qsort.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_qsort.wasm
	iwasm --dir=. bin/mi_qsort.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_qsort.aot
	iwasm --dir=. bin/mi_qsort.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_qsort.out
	./bin/mi_qsort.out ${ARGS}

bench.csv: bin/mi_qsort.wasm bin/mi_qsort.cwasm bin/mi_qsort.out bin/mi_qsort.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_qsort_native       './bin/mi_qsort.out ${ARGS}' \
		-n mi_qsort_wasmtime_jit 'wasmtime run --dir=. bin/mi_qsort.wasm ${ARGS}' \
		-n mi_qsort_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_qsort.cwasm ${ARGS}' \
		-n mi_qsort_wasm3        'wasm3 bin/mi_qsort.wasm ${ARGS}' \
		-n mi_qsort_wamr_int     'iwasm --dir=. bin/mi_qsort.wasm ${ARGS}' \
		-n mi_qsort_wamr_aot     'iwasm --dir=. bin/mi_qsort.aot ${ARGS}'
