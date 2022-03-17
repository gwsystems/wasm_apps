include ../common.mk

LDFLAGS+= -lm
WASMLDFLAGS+=-Wl,--export=malloc -Wl,--export=free
ARGS= -a -q -o /dev/null


.PHONY: all
all: \
	bin/mi_rsynth.out \
	bin/mi_rsynth.wasm \
	bin/mi_rsynth.cwasm \
	bin/mi_rsynth.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_rsynth.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_rsynth.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_rsynth.wasm
	wasmtime bin/mi_rsynth.wasm -- ${ARGS} < largeinput.txt

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_rsynth.cwasm
	wasmtime run --allow-precompiled bin/mi_rsynth.cwasm -- ${ARGS} < largeinput.txt

.PHONY: run_wasm3
run_wasm3: bin/mi_rsynth.wasm
	wasm3 bin/mi_rsynth.wasm ${ARGS} < largeinput.txt

.PHONY: run_wamr_int
run_wamr_int: bin/mi_rsynth.wasm
	iwasm bin/mi_rsynth.wasm ${ARGS} < largeinput.txt

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_rsynth.aot
	iwasm bin/mi_rsynth.aot ${ARGS} < largeinput.txt

.PHONY: run_native
run_native: bin/mi_rsynth.out
	./bin/mi_rsynth.out ${ARGS} < largeinput.txt

bench.csv: bin/mi_rsynth.wasm bin/mi_rsynth.cwasm bin/mi_rsynth.out  bin/mi_rsynth.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_rsynth_native       './bin/mi_rsynth.out' \
	-n mi_rsynth_wasmtime_jit 'wasmtime run bin/mi_rsynth.wasm -- ${ARGS} < largeinput.txt' \
	-n mi_rsynth_wasmtime_aot 'wasmtime run --allow-precompiled bin/mi_rsynth.cwasm -- ${ARGS} < largeinput.txt' \
	-n mi_rsynth_wasm3        'wasm3 bin/mi_rsynth.wasm ${ARGS} < largeinput.txt' \
	-n mi_rsynth_wamr_int     'iwasm bin/mi_rsynth.wasm ${ARGS} < largeinput.txt' \
	-n mi_rsynth_wamr_aot     'iwasm bin/mi_rsynth.aot ${ARGS} < largeinput.txt'
