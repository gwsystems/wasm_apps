include ../common.mk

CFLAGS+= -DHAS_ERRNO_DECL -DSASR 
WASMCFLAGS+= -DHAS_ERRNO_DECL -DSASR -D_WASI_EMULATED_SIGNAL
WASMLDFLAGS+= -lwasi-emulated-signal
ARGS= -fps -c large.au

.PHONY: all
all: \
	bin/mi_gsm.out \
	bin/mi_gsm.wasm \
	bin/mi_gsm.cwasm \
	bin/mi_gsm.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/mi_gsm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/mi_gsm.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/mi_gsm.wasm
	wasmtime --dir=. bin/mi_gsm.wasm -- ${ARGS}

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/mi_gsm.cwasm
	wasmtime run --dir=. --allow-precompiled bin/mi_gsm.cwasm -- ${ARGS}

.PHONY: run_wasm3
run_wasm3: bin/mi_gsm.wasm
	wasm3 bin/mi_gsm.wasm ${ARGS}

.PHONY: run_wamr_int
run_wamr_int: bin/mi_gsm.wasm
	iwasm --dir=. bin/mi_gsm.wasm ${ARGS}

.PHONY: run_wamr_aot
run_wamr_aot: bin/mi_gsm.aot
	iwasm --dir=. bin/mi_gsm.aot ${ARGS}

.PHONY: run_native
run_native: bin/mi_gsm.out
	./bin/mi_gsm.out ${ARGS}

# /opt/wasi-sdk//bin/clang --sysroot=/opt/wasi-sdk//share/wasi-sysroot/ -Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -lwasi-emulated-signal -O3 -flto -Wall -I. -DSASR -Wno-everything -D_WASI_EMULATED_SIGNAL -DHAS_ERRNO_DECL -DHAS_FCNTL_H toast_alaw.c gsm_option.c decode.c toast_lin.c gsm_implode.c table.c long_term.c gsm_explode.c toast.c gsm_encode.c rpe.c gsm_destroy.c code.c lpc.c short_term.c gsm_create.c debug.c add.c toast_ulaw.c toast_audio.c gsm_decode.c preprocess.c gsm_print.c -o bin/mi_gsm.wasm
# wasmtime bin/mi_gsm.wasm 
# Error: failed to run main module `bin/mi_gsm.wasm`

# Caused by:
#     0: failed to instantiate "bin/mi_gsm.wasm"
#     1: unknown import: `env::fchmod` has not been defined
# make: *** [Makefile:19: run] Error 1

bench.csv: bin/mi_gsm.wasm bin/mi_gsm.cwasm bin/mi_gsm.out bin/mi_gsm.aot
	hyperfine -N -w 10 --export-csv bench.csv \
	-n mi_gsm_native       './bin/mi_gsm.out ${ARGS}' \
	-n mi_gsm_wasmtime_jit 'wasmtime run --dir=. bin/mi_gsm.wasm -- ${ARGS}' \
	-n mi_gsm_wasmtime_aot 'wasmtime run --dir=. --allow-precompiled bin/mi_gsm.cwasm -- ${ARGS}' \
	-n mi_gsm_wasm3        'wasm3 bin/mi_gsm.wasm ${ARGS}' \
	-n mi_gsm_wamr_int     'iwasm --dir=. bin/mi_gsm.wasm ${ARGS}' \
	-n mi_gsm_wamr_aot     'iwasm --dir=. bin/mi_gsm.aot ${ARGS}'
