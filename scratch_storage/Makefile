include ../common.mk

.PHONY: all
all: \
	scratch_storage_get.wasm \
	scratch_storage_set.wasm \

.PHONY: clean
clean:
	@rm -f scratch_storage_set.wasm scratch_storage_set.wat scratch_storage_get.wasm scratch_storage_get.wat

scratch_storage_set.wasm: scratch_storage_set.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@

scratch_storage_get.wasm: scratch_storage_get.c
	@${WASMCC} ${WASMCFLAGS} ${WASMLDFLAGS} $^ -o $@
