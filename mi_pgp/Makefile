include ../common.mk

CFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE
WASMCFLAGS+= -DUNIX -D_BSD -DPORTABLE -DUSE_NBIO -DMPORTABLE -D_WASI_EMULATED_SIGNAL
WASMLDFLAGS+= -lwasi-emulated-signal

ARGS=-sa -z "this is a test" -u taustin@eecs.umich.edu testin.txt austin@umich.edu

.PHONY: all
all: \
	bin/mi_pgp.out \
	bin/mi_pgp.wasm \
	bin/mi_pgp.cwasm \
	bin/mi_pgp.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_pgp.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_pgp.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_pgp.wasm
	wasmtime run --dir=. bin/mi_pgp.wasm ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_pgp.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_pgp.cwasm ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_pgp.wasm
	wasm3 bin/mi_pgp.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_pgp.wasm
	iwasm --dir=. bin/mi_pgp.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_pgp.aot
	iwasm --dir=. bin/mi_pgp.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_pgp.out
	./bin/mi_pgp.out ${ARGS}

bench.csv: bin/mi_pgp.wasm bin/mi_pgp.cwasm bin/mi_pgp.out bin/mi_pgp.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_pgp_native       './bin/mi_pgp.out ${ARGS} \
		-n mi_pgp_wasmtime_jit 'wasmtime run bin/mi_pgp.wasm ${ARGS} \
		-n mi_pgp_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_pgp.cwasm ${ARGS} \
		-n mi_pgp_wamr_int     'iwasm bin/mi_pgp.wasm ${ARGS}' \
		-n mi_pgp_wamr_aot     'iwasm bin/mi_pgp.aot ${ARGS}' \
		-n mi_pgp_wasm3        'wasm3 bin/mi_pgp.wasm ${ARGS}
