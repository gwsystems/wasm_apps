include ../common.mk

CFLAGS+= -DSQLITE_MUTEX_NOOP
LDFLAGS+= -ldl

WASMCFLAGS+= -DSQLITE_MUTEX_NOOP -D_WASI_EMULATED_MMAN
WASMLDFLAGS+= -lwasi-emulated-mman

.PHONY: all
all: \
	bin/custom_sqlite.out \
	bin/custom_sqlite.wasm \
	bin/custom_sqlite.cwasm \
	bin/custom_sqlite.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_sqlite.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_sqlite.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_sqlite.wasm
	wasmtime bin/custom_sqlite.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_sqlite.cwasm
	wasmtime run --allow-precompiled bin/custom_sqlite.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_sqlite.wasm
	wasm3 bin/custom_sqlite.wasm

.PHONY: run_native
run_native: bin/custom_sqlite.out
	./bin/custom_sqlite.out

bench.csv: bin/custom_sqlite.wasm bin/custom_sqlite.cwasm bin/custom_sqlite.out
	hyperfine -N -w 10 --export-csv bench.csv \
		-n custom_sqlite_native       './bin/custom_sqlite.out' \
		-n custom_sqlite_wasmtime_jit 'wasmtime run bin/custom_sqlite.wasm' \
		-n custom_sqlite_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_sqlite.cwasm' \
		-n custom_sqlite_wamr_int     'iwasm bin/custom_sqlite.wasm' \
		-n custom_sqlite_wamr_aot     'iwasm bin/custom_sqlite.aot' \
		-n custom_sqlite_wasm3        'wasm3 bin/custom_sqlite.wasm'
