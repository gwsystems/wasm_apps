#!/bin/bash

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Hyperfine
cargo install hyperfine

# Install WABT
sudo apt-get install wabt

# Install Wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash

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
