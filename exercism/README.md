# Example WAT Code

Many of these modules assume "glue code" in the embedder that copies data to and from the linear memory, and thus cannot run on standalone WebAssembly runtimes as-is.

## Unable to Compile
- hello_world.wat - Requires Multi-Value Support
- resistor-color.wat - Requires support for `(start)` instruction
- reverse-string.wat - Requires Multi-Value Support
- two-fer.wat - Requires support for `(data)` instruction (passive data segment)
- circular-buffer.wat - Requires Multi-Value Support
- acronym.wat - Requires Multi-Value Support
- all-your-base.wat - Requires Multi-Value Support
- nucleotide-count.wat - Requires Multi-Value Support
- rna-transcription.wat - Requires Multi-Value Support
- raindrops.wat - Requires support for `(data)` instruction (passive data segment)
- pangram.wat - Requires support for `(memory.fill)`

Source: [Exercism WebAssembly Track](https://exercism.org/tracks/wasm)
