| App                       | WASI-SDK Builds                              | Wasmtime Runs                          | Native Builds | Native Runs | Functionally Correct |
| ------------------------- | -------------------------------------------- | -------------------------------------- | ------------- | ----------- | -------------------- |
| app_nn                    | fatal error: 'arm_math.h' file not found     | No                                     | No            | No          | Unknown              |
| app_pid                   | Yes                                          | Yes                                    | Yes           | Yes         | Unknown              |
| app_tinycrypt             | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| app_v9                    | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| CMSIS_5_NN                | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| custom_binarytrees        | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| custom_function_pointers  | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| custom_libjpeg            | Error: tmpfile is not defined on WASI        | No                                     | Yes           | Yes         | Unknown              |
| custom_matrix_multiply    | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| custom_memcmp             | Yes                                          | Yes                                    | Yes           | Yes         | Unknown              |
| custom_sqlite             | error: use of undeclared identifier 'fchmod' | No                                     | Yes           | Yes         | Unknown              |
| echo                      | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| empty                     | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| exit                      | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| fibonacci                 | Yes                                          | Yes                                    | Yes           | Yes         | Yes                  |
| gocr                      | Yes                                          | wasm trap: indirect call type mismatch | Yes           | Yes         | Yes                  |
| mi_adpcm                  | Yes                                          | Yes                                    | Yes           | Yes         | Unknown              | 
| mi_basic_math             |
| mi_bitcount               |
| mi_bitcount_cm            |
| mi_blwofist               |
| mi_crc                    |
| mi_dijkstra               |
| mi_dijkstra_cm            |
| mi_fft                    |
| mi_fft_cm                 |
| mi_gsm                    |
| mi_mandelbrot             |
| mi_mandelbrot_cm          |
| mi_patricia               |
| mi_patricia_cm            |
| mi_pgp                    |
| mi_qsort                  |
| mi_qsort_cm               |
| mi_rsynth                 |
| mi_sha                    |
| mi_stringsearch           |
| mi_susan                  |
| pb_datamining_correlation |
| pb_datamining_covariance  |
| pb_la_blas_gemm           |
| pb_la_blas_gemver         |
| pb_la_blas_gesummv        |
| pb_la_blas_symm           |
| pb_la_blas_syr2k          |
| pb_la_blas_syrk           |
| pb_la_blas_trmm           |
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
