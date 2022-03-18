include ../common.mk

ARGS= e input_large.asc /dev/null 1234567890abcdeffedcba0987654321

.PHONY: all
all: \
	bin/mi_blowfish.out \
	bin/mi_blowfish.wasm \
	bin/mi_blowfish.cwasm \
	bin/mi_blowfish.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_blowfish.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_blowfish.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_blowfish.wasm
	wasmtime --dir=. bin/mi_blowfish.wasm -- ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_blowfish.cwasm
	wasmtime run --allow-precompiled --dir=. bin/mi_blowfish.cwasm -- ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_blowfish.wasm
	wasm3 --stack-size 5120KB bin/mi_blowfish.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_blowfish.wasm
	iwasm --dir=. --dir=/dev bin/mi_blowfish.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_blowfish.aot
	iwasm --dir=. --dir=/dev bin/mi_blowfish.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_blowfish.out
	./bin/mi_blowfish.out ${ARGS}

bench.csv: bin/mi_blowfish.wasm bin/mi_blowfish.cwasm bin/mi_blowfish.out bin/mi_blowfish.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_blowfish_native       './bin/mi_blowfish.out ${ARGS}' \
	-n mi_blowfish_wasmtime_jit 'wasmtime run --dir=. bin/mi_blowfish.wasm -- ${ARGS}' \
	-n mi_blowfish_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_blowfish.cwasm -- ${ARGS}' \
	-n mi_blowfish_wasm3        'wasm3 bin/mi_blowfish.wasm ${ARGS}' \
	-n mi_blowfish_wamr_int     'iwasm --dir=. --dir=/dev bin/mi_blowfish.wasm ${ARGS}' \
	-n mi_blowfish_wamr_aot     'iwasm --dir=. --dir=/dev bin/mi_blowfish.aot ${ARGS}'
