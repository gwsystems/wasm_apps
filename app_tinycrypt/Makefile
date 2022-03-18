include ../common.mk

# Increase stack size
WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288

.PHONY: all
all: \
	bin/app_tinycrypt.out \
	bin/app_tinycrypt.wasm \
	bin/app_tinycrypt.cwasm \
	bin/app_tinycrypt.aot

bin/app_tinycrypt.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/app_tinycrypt.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/app_tinycrypt.wasm
	wasmtime bin/app_tinycrypt.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/app_tinycrypt.cwasm
	wasmtime run --allow-precompiled bin/app_tinycrypt.cwasm

.PHONY: run_wasm3
run_wasm3: bin/app_tinycrypt.wasm
	wasm3 bin/app_tinycrypt.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/app_tinycrypt.wasm
	iwasm bin/app_tinycrypt.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/app_tinycrypt.aot
	iwasm bin/app_tinycrypt.aot

.PHONY: run_native
run_native: bin/app_tinycrypt.out
	./bin/app_tinycrypt.out

bench.csv: bin/app_tinycrypt.wasm bin/app_tinycrypt.cwasm bin/app_tinycrypt.out bin/app_tinycrypt.aot
	hyperfine -N -w 1 -r 2 --export-csv bench.csv \
	-n app_tinycrypt_native       './bin/app_tinycrypt.out' \
	-n app_tinycrypt_wasmtime_jit 'wasmtime run bin/app_tinycrypt.wasm' \
	-n app_tinycrypt_wasmtime_aot 'wasmtime run --allow-precompiled bin/app_tinycrypt.cwasm' \
	-n app_tinycrypt_wamr_int     'iwasm bin/app_tinycrypt.wasm' \
	-n app_tinycrypt_wamr_aot     'iwasm bin/app_tinycrypt.aot' \
	-n app_tinycrypt_wasm3        'wasm3 bin/app_tinycrypt.wasm'
