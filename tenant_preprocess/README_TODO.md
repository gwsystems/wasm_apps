# cmu-sod

## Assumptions
- WASI-SDK is installed and the environment variable `WASI_SDK_PATH` is set to the installation path
- wasmtime is installed and in `PATH`

## To Run
- `make run` builds the program as a filter and writes the resulting image to ./out/native.png
- `make run-wasm` builds the program as a wasm filter and writes the resulting image to ./out/wasm.png