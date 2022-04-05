include ../common.mk

.PHONY: all
all: \
	html.out \
	html.wasm \
	html.cwasm \
	html.aot

html.wasm: main.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

html.out: main.c
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: clean
clean:
	@rm -f html.wasm
	@rm -f html.cwasm
	@rm -f html.wasm.out
	@rm -f html.wasm.c
	@rm -f html.out
	@rm -f html.aot
	@rm -f bench.csv

.PHONY: run_wasmtime_jit
run_wasmtime_jit: html.wasm
	wasmtime html.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: html.cwasm
	wasmtime run --allow-precompiled html.cwasm

.PHONY: run_wasm3
run_wasm3: html.wasm
	wasm3 html.wasm

.PHONY: run_wamr_int
run_wamr_int: html.wasm
	iwasm html.wasm

.PHONY: run_wamr_aot
run_wamr_aot: html.aot
	iwasm html.aot

.PHONY: run_native
run_native: html.out
	./html.out

bench.csv: html.wasm html.cwasm html.out html.aot
	hyperfine -w 10 --export-csv bench.csv \
		-n html_native       './html.out' \
		-n html_wasmtime_jit 'wasmtime run html.wasm' \
		-n html_wasmtime_aot 'wasmtime run --allow-precompiled html.cwasm' \
		-n html_wamr_int     'iwasm html.wasm' \
		-n html_wamr_aot     'iwasm html.aot' \
		-n html_wasm3        'wasm3 html.wasm'
