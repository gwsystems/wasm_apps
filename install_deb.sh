#!/bin/bash

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Hyperfine
cargo install hyperfine

# Install WABT
sudo apt-get install wabt

# Install Wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash
