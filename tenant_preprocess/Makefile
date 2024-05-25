include ../common.mk

WASMCFLAGS+= -D_WASI_EMULATED_MMAN -DWASM  
WASMLDFLAGS+= -Wl,-z,stack-size=64000 -Wl,--export=malloc -Wl,--export=free -lwasi-emulated-mman

%.wasm: %.c
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@


get_jpeg_resolution: 
	${CC} ${CFLAGS} -o $@ get_jpeg_resolution.c 

get_jpeg_resolution.wasm: 
	${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} -o $@ get_jpeg_resolution.c 

.PHONY: run
run: get_jpeg_resolution
	./get_jpeg_resolution < ./pic_512x1024.jpg

.PHONY: run-wasm
run-wasm: get_jpeg_resolution.wasm
	wasmtime ./get_jpeg_resolution.wasm < ./pic_512x1024.jpg

.PHONY: clean
clean:
	rm -f get_jpeg_resolution get_jpeg_resolution.wasm
