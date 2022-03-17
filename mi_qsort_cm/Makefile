include ../common.mk

CFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE 
WASMCFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE -D_WASI_EMULATED_SIGNAL
WASMLDFLAGS+= -lwasi-emulated-signal
WASMLDFLAGS+=-Wl,-z,stack-size=256000 -Wl,--export=malloc -Wl,--export=free

.PHONY: all
all: \
	bin/mi_qsort_cm.out \ 
	bin/mi_qsort_cm.wasm \
	bin/mi_qsort_cm.cwasm \
	bin/mi_qsort_cm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_qsort_cm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_qsort_cm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_qsort_cm.wasm
	wasmtime bin/mi_qsort_cm.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_qsort_cm.cwasm
	wasmtime run --allow-precompiled bin/mi_qsort_cm.cwasm

.PHONY: run_wasm3
run_wasm3: bin/mi_qsort_cm.wasm
	wasm3 bin/mi_qsort_cm.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_qsort_cm.wasm
	iwasm bin/mi_qsort_cm.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_qsort_cm.aot
	iwasm bin/mi_qsort_cm.aot

.PHONY: run_native
run_native: bin/mi_qsort_cm.out
	./bin/mi_qsort_cm.out

bench.csv: bin/mi_qsort_cm.wasm bin/mi_qsort_cm.cwasm bin/mi_qsort_cm.out bin/mi_qsort_cm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_qsort_cm_native       './bin/mi_qsort_cm.out' \
	-n mi_qsort_cm_wasmtime_jit 'wasmtime run bin/mi_qsort_cm.wasm' \
	-n mi_qsort_cm_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_qsort_cm.cwasm' \
	-n mi_qsort_cm_wasm3        'wasm3 bin/mi_qsort_cm.wasm' \
	-n mi_qsort_cm_wamr_int     'iwasm bin/mi_qsort_cm.wasm' \
	-n mi_qsort_cm_wamr_aot     'iwasm bin/mi_qsort_cm.aot'
