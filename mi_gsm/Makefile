WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -I. -DSASR -Wno-everything -D_WASI_EMULATED_SIGNAL -DHAS_ERRNO_DECL -DHAS_FCNTL_H
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -lwasi-emulated-signal
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/mi_gsm.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/mi_gsm.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/mi_gsm.wasm
	wasmtime --dir=. bin/mi_gsm.wasm -- -fps -c large.au

# /opt/wasi-sdk//bin/clang --sysroot=/opt/wasi-sdk//share/wasi-sysroot/ -Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -lwasi-emulated-signal -O3 -flto -Wall -I. -DSASR -Wno-everything -D_WASI_EMULATED_SIGNAL -DHAS_ERRNO_DECL -DHAS_FCNTL_H toast_alaw.c gsm_option.c decode.c toast_lin.c gsm_implode.c table.c long_term.c gsm_explode.c toast.c gsm_encode.c rpe.c gsm_destroy.c code.c lpc.c short_term.c gsm_create.c debug.c add.c toast_ulaw.c toast_audio.c gsm_decode.c preprocess.c gsm_print.c -o bin/mi_gsm.wasm
# wasmtime bin/mi_gsm.wasm 
# Error: failed to run main module `bin/mi_gsm.wasm`

# Caused by:
#     0: failed to instantiate "bin/mi_gsm.wasm"
#     1: unknown import: `env::fchmod` has not been defined
# make: *** [Makefile:19: run] Error 1
