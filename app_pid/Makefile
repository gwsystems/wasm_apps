WASMCC=${WASI_SDK_PATH}/bin/clang --sysroot=${WASI_SDK_PATH}/share/wasi-sysroot/
CC = clang
INCLUDE=-I.
OPTFLAGS= -O3 -flto -std=c++11 -Wall
WASMLINKFLAGS=-Wl,-z,stack-size=524288,--allow-undefined,--threads=1
WASMCFLAGS=${WASMLINKFLAGS} ${OPTFLAGS}

bin/app_pid.wasm: *.cpp
	@${WASMCC} ${WASMCFLAGS} ${OPTFLAGS} ${INCLUDE} ${DEFINES} $^ -o $@

run: bin/app_pid.wasm
	wasmtime bin/app_pid.wasm

clean:
	rm -rf bin/*
