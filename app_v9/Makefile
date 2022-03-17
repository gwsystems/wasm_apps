include ../common.mk

# Increase stack size
WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288

.PHONY: all
all: \
	bin/app_v9.out \
	bin/app_v9.wasm \
	bin/app_v9.cwasm \
	bin/app_v9.aot

bin/app_v9.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/app_v9.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/app_v9.wasm
	wasmtime bin/app_v9.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/app_v9.cwasm
	wasmtime run --allow-precompiled bin/app_v9.cwasm

.PHONY: run_wasm3
run_wasm3: bin/app_v9.wasm
	wasm3 bin/app_v9.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/app_v9.wasm
	iwasm bin/app_v9.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/app_v9.aot
	iwasm bin/app_v9.aot

.PHONY: run_native
run_native: bin/app_v9.out
	./bin/app_v9.out

bench.csv: bin/app_v9.wasm bin/app_v9.cwasm bin/app_v9.out bin/app_v9.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n app_v9_native       './bin/app_v9.out' \
		-n app_v9_wasmtime_jit 'wasmtime run bin/app_v9.wasm' \
		-n app_v9_wasmtime_aot 'wasmtime run --allow-precompiled bin/app_v9.cwasm' \
		-n app_v9_wamr_int     'iwasm bin/app_v9.wasm' \
		-n app_v9_wamr_aot     'iwasm bin/app_v9.aot' \
		-n app_v9_wasm3        'wasm3 bin/app_v9.wasm' \
