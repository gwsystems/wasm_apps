include ../common.mk

LDFLAGS+= -lm

.PHONY: all
all: \
	bin/pb_datamining_covariance.out \
	bin/pb_datamining_covariance.wasm \
	bin/pb_datamining_covariance.cwasm \
	bin/pb_datamining_covariance.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/pb_datamining_covariance.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/pb_datamining_covariance.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/pb_datamining_covariance.wasm
	wasmtime bin/pb_datamining_covariance.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/pb_datamining_covariance.cwasm
	wasmtime run --allow-precompiled bin/pb_datamining_covariance.cwasm

.PHONY: run_wasm3
run_wasm3: bin/pb_datamining_covariance.wasm
	wasm3 bin/pb_datamining_covariance.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/pb_datamining_covariance.wasm
	iwasm bin/pb_datamining_covariance.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/pb_datamining_covariance.aot
	iwasm bin/pb_datamining_covariance.aot

.PHONY: run_native
run_native: bin/pb_datamining_covariance.out
	./bin/pb_datamining_covariance.out

bench.csv: bin/pb_datamining_covariance.wasm bin/pb_datamining_covariance.cwasm bin/pb_datamining_covariance.out bin/pb_datamining_covariance.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n pb_datamining_covariance_native       './bin/pb_datamining_covariance.out' \
		-n pb_datamining_covariance_wasmtime_jit 'wasmtime run bin/pb_datamining_covariance.wasm' \
		-n pb_datamining_covariance_wasmtime_aot 'wasmtime run --allow-precompiled bin/pb_datamining_covariance.cwasm' \
		-n pb_datamining_covariance_wasm3        'wasm3 bin/pb_datamining_covariance.wasm' \
		-n pb_datamining_covariance_wamr_int     'iwasm bin/pb_datamining_covariance.wasm' \
		-n pb_datamining_covariance_wamr_aot     'iwasm bin/pb_datamining_covariance.aot'
