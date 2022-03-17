include ../common.mk

.PHONY: all
all: \
	bin/app_pid.out \
	bin/app_pid.wasm \
	bin/app_pid.cwasm \
	bin/app_pid.aot

bin/app_pid.wasm: *.cpp
	@mkdir -p bin
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/app_pid.out: *.cpp
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -rf bin/*
	@rm -f bench.csv

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/app_pid.wasm
	wasmtime bin/app_pid.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/app_pid.cwasm
	wasmtime run --allow-precompiled bin/app_pid.cwasm

.PHONY: run_wasm3
run_wasm3: bin/app_pid.wasm
	wasm3 bin/app_pid.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/app_pid.wasm
	iwasm bin/app_pid.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/app_pid.aot
	iwasm bin/app_pid.aot

.PHONY: run_native
run_native: bin/app_pid.out
	./bin/app_pid.out

bench.csv: bin/app_pid.wasm bin/app_pid.cwasm bin/app_pid.out bin/app_pid.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n app_pid_native       './bin/app_pid.out' \
		-n app_pid_wasmtime_jit 'wasmtime run bin/app_pid.wasm' \
		-n app_pid_wasmtime_aot 'wasmtime run --allow-precompiled bin/app_pid.cwasm' \
		-n app_pid_wamr_int     'iwasm bin/app_pid.wasm' \
		-n app_pid_wamr_aot     'iwasm bin/app_pid.aot' \
		-n app_pid_wasm3        'wasm3 bin/app_pid.wasm'
