WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC=clang
OPTFLAGS=-O3 -flto -Wall -Wno-incompatible-library-redeclaration -Wno-implicit-function-declaration -Wno-shift-negative-value
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1 -I.
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

.PHONY: all
all: bin/custom_libjpeg.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_libjpeg.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} $^ -o $@

run: bin/custom_libjpeg.wasm
	wasmtime bin/custom_libjpeg.wasm

# Can't build because WASI does not support tmpfile! 
# jmemansi.c:144:26: warning: 'tmpfile' is deprecated: tmpfile is not defined on WASI [-Wdeprecated-declarations]
#  if ((info->temp_file = tmpfile()) == NULL)
#                         ^
#/opt/wasi-sdk//share/wasi-sysroot//include/stdio.h:151:36: note: 'tmpfile' has been explicitly marked deprecated here
#FILE *tmpfile(void) __attribute__((__deprecated__("tmpfile is not defined on WASI")));
