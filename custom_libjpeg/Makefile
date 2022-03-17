include ../common.mk

# CFLAGS=-O3 -I. -Wall -Wno-incompatible-library-redeclaration -Wno-implicit-function-declaration -Wno-shift-negative-value
# See https://lld.llvm.org/WebAssembly.html
# WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288,--allow-undefined,--threads=1
# WASMLDFLAGS+=-Wl,-z,stack-size=524288 -Wl,--export=malloc -Wl,--export=free

.PHONY: all
all: \
	bin/custom_libjpeg.out \
	bin/custom_libjpeg.wasm \ 
	bin/custom_libjpeg.cwasm \
	bin/custom_libjpeg.aot

.PHONY: clean
clean:
	@rm -rf bin
	@rm -f bench.csv

bin/custom_libjpeg.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

bin/custom_libjpeg.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run_wasmtime_jit
run_wasmtime_jit: bin/custom_libjpeg.wasm
	wasmtime bin/custom_libjpeg.wasm

.PHONY: run_wasmtime_aot
run_wasmtime_aot: bin/custom_libjpeg.cwasm
	wasmtime run --allow-precompiled bin/custom_libjpeg.cwasm

.PHONY: run_wasm3
run_wasm3: bin/custom_libjpeg.wasm
	wasm3 bin/custom_libjpeg.wasm

.PHONY: run_wamr_int
run_wamr_int: bin/custom_libjpeg.wasm
	iwasm bin/custom_libjpeg.wasm

.PHONY: run_wamr_aot
run_wamr_aot: bin/custom_libjpeg.aot
	iwasm bin/custom_libjpeg.wasm

.PHONY: run_native
run_native: bin/custom_libjpeg.out
	./bin/custom_libjpeg.out

# Can't build because WASI does not support tmpfile! 
# jmemansi.c:144:26: warning: 'tmpfile' is deprecated: tmpfile is not defined on WASI [-Wdeprecated-declarations]
#  if ((info->temp_file = tmpfile()) == NULL)
#                         ^
#/opt/wasi-sdk//share/wasi-sysroot//include/stdio.h:151:36: note: 'tmpfile' has been explicitly marked deprecated here
#FILE *tmpfile(void) __attribute__((__deprecated__("tmpfile is not defined on WASI")));

bench.csv: bin/custom_libjpeg.wasm bin/custom_libjpeg.cwasm bin/custom_libjpeg.out bin/custom_libjpeg.aot
	hyperfine -N -w 10 --export-csv bench.csv \
		-n custom_libjpeg_native       './bin/custom_libjpeg.out' \
		-n custom_libjpeg_wasmtime_jit 'wasmtime run bin/custom_libjpeg.wasm' \
		-n custom_libjpeg_wasmtime_aot 'wasmtime run --allow-precompiled bin/custom_libjpeg.cwasm' \
		-n custom_libjpeg_wamr_int     'iwasm bin/custom_libjpeg.wasm' \
		-n custom_libjpeg_wamr_aot     'iwasm bin/custom_libjpeg.aot' \
		-n custom_libjpeg_wasm3        'wasm3 bin/custom_libjpeg.wasm'
