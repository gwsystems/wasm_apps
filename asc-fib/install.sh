#!/bin/bash
# Sets up Node.js tools

# Install N, a node version manager
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
bash n lts
npm install -g n
rm n
# shellcheck source=/dev/null
source ~/.bashrc

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
# shellcheck source=/dev/null
source ~/.bashrc

# Now the following commands will build the wasm
# pnpm install
# pnpm asbuild
