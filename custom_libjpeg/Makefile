CC=clang
CFLAGS=-O3 -I. -Wall -Wno-incompatible-library-redeclaration -Wno-implicit-function-declaration -Wno-shift-negative-value
LDFLAGS=-flto

WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
WASMCFLAGS=${CFLAGS}

# See https://lld.llvm.org/WebAssembly.html
WASMLDFLAGS=${LDFLAGS} -Wl,-z,stack-size=524288,--allow-undefined,--threads=1

# Clang 12 WebAssembly Options
# See https://clang.llvm.org/docs/ClangCommandLineReference.html#webassembly
# Disable WebAssembly Proposals aWsm does not support
WASMCFLAGS+= -mno-atomics # https://github.com/WebAssembly/threads
WASMCFLAGS+= -mno-bulk-memory # https://github.com/WebAssembly/bulk-memory-operations
WASMCFLAGS+= -mno-exception-handling # https://github.com/WebAssembly/exception-handling
WASMCFLAGS+= -mno-multivalue # https://github.com/WebAssembly/multi-value
# Mutable globals still exist, but disables the ability to import mutable globals
WASMCFLAGS+= -mno-mutable-globals # https://github.com/WebAssembly/mutable-global
WASMCFLAGS+= -mno-nontrapping-fptoint # https://github.com/WebAssembly/nontrapping-float-to-int-conversions
WASMCFLAGS+= -mno-reference-types # https://github.com/WebAssembly/reference-types
WASMCFLAGS+= -mno-sign-ext # https://github.com/WebAssembly/sign-extension-ops
WASMCFLAGS+= -mno-tail-call # https://github.com/WebAssembly/tail-call
WASMCFLAGS+= -mno-simd128 # https://github.com/webassembly/simd

.PHONY: all
all: \
	bin/custom_libjpeg.out \
	bin/custom_libjpeg.wasm

.PHONY: clean
clean:
	@rm -rf bin

bin/custom_libjpeg.wasm: *.c
	@mkdir -p bin
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

%.wat: %.wasm
	wasm2wat $< -o $@

bin/custom_libjpeg.out: *.c
	@mkdir -p bin
	${CC} ${CFLAGS} ${LDFLAGS} $^ -o $@

.PHONY: run
run: bin/custom_libjpeg.wasm
	wasmtime bin/custom_libjpeg.wasm

.PHONY: run_native
run_native: bin/custom_libjpeg.out
	./bin/custom_libjpeg.out

# Can't build because WASI does not support tmpfile! 
# jmemansi.c:144:26: warning: 'tmpfile' is deprecated: tmpfile is not defined on WASI [-Wdeprecated-declarations]
#  if ((info->temp_file = tmpfile()) == NULL)
#                         ^
#/opt/wasi-sdk//share/wasi-sysroot//include/stdio.h:151:36: note: 'tmpfile' has been explicitly marked deprecated here
#FILE *tmpfile(void) __attribute__((__deprecated__("tmpfile is not defined on WASI")));
