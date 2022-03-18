include ../common.mk

.PHONY: all
all: \
	bin/mi_sha.out \
	bin/mi_sha.wasm \
	bin/mi_sha.cwasm \
	bin/mi_sha.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_sha.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_sha.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_sha.wasm
	wasmtime --dir=. bin/mi_sha.wasm input_large.asc

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_sha.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_sha.cwasm input_large.asc

.PHONY: run_wasm3
run_wasm3: bin/mi_sha.wasm
	wasm3 bin/mi_sha.wasm input_large.asc

.PHONY: run_wamr_int
run_wamr_int: bin/mi_sha.wasm
	iwasm --dir=. bin/mi_sha.wasm input_large.asc

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_sha.aot
	iwasm --dir=. bin/mi_sha.aot input_large.asc

.PHONY: run_native
run_native: bin/mi_sha.out
	./bin/mi_sha.out input_large.asc

bench.csv: bin/mi_sha.wasm bin/mi_sha.cwasm bin/mi_sha.out
	hyperfine -N -w 10 --export-csv bench.csv \
		-n mi_sha_native       './bin/mi_sha.out input_large.asc' \
		-n mi_sha_wasmtime_jit 'wasmtime run --dir=. bin/mi_sha.wasm input_large.asc' \
		-n mi_sha_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_sha.cwasm input_large.asc' \
		-n mi_sha_wasm3        'wasm3 bin/mi_sha.wasm input_large.asc' \
		-n mi_rsynth_wamr_int  'iwasm --dir=. bin/mi_rsynth.wasm input_large.asc' \
		-n mi_rsynth_wamr_aot  'iwasm --dir=. bin/mi_rsynth.aot input_large.asc'
