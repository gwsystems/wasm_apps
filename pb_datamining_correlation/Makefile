include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_datamining_correlation.out \
	bin/pb_datamining_correlation.wasm \
	bin/pb_datamining_correlation.cwasm \
	bin/pb_datamining_correlation.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_datamining_correlation.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_datamining_correlation.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_datamining_correlation.wasm
	wasmtime bin/pb_datamining_correlation.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_datamining_correlation.cwasm
	wasmtime run --allow-precompiled bin/pb_datamining_correlation.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_datamining_correlation.wasm
	wasm3 bin/pb_datamining_correlation.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_datamining_correlation.wasm
	iwasm bin/pb_datamining_correlation.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_datamining_correlation.aot
	iwasm bin/pb_datamining_correlation.aot

.PHONY: run_native
run_native: bin/pb_datamining_correlation.out
	./bin/pb_datamining_correlation.out

bench.csv: bin/pb_datamining_correlation.wasm bin/pb_datamining_correlation.cwasm bin/pb_datamining_correlation.out bin/pb_datamining_correlation.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n pb_datamining_correlation_native       './bin/pb_datamining_correlation.out' \
	-n pb_datamining_correlation_wasmtime_jit 'wasmtime run bin/pb_datamining_correlation.wasm' \
	-n pb_datamining_correlation_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_datamining_correlation.cwasm' \
	-n pb_datamining_correlation_wasm3        'wasm3 bin/pb_datamining_correlation.wasm' \
	-n pb_datamining_correlation_wamr_int     'iwasm bin/pb_datamining_correlation.wasm' \
	-n pb_datamining_correlation_wamr_aot     'iwasm bin/pb_datamining_correlation.aot'
