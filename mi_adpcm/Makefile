include ../common.mk

.PHONY: all
all: \
	bin/mi_adpcm.out \
	bin/mi_adpcm.wasm \
	bin/mi_adpcm.cwasm \
	bin/mi_adpcm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_adpcm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_adpcm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_adpcm.wasm
	wasmtime bin/mi_adpcm.wasm < large.pcm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_adpcm.cwasm
	wasmtime run --allow-precompiled bin/mi_adpcm.cwasm < large.pcm

.PHONY: run_wasm3
run_wasm3: bin/mi_adpcm.wasm
	wasm3 bin/mi_adpcm.wasm < large.pcm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_adpcm.wasm
	iwasm bin/mi_adpcm.wasm < large.pcm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_adpcm.aot
	iwasm bin/mi_adpcm.aot < large.pcm

.PHONY: run_native
run_native: bin/mi_adpcm.out
	./bin/mi_adpcm.out < large.pcm

bench.csv: bin/mi_adpcm.wasm bin/mi_adpcm.cwasm bin/mi_adpcm.out bin/mi_adpcm.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n mi_adpcm_native       './bin/mi_adpcm.out < large.pcm' \
		-n mi_adpcm_wasmtime_jit 'wasmtime run bin/mi_adpcm.wasm < large.pcm' \
		-n mi_adpcm_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_adpcm.cwasm < large.pcm' \
		-n mi_adpcm_wamr_int     'iwasm fibonacci.wasm < large.pcm' \
		-n mi_adpcm_wamr_aot     'iwasm fibonacci.aot < large.pcm' \
		-n mi_adpcm_wasm3        'wasm3 bin/mi_adpcm.wasm < large.pcm' \
