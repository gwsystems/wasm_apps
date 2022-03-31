#!/bin/bash

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Hyperfine
cargo install hyperfine

# Install WABT
# sudo apt-get install wabt

# Install Wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash

# Install wabt
# APT does not have latest for 20 LTS, only 21 and 22 beta
wget https://github.com/WebAssembly/wabt/releases/download/1.0.27/wabt-1.0.27-ubuntu.tar.gz
tar -xvf wabt-1.0.27-ubuntu.tar.gz
sudo mv wabt-1.0.27/bin/* /usr/bin/
sudo mv wabt-1.0.27/include/* /usr/include/
sudo mv wabt-1.0.27/lib/* /usr/lib/
rm -f wabt-1.0.27-ubuntu.tar.gz
rm -rf wabt-1.0.27

# Install wasm3
# The prebuilt binary triggers an invalid instruction signal
git clone https://github.com/wasm3/wasm3.git
pushd wasm3
git checkout v0.5.0
mkdir -p build
pushd build
cmake ..
make -j8
sudo mv wasm3 /usr/bin/
popd
popd
rm -rf wasm3

git clone https://github.com/bytecodealliance/wasm-micro-runtime.git
pushd wasm-micro-runtime
git checkout WAMR-01-18-2022
pushd wamr-compiler
./build_llvm.sh
mkdir build
pushd build
cmake ..
make -j8
sudo mv wamrc /usr/bin/
popd
popd
pushd product-mini/platforms/linux/
mkdir build
pushd build
cmake ..
make -j8
sudo mv iwasm /usr/bin/
popd
popd
popd
