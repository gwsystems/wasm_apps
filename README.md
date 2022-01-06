| App                       | WASI-SDK Builds                                    | Wasmtime Runs                                     | Native Builds | Native Runs | Functionally Correct         |
| ------------------------- | -------------------------------------------------- | ------------------------------------------------- | ------------- | ----------- | ---------------------------- |
| app_nn                    | fatal error: 'arm_math.h' file not found           | No                                                | No            | No          | Unknown                      |
| app_pid                   | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| app_tinycrypt             | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| app_v9                    | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| CMSIS_5_NN                | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| custom_binarytrees        | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| custom_function_pointers  | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| custom_libjpeg            | Error: tmpfile is not defined on WASI              | No                                                | Yes           | Yes         | Unknown                      |
| custom_matrix_multiply    | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| custom_memcmp             | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| custom_sqlite             | error: use of undeclared identifier 'fchmod'       | No                                                | Yes           | Yes         | Unknown                      |
| echo                      | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| empty                     | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| exit                      | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| fibonacci                 | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| gocr                      | Yes                                                | wasm trap: indirect call type mismatch            | Yes           | Yes         | Yes                          |
| mi_adpcm                  | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| mi_basic_math             | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_bitcount               | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Results Differ!     |
| mi_bitcount_cm            | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Results Differ!     |
| mi_blowfish               | Yes                                                | exit with invalid exit status outside of [0..126) | Yes           | Yes         | No                           |
| mi_crc                    | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_dijkstra               | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_dijkstra_cm            | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_fft                    | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Results Differ!     |
| mi_fft_cm                 | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Results Differ!     |
| mi_gsm                    | unknown import: `env::fchmod` has not been defined | No                                                | Yes           | Yes         | Unknown. Binary output       |
| mi_mandelbrot             | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Binary output       |
| mi_mandelbrot_cm          | Yes                                                | Yes                                               | Yes           | Yes         | Unknown. Binary output       |
| mi_patricia               | fatal error: 'sys/wait.h' file not found           | No                                                | Yes           | Yes         | Unknown                      |
| mi_patricia_cm            | fatal error: 'sys/wait.h' file not found           | No                                                | Yes           | Yes         | Unknown                      |
| mi_pgp                    | fatal error: 'termios.h' file not found            | No                                                | Yes           | Yes         | Error: Bad pass phrase       |
| mi_qsort                  | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_qsort_cm               | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_rsynth                 | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| mi_sha                    | Yes                                                | Yes                                               | Yes           | Yes         | Different. 32-bit vs 64-bit? |
| mi_stringsearch           | Yes                                                | Yes                                               | Yes           | Yes         | Yes                          |
| mi_susan                  | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_datamining_correlation | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_datamining_covariance  | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_gemm           | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_gemver         | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_gesummv        | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_symm           | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_syr2k          | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_syrk           | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_blas_trmm           | Yes                                                | Yes                                               | Yes           | Yes         | Unknown                      |
| pb_la_kernels_2mm         |
| pb_la_kernels_3mm         |
| pb_la_kernels_atax        |
| pb_la_kernels_bicg        |
| pb_la_kernels_doitgen     |
| pb_la_kernels_mvt         |
| pb_la_solvers_cholesky    |
| pb_la_solvers_durbin      |
| pb_la_solvers_gramschmidt |
| pb_la_solvers_lu          |
| pb_la_solvers_ludcmp      |
| pb_la_solvers_trisolv     |
| pb_medely_deriche         |
| pb_medely_floyd_warshall  |
| pb_medely_nussinov        |
| pb_stencils_adi           |
| pb_stencils_fdtd_2d       |
| pb_stencils_head_3d       |
| pb_stencils_jacobi_1d     |
| pb_stencils_jacobi_2d     |
| pb_stencils_seidel_2d     |
