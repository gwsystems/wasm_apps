include ../common.mk

.PHONY: all
all: \
	bin/mi_crc.out \
	bin/mi_crc.wasm \
	bin/mi_crc.cwasm \
	bin/mi_crc.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_crc.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_crc.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_crc.wasm
	wasmtime --dir=. bin/mi_crc.wasm large.pcm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_crc.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_crc.cwasm large.pcm

.PHONY: run_wasm3
run_wasm3: bin/mi_crc.wasm
	wasm3 bin/mi_crc.wasm large.pcm

.PHONY: run_wamr_int
run_wamr_int: bin/mi_crc.wasm
	iwasm --dir=. bin/mi_crc.wasm large.pcm

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_crc.aot
	iwasm --dir=. bin/mi_crc.aot large.pcm

.PHONY: run_native
run_native: bin/mi_crc.out
	./bin/mi_crc.out large.pcm

bench.csv: bin/mi_crc.wasm bin/mi_crc.cwasm bin/mi_crc.out bin/mi_crc.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_crc_native       './bin/mi_crc.out large.pcm' \
	-n mi_crc_wasmtime_jit 'wasmtime run --dir=. bin/mi_crc.wasm large.pcm' \
	-n mi_crc_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_crc.cwasm large.pcm' \
	-n mi_crc_wasm3        'wasm3 bin/mi_crc.wasm large.pcm' \
	-n mi_crc_wamr_int     'iwasm --dir=.  bin/mi_crc.wasm large.pcm' \
	-n mi_crc_wamr_aot     'iwasm --dir=.  bin/mi_crc.aot large.pcm'
