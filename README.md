| App                       | Native Builds | Native Runs | WASI-SDK Builds                              | Wasmtime Runs                                      | Functionally Correct         |
| ------------------------- | ------------- | ----------- | -------------------------------------------- | -------------------------------------------------- | ---------------------------- |
| app_nn                    | No            | No          | fatal error: 'arm_math.h' file not found     | No                                                 | Unknown                      |
| app_pid                   | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| app_tinycrypt             | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| app_v9                    | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| CMSIS_5_NN                | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| custom_binarytrees        | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| custom_function_pointers  | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| custom_libjpeg            | Yes           | Yes         | Yes                                          | Error: tmpfile is not defined on WASI              | Unknown                      |
| custom_matrix_multiply    | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| custom_memcmp             | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| custom_sqlite             | Yes           | Yes         | error: use of undeclared identifier 'fchmod' | No                                                 | Unknown                      |
| echo                      | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| empty                     | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| exit                      | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| fibonacci                 | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| gocr                      | Yes           | Yes         | Yes                                          | wasm trap: indirect call type mismatch             | Yes                          |
| mi_adpcm                  | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| mi_basic_math             | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_bitcount               | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Results Differ!     |
| mi_bitcount_cm            | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Results Differ!     |
| mi_blowfish               | Yes           | Yes         | Yes                                          | exit with invalid exit status outside of [0..126)  | No                           |
| mi_crc                    | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_dijkstra               | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_dijkstra_cm            | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_fft                    | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Results Differ!     |
| mi_fft_cm                 | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Results Differ!     |
| mi_gsm                    | Yes           | Yes         | Yes                                          | unknown import: `env::fchmod` has not been defined | Unknown. Binary output       |
| mi_mandelbrot             | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Binary output       |
| mi_mandelbrot_cm          | Yes           | Yes         | Yes                                          | Yes                                                | Unknown. Binary output       |
| mi_patricia               | Yes           | Yes         | fatal error: 'sys/wait.h' file not found     | No                                                 | Unknown                      |
| mi_patricia_cm            | Yes           | Yes         | fatal error: 'sys/wait.h' file not found     | No                                                 | Unknown                      |
| mi_pgp                    | Yes           | Yes         | fatal error: 'termios.h' file not found      | No                                                 | Error: Bad pass phrase       |
| mi_qsort                  | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_qsort_cm               | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_rsynth                 | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| mi_sha                    | Yes           | Yes         | Yes                                          | Yes                                                | Different. 32-bit vs 64-bit? |
| mi_stringsearch           | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| mi_susan                  | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_datamining_correlation | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_datamining_covariance  | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_gemm           | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_gemver         | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_gesummv        | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_symm           | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_syr2k          | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_syrk           | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_blas_trmm           | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_kernels_2mm         | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_kernels_3mm         | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_kernels_atax        | Yes           | Yes         | Yes                                          | Yes                                                | Yes                          |
| pb_la_kernels_bicg        | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_kernels_doitgen     | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_kernels_mvt         | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_cholesky    | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_durbin      | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_gramschmidt | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_lu          | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_ludcmp      | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_la_solvers_trisolv     | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_medely_deriche         | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_medely_floyd_warshall  | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_medely_nussinov        | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_adi           | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_fdtd_2d       | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_heat_3d       | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_jacobi_1d     | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_jacobi_2d     | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |
| pb_stencils_seidel_2d     | Yes           | Yes         | Yes                                          | Yes                                                | Unknown                      |

References:

- The applications prefixed with `pb_` are from [the PolyBench/C benchmark](http://web.cse.ohio-state.edu/~pouchet.2/software/polybench/). It is the benchmark used in [the original WebAssembly paper](https://dl.acm.org/doi/10.1145/3062341.3062363) and includes common matrix operations and statistical operations.
- CMSIS-NN V1.0.0 (nn)- A neural network library designed for microcontrollers that is used to perform image categorization. [View on GitHub](https://github.com/ARM-software/CMSIS_5/tree/develop/CMSIS/NN)
- Arduino PID library (pid) - A typical Proportional, Integral, Derivative controller used for physical control. [Arduino Docs](https://playground.arduino.cc/Code/PIDLibrary/)
- TinyEKF Kalman filter (kalman)- Used for sensor fusion and state estimation. [View on GitHub](https://github.com/simondlevy/TinyEKF).
- TinyCrypt (crypto) - A small library of crypto primitives. [View on GitHub](https://github.com/intel/tinycrypt)
