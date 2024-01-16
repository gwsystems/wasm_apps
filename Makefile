.PHONY: all
all: \
	all.out \
	all.wasm \

.PHONY: all.out
all.out: \
	dist/app_pid.out \
	dist/app_tinycrypt.out \
	dist/app_v9.out \
	dist/cifar10.out \
	dist/custom_binarytrees.out \
	dist/custom_function_pointers.out \
	dist/custom_libjpeg.out \
	dist/custom_matrix_multiply.out \
	dist/custom_memcmp.out \
	dist/custom_sqlite.out \
	dist/echo.out \
	dist/empty.out \
	dist/exit.out \
	dist/fibonacci.out \
	dist/gocr.out \
	dist/mi_adpcm.out \
	dist/mi_basic_math.out \
	dist/mi_bitcount.out \
	dist/mi_bitcount_cm.out \
	dist/mi_blowfish.out \
	dist/mi_crc.out \
	dist/mi_dijkstra.out \
	dist/mi_dijkstra_cm.out \
	dist/mi_fft.out \
	dist/mi_gsm.out \
	dist/mi_mandelbrot.out \
	dist/mi_mandelbrot_cm.out \
	dist/mi_patricia.out \
	dist/mi_patricia_cm.out \
	dist/mi_pgp.out \
	dist/mi_qsort.out \
	dist/mi_qsort_cm.out \
	dist/mi_rsynth.out \
	dist/mi_sha.out \
	dist/mi_stringsearch.out \
	dist/mi_susan.out \
	dist/pb_datamining_correlation.out \
	dist/pb_datamining_covariance.out \
	dist/pb_la_blas_gemm.out \
	dist/pb_la_blas_gemver.out \
	dist/pb_la_blas_gesummv.out \
	dist/pb_la_blas_symm.out \
	dist/pb_la_blas_syr2k.out \
	dist/pb_la_blas_syrk.out \
	dist/pb_la_blas_trmm.out \
	dist/pb_la_kernels_2mm.out \
	dist/pb_la_kernels_3mm.out \
	dist/pb_la_kernels_atax.out \
	dist/pb_la_kernels_bicg.out \
	dist/pb_la_kernels_doitgen.out \
	dist/pb_la_kernels_mvt.out \
	dist/pb_la_solvers_cholesky.out \
	dist/pb_la_solvers_durbin.out \
	dist/pb_la_solvers_gramschmidt.out \
	dist/pb_la_solvers_lu.out \
	dist/pb_la_solvers_ludcmp.out \
	dist/pb_la_solvers_trisolv.out \
	dist/pb_medely_deriche.out \
	dist/pb_medely_floyd_warshall.out \
	dist/pb_medely_nussinov.out \
	dist/pb_stencils_adi.out \
	dist/pb_stencils_fdtd_2d.out \
	dist/pb_stencils_heat_3d.out \
	dist/pb_stencils_jacobi_1d.out \
	dist/pb_stencils_jacobi_2d.out \
	dist/pb_stencils_seidel_2d.out \
	dist/resize_image.out \
	dist/trap_divzero.out \
	dist/stack_overflow.out \
	dist/license_plate_detection.out \
	dist/cnn_face_detection.out \
	dist/gps_ekf.out \
	dist/depth_to_xyz.out \
	# dist/app_nn.out \


.PHONY: all.wasm
all.wasm: \
	dist/app_pid.wasm \
	dist/app_tinycrypt.wasm \
	dist/app_v9.wasm \
	dist/cifar10.wasm \
	dist/custom_binarytrees.wasm \
	dist/custom_function_pointers.wasm \
	dist/custom_libjpeg.wasm \
	dist/custom_matrix_multiply.wasm \
	dist/custom_memcmp.wasm \
	dist/echo.wasm \
	dist/empty.wasm \
	dist/exit.wasm \
	dist/fibonacci.wasm \
	dist/hash.wasm \
	dist/gocr.wasm \
	dist/mi_adpcm.wasm \
	dist/mi_basic_math.wasm \
	dist/mi_bitcount.wasm \
	dist/mi_bitcount_cm.wasm \
	dist/mi_blowfish.wasm \
	dist/mi_crc.wasm \
	dist/mi_dijkstra.wasm \
	dist/mi_dijkstra_cm.wasm \
	dist/mi_fft.wasm \
	dist/mi_gsm.wasm \
	dist/mi_mandelbrot.wasm \
	dist/mi_mandelbrot_cm.wasm \
	dist/mi_qsort.wasm \
	dist/mi_qsort_cm.wasm \
	dist/mi_rsynth.wasm \
	dist/mi_sha.wasm \
	dist/mi_stringsearch.wasm \
	dist/mi_susan.wasm \
	dist/pb_datamining_correlation.wasm \
	dist/pb_datamining_covariance.wasm \
	dist/pb_la_blas_gemm.wasm \
	dist/pb_la_blas_gemver.wasm \
	dist/pb_la_blas_gesummv.wasm \
	dist/pb_la_blas_symm.wasm \
	dist/pb_la_blas_syr2k.wasm \
	dist/pb_la_blas_syrk.wasm \
	dist/pb_la_blas_trmm.wasm \
	dist/pb_la_kernels_2mm.wasm \
	dist/pb_la_kernels_3mm.wasm \
	dist/pb_la_kernels_atax.wasm \
	dist/pb_la_kernels_bicg.wasm \
	dist/pb_la_kernels_doitgen.wasm \
	dist/pb_la_kernels_mvt.wasm \
	dist/pb_la_solvers_cholesky.wasm \
	dist/pb_la_solvers_durbin.wasm \
	dist/pb_la_solvers_gramschmidt.wasm \
	dist/pb_la_solvers_lu.wasm \
	dist/pb_la_solvers_ludcmp.wasm \
	dist/pb_la_solvers_trisolv.wasm \
	dist/pb_medely_deriche.wasm \
	dist/pb_medely_floyd_warshall.wasm \
	dist/pb_medely_nussinov.wasm \
	dist/pb_stencils_adi.wasm \
	dist/pb_stencils_fdtd_2d.wasm \
	dist/pb_stencils_heat_3d.wasm \
	dist/pb_stencils_jacobi_1d.wasm \
	dist/pb_stencils_jacobi_2d.wasm \
	dist/pb_stencils_seidel_2d.wasm \
	dist/resize_image.wasm \
	dist/license_plate_detection.wasm \
	dist/cnn_face_detection.wasm \
	dist/gps_ekf.wasm \
	dist/trap_divzero.wasm \
	dist/stack_overflow.wasm \
	dist/depth_to_xyz.wasm \
	# dist/app_nn.wasm \
	# dist/custom_sqlite.wasm \
	# dist/mi_patricia.wasm \
	# dist/mi_patricia_cm.wasm \
	# dist/mi_pgp.wasm \

dist/wasm_apps.tar.gz: all.wasm
	tar -czvf dist/wasm_apps.tar.gz dist/*.wasm

.PHONY: pack 
pack: dist/wasm_apps.tar.gz

.PHONY: clean
clean:
	rm -rf dist
	make -C app_pid clean
	make -C app_tinycrypt clean
	make -C app_v9 clean
	make -C CMSIS_5_NN clean
	make -C custom_binarytrees clean
	make -C custom_function_pointers clean
	make -C custom_libjpeg clean
	make -C custom_matrix_multiply clean
	make -C custom_memcmp clean
	make -C custom_sqlite clean
	make -C echo clean
	make -C empty clean
	make -C exercism clean
	make -C exit clean
	make -C fibonacci clean
	make -C hash clean
	make -C gocr -f wasm.mk clean
	make -C html clean
	make -C mi_adpcm clean
	make -C mi_basic_math clean
	make -C mi_bitcount clean
	make -C mi_bitcount_cm clean
	make -C mi_blowfish clean
	make -C mi_crc clean
	make -C mi_dijkstra clean
	make -C mi_dijkstra_cm clean
	make -C mi_fft clean
	make -C mi_gsm clean
	make -C mi_mandelbrot clean
	make -C mi_mandelbrot_cm clean
	make -C mi_patricia clean
	make -C mi_patricia_cm clean
	make -C mi_pgp clean
	make -C mi_qsort clean
	make -C mi_qsort_cm clean
	make -C mi_rsynth clean
	make -C mi_sha clean
	make -C mi_stringsearch clean
	make -C mi_susan clean
	make -C pb_datamining_correlation clean
	make -C pb_datamining_covariance clean
	make -C pb_la_blas_gemm clean
	make -C pb_la_blas_gemver clean
	make -C pb_la_blas_gesummv clean
	make -C pb_la_blas_symm clean
	make -C pb_la_blas_syr2k clean
	make -C pb_la_blas_syrk clean
	make -C pb_la_blas_trmm clean
	make -C pb_la_kernels_2mm clean
	make -C pb_la_kernels_3mm clean
	make -C pb_la_kernels_atax clean
	make -C pb_la_kernels_bicg clean
	make -C pb_la_kernels_doitgen clean
	make -C pb_la_kernels_mvt clean
	make -C pb_la_solvers_cholesky clean
	make -C pb_la_solvers_durbin clean
	make -C pb_la_solvers_gramschmidt clean
	make -C pb_la_solvers_lu clean
	make -C pb_la_solvers_ludcmp clean
	make -C pb_la_solvers_trisolv clean
	make -C pb_medely_deriche clean
	make -C pb_medely_floyd_warshall clean
	make -C pb_medely_nussinov clean
	make -C pb_stencils_adi clean
	make -C pb_stencils_fdtd_2d clean
	make -C pb_stencils_heat_3d clean
	make -C pb_stencils_jacobi_1d clean
	make -C pb_stencils_jacobi_2d clean
	make -C pb_stencils_seidel_2d clean
	make -C stack_overflow clean
	make -C start clean
	make -C sod clean
	make -C TinyEKF -f wasm.mk clean
	make -C traps clean

bench:
	mkdir -p bench

clean.bench:
	rm -rf bench

BENCHMARKS= \
	bench/app_pid.csv \
	bench/app_tinycrypt.csv \
	bench/app_v9.csv \
	bench/CMSIS_5_NN.csv \
	bench/custom_binarytrees.csv \
	bench/custom_function_pointers.csv \
	bench/custom_matrix_multiply.csv \
	bench/custom_memcmp.csv \
	bench/echo.csv \
	bench/empty.csv \
	bench/exit.csv \
	bench/fibonacci.csv \
	bench/gocr.csv \
	bench/mi_adpcm.csv \
	bench/mi_basic_math.csv \
	bench/mi_bitcount.csv \
	bench/mi_bitcount_cm.csv \
	bench/mi_crc.csv \
	bench/mi_dijkstra.csv \
	bench/mi_dijkstra_cm.csv \
	bench/mi_fft.csv \
	bench/mi_mandelbrot.csv \
	bench/mi_mandelbrot_cm.csv \
	bench/mi_qsort.csv \
	bench/mi_qsort_cm.csv \
	bench/mi_rsynth.csv \
	bench/mi_sha.csv \
	bench/mi_stringsearch.csv \
	bench/mi_susan.csv \
	bench/pb_datamining_correlation.csv \
	bench/pb_datamining_covariance.csv \
	bench/pb_la_blas_gemm.csv \
	bench/pb_la_blas_gemver.csv \
	bench/pb_la_blas_gesummv.csv \
	bench/pb_la_blas_symm.csv \
	bench/pb_la_blas_syr2k.csv \
	bench/pb_la_blas_syrk.csv \
	bench/pb_la_blas_trmm.csv \
	bench/pb_la_kernels_2mm.csv \
	bench/pb_la_kernels_3mm.csv \
	bench/pb_la_kernels_atax.csv \
	bench/pb_la_kernels_bicg.csv \
	bench/pb_la_kernels_doitgen.csv \
	bench/pb_la_kernels_mvt.csv \
	bench/pb_la_solvers_cholesky.csv \
	bench/pb_la_solvers_durbin.csv \
	bench/pb_la_solvers_gramschmidt.csv \
	bench/pb_la_solvers_lu.csv \
	bench/pb_la_solvers_ludcmp.csv \
	bench/pb_la_solvers_trisolv.csv \
	bench/pb_medely_deriche.csv \
	bench/pb_medely_floyd_warshall.csv \
	bench/pb_medely_nussinov.csv \
	bench/pb_stencils_adi.csv \
	bench/pb_stencils_fdtd_2d.csv \
	bench/pb_stencils_heat_3d.csv \
	bench/pb_stencils_jacobi_1d.csv \
	bench/pb_stencils_jacobi_2d.csv \
	bench/license_plate_detection.csv \
	bench/cnn_face_detection.csv \
	bench/resize_image.csv \
	bench/traps.csv

bench/bench.csv: ${BENCHMARKS}
	cat $^ > bench/bench.csv

bench/TinyEKF.csv: bench
	make -C TinyEKF -f wasm.mk bench.csv
	cp TinyEKF/bench.csv bench/TinyEKF.csv

bench/license_plate_detection.csv: bench
	make -C sod license_plate_detection.bench.csv
	cp sod/license_plate_detection.bench.csv $@

bench/cnn_face_detection.csv: bench
	make -C sod cnn_face_detection.bench.csv
	cp sod/cnn_face_detection.bench.csv $@

bench/resize_image.csv: bench
	make -C sod resize_image.bench.csv
	cp sod/resize_image.bench.csv $@

bench/%.csv: bench
	make -C $* bench.csv
	cp $*/bench.csv bench/$*.csv

dist:
	mkdir -p dist

# TODO: app_nn

dist/app_pid.out: dist
	make -C app_pid bin/app_pid.out
	cp ./app_pid/bin/app_pid.out ./dist/app_pid.out

dist/app_pid.wasm: dist
	make -C app_pid bin/app_pid.wasm
	cp ./app_pid/bin/app_pid.wasm ./dist/app_pid.wasm

dist/app_tinycrypt.out: dist
	make -C app_tinycrypt bin/app_tinycrypt.out
	cp ./app_tinycrypt/bin/app_tinycrypt.out ./dist/app_tinycrypt.out

dist/app_tinycrypt.wasm: dist
	make -C app_tinycrypt bin/app_tinycrypt.wasm
	cp ./app_tinycrypt/bin/app_tinycrypt.wasm ./dist/app_tinycrypt.wasm

dist/app_v9.out: dist
	make -C app_v9 bin/app_v9.out
	cp ./app_v9/bin/app_v9.out ./dist/app_v9.out

dist/app_v9.wasm: dist
	make -C app_v9 bin/app_v9.wasm
	cp ./app_v9/bin/app_v9.wasm ./dist/app_v9.wasm

dist/asc-fib.wasm: dist
	cd ./asc-fib && pnpm asbuild
	cp ./asc-fib/optimized.wasm ./dist/asc-fib.wasm

dist/custom_binarytrees.out: dist
	make -C custom_binarytrees bin/custom_binarytrees.out
	cp ./custom_binarytrees/bin/custom_binarytrees.out ./dist/custom_binarytrees.out

dist/custom_binarytrees.wasm: dist
	make -C custom_binarytrees bin/custom_binarytrees.wasm
	cp ./custom_binarytrees/bin/custom_binarytrees.wasm ./dist/custom_binarytrees.wasm

dist/custom_function_pointers.out: dist
	make -C custom_function_pointers bin/custom_function_pointers.out
	cp ./custom_function_pointers/bin/custom_function_pointers.out ./dist/custom_function_pointers.out

dist/custom_function_pointers.wasm: dist
	make -C custom_function_pointers bin/custom_function_pointers.wasm
	cp ./custom_function_pointers/bin/custom_function_pointers.wasm ./dist/custom_function_pointers.wasm

dist/custom_libjpeg.out: dist
	make -C custom_libjpeg bin/custom_libjpeg.out
	cp ./custom_libjpeg/bin/custom_libjpeg.out ./dist/custom_libjpeg.out

dist/custom_libjpeg.wasm: dist
	make -C custom_libjpeg bin/custom_libjpeg.wasm
	cp ./custom_libjpeg/bin/custom_libjpeg.wasm ./dist/custom_libjpeg.wasm

dist/custom_matrix_multiply.out: dist
	make -C custom_matrix_multiply bin/custom_matrix_multiply.out
	cp ./custom_matrix_multiply/bin/custom_matrix_multiply.out ./dist/custom_matrix_multiply.out

dist/custom_matrix_multiply.wasm: dist
	make -C custom_matrix_multiply bin/custom_matrix_multiply.wasm
	cp ./custom_matrix_multiply/bin/custom_matrix_multiply.wasm ./dist/custom_matrix_multiply.wasm

dist/custom_memcmp.out: dist
	make -C custom_memcmp bin/custom_memcmp.out
	cp ./custom_memcmp/bin/custom_memcmp.out ./dist/custom_memcmp.out

dist/custom_memcmp.wasm: dist
	make -C custom_memcmp bin/custom_memcmp.wasm
	cp ./custom_memcmp/bin/custom_memcmp.wasm ./dist/custom_memcmp.wasm

dist/custom_sqlite.out: dist
	make -C custom_sqlite bin/custom_sqlite.out
	cp ./custom_sqlite/bin/custom_sqlite.out ./dist/custom_sqlite.out

# error: use of undeclared identifier 'fchmod'
# dist/custom_sqlite.wasm: dist
# 	make -C custom_sqlite bin/custom_sqlite.wasm
# 	cp ./custom_sqlite/bin/custom_sqlite.wasm ./dist/custom_sqlite.wasm

dist/cifar10.out: dist
	make -C CMSIS_5_NN cifar10.out
	cp ./CMSIS_5_NN/cifar10.out ./dist/cifar10.out

dist/cifar10.wasm: dist
	make -C CMSIS_5_NN cifar10.wasm
	cp ./CMSIS_5_NN/cifar10.wasm ./dist/cifar10.wasm

dist/depth_to_xyz.wasm: dist
	make -C cmu-sod out/depth_to_xyz.wasm
	cp ./cmu-sod/out/depth_to_xyz.wasm ./dist/depth_to_xyz.wasm

dist/depth_to_xyz.out: dist
	make -C cmu-sod out/depth_to_xyz
	cp ./cmu-sod/out/depth_to_xyz ./dist/depth_to_xyz.out

dist/echo.out: dist
	make -C echo echo.out
	cp ./echo/echo.out ./dist/echo.out

dist/echo.wasm: dist
	make -C echo echo.wasm
	cp ./echo/echo.wasm ./dist/echo.wasm

dist/empty.out: dist
	make -C empty empty.out
	cp ./empty/empty.out ./dist/empty.out

dist/empty.wasm: dist
	make -C empty empty.wasm
	cp ./empty/empty.wasm ./dist/empty.wasm

dist/exit.out: dist
	make -C exit exit.out
	cp ./exit/exit.out ./dist/exit.out

dist/exit.wasm: dist
	make -C exit exit.wasm
	cp ./exit/exit.wasm ./dist/exit.wasm

dist/fibonacci.out: dist
	make -C fibonacci fibonacci.out
	cp ./fibonacci/fibonacci.out ./dist/fibonacci.out

dist/fibonacci.wasm: dist
	make -C fibonacci fibonacci.wasm
	cp ./fibonacci/fibonacci.wasm ./dist/fibonacci.wasm

dist/hash.wasm: dist
	make -C hash hash.wasm
	cp ./hash/hash.wasm ./dist/hash.wasm

dist/gocr.out: dist
	make -C gocr -f wasm.mk gocr.out
	cp ./gocr/gocr.out ./dist/gocr.out

dist/gocr.wasm: dist
	make -C gocr -f wasm.mk gocr.wasm
	cp ./gocr/gocr.wasm ./dist/gocr.wasm

dist/mi_adpcm.out: dist
	make -C mi_adpcm bin/mi_adpcm.out
	cp ./mi_adpcm/bin/mi_adpcm.out ./dist/mi_adpcm.out

dist/mi_adpcm.wasm: dist
	make -C mi_adpcm bin/mi_adpcm.wasm
	cp ./mi_adpcm/bin/mi_adpcm.wasm ./dist/mi_adpcm.wasm

dist/mi_basic_math.out: dist
	make -C mi_basic_math bin/mi_basic_math.out
	cp ./mi_basic_math/bin/mi_basic_math.out ./dist/mi_basic_math.out

dist/mi_basic_math.wasm: dist
	make -C mi_basic_math bin/mi_basic_math.wasm
	cp ./mi_basic_math/bin/mi_basic_math.wasm ./dist/mi_basic_math.wasm

dist/mi_bitcount.out: dist
	make -C mi_bitcount bin/mi_bitcount.out
	cp ./mi_bitcount/bin/mi_bitcount.out ./dist/mi_bitcount.out

dist/mi_bitcount.wasm: dist
	make -C mi_bitcount bin/mi_bitcount.wasm
	cp ./mi_bitcount/bin/mi_bitcount.wasm ./dist/mi_bitcount.wasm

dist/mi_bitcount_cm.out: dist
	make -C mi_bitcount_cm bin/mi_bitcount_cm.out
	cp ./mi_bitcount_cm/bin/mi_bitcount_cm.out ./dist/mi_bitcount_cm.out

dist/mi_bitcount_cm.wasm: dist
	make -C mi_bitcount_cm bin/mi_bitcount_cm.wasm
	cp ./mi_bitcount_cm/bin/mi_bitcount_cm.wasm ./dist/mi_bitcount_cm.wasm

dist/mi_blowfish.out: dist
	make -C mi_blowfish bin/mi_blowfish.out
	cp ./mi_blowfish/bin/mi_blowfish.out ./dist/mi_blowfish.out

dist/mi_blowfish.wasm: dist
	make -C mi_blowfish bin/mi_blowfish.wasm
	cp ./mi_blowfish/bin/mi_blowfish.wasm ./dist/mi_blowfish.wasm

dist/mi_crc.out: dist
	make -C mi_crc bin/mi_crc.out
	cp ./mi_crc/bin/mi_crc.out ./dist/mi_crc.out

dist/mi_crc.wasm: dist
	make -C mi_crc bin/mi_crc.wasm
	cp ./mi_crc/bin/mi_crc.wasm ./dist/mi_crc.wasm

dist/mi_dijkstra.out: dist
	make -C mi_dijkstra bin/mi_dijkstra.out
	cp ./mi_dijkstra/bin/mi_dijkstra.out ./dist/mi_dijkstra.out

dist/mi_dijkstra.wasm: dist
	make -C mi_dijkstra bin/mi_dijkstra.wasm
	cp ./mi_dijkstra/bin/mi_dijkstra.wasm ./dist/mi_dijkstra.wasm

dist/mi_dijkstra_cm.out: dist
	make -C mi_dijkstra_cm bin/mi_dijkstra_cm.out
	cp ./mi_dijkstra_cm/bin/mi_dijkstra_cm.out ./dist/mi_dijkstra_cm.out

dist/mi_dijkstra_cm.wasm: dist
	make -C mi_dijkstra_cm bin/mi_dijkstra_cm.wasm
	cp ./mi_dijkstra_cm/bin/mi_dijkstra_cm.wasm ./dist/mi_dijkstra_cm.wasm

dist/mi_fft.out: dist
	make -C mi_fft bin/mi_fft.out
	cp ./mi_fft/bin/mi_fft.out ./dist/mi_fft.out

dist/mi_fft.wasm: dist
	make -C mi_fft bin/mi_fft.wasm
	cp ./mi_fft/bin/mi_fft.wasm ./dist/mi_fft.wasm

dist/mi_fft_cm.out: dist
	make -C mi_fft_cm bin/mi_fft_cm.out
	cp ./mi_fft_cm/bin/mi_fft_cm.out ./dist/mi_fft_cm.out

dist/mi_fft_cm.wasm: dist
	make -C mi_fft_cm bin/mi_fft_cm.wasm
	cp ./mi_fft_cm/bin/mi_fft_cm.wasm ./dist/mi_fft_cm.wasm

dist/mi_gsm.out: dist
	make -C mi_gsm bin/mi_gsm.out
	cp ./mi_gsm/bin/mi_gsm.out ./dist/mi_gsm.out

dist/mi_gsm.wasm: dist
	make -C mi_gsm bin/mi_gsm.wasm
	cp ./mi_gsm/bin/mi_gsm.wasm ./dist/mi_gsm.wasm

dist/mi_mandelbrot.out: dist
	make -C mi_mandelbrot bin/mi_mandelbrot.out
	cp ./mi_mandelbrot/bin/mi_mandelbrot.out ./dist/mi_mandelbrot.out

dist/mi_mandelbrot.wasm: dist
	make -C mi_mandelbrot bin/mi_mandelbrot.wasm
	cp ./mi_mandelbrot/bin/mi_mandelbrot.wasm ./dist/mi_mandelbrot.wasm

dist/mi_mandelbrot_cm.out: dist
	make -C mi_mandelbrot_cm bin/mi_mandelbrot_cm.out
	cp ./mi_mandelbrot_cm/bin/mi_mandelbrot_cm.out ./dist/mi_mandelbrot_cm.out

dist/mi_mandelbrot_cm.wasm: dist
	make -C mi_mandelbrot_cm bin/mi_mandelbrot_cm.wasm
	cp ./mi_mandelbrot_cm/bin/mi_mandelbrot_cm.wasm ./dist/mi_mandelbrot_cm.wasm

dist/mi_patricia.out: dist
	make -C mi_patricia bin/mi_patricia.out
	cp ./mi_patricia/bin/mi_patricia.out ./dist/mi_patricia.out

# fatal error: 'sys/wait.h' file not found 
# dist/mi_patricia.wasm: dist
# 	make -C mi_patricia bin/mi_patricia.wasm
# 	cp ./mi_patricia/bin/mi_patricia.wasm ./dist/mi_patricia.wasm

dist/mi_patricia_cm.out: dist
	make -C mi_patricia_cm bin/mi_patricia_cm.out
	cp ./mi_patricia_cm/bin/mi_patricia_cm.out ./dist/mi_patricia_cm.out

dist/mi_patricia_cm.wasm: dist
	make -C mi_patricia_cm bin/mi_patricia_cm.wasm
	cp ./mi_patricia_cm/bin/mi_patricia_cm.wasm ./dist/mi_patricia_cm.wasm

dist/mi_pgp.out: dist
	make -C mi_pgp bin/mi_pgp.out
	cp ./mi_pgp/bin/mi_pgp.out ./dist/mi_pgp.out

dist/mi_pgp.wasm: dist
	make -C mi_pgp bin/mi_pgp.wasm
	cp ./mi_pgp/bin/mi_pgp.wasm ./dist/mi_pgp.wasm

dist/mi_qsort.out: dist
	make -C mi_qsort bin/mi_qsort.out
	cp ./mi_qsort/bin/mi_qsort.out ./dist/mi_qsort.out

dist/mi_qsort.wasm: dist
	make -C mi_qsort bin/mi_qsort.wasm
	cp ./mi_qsort/bin/mi_qsort.wasm ./dist/mi_qsort.wasm

dist/mi_qsort_cm.out: dist
	make -C mi_qsort_cm bin/mi_qsort_cm.out
	cp ./mi_qsort_cm/bin/mi_qsort_cm.out ./dist/mi_qsort_cm.out

dist/mi_qsort_cm.wasm: dist
	make -C mi_qsort_cm bin/mi_qsort_cm.wasm
	cp ./mi_qsort_cm/bin/mi_qsort_cm.wasm ./dist/mi_qsort_cm.wasm

dist/mi_rsynth.out: dist
	make -C mi_rsynth bin/mi_rsynth.out
	cp ./mi_rsynth/bin/mi_rsynth.out ./dist/mi_rsynth.out

dist/mi_rsynth.wasm: dist
	make -C mi_rsynth bin/mi_rsynth.wasm
	cp ./mi_rsynth/bin/mi_rsynth.wasm ./dist/mi_rsynth.wasm

dist/mi_sha.out: dist
	make -C mi_sha bin/mi_sha.out
	cp ./mi_sha/bin/mi_sha.out ./dist/mi_sha.out

dist/mi_sha.wasm: dist
	make -C mi_sha bin/mi_sha.wasm
	cp ./mi_sha/bin/mi_sha.wasm ./dist/mi_sha.wasm

dist/mi_stringsearch.out: dist
	make -C mi_stringsearch bin/mi_stringsearch.out
	cp ./mi_stringsearch/bin/mi_stringsearch.out ./dist/mi_stringsearch.out

dist/mi_stringsearch.wasm: dist
	make -C mi_stringsearch bin/mi_stringsearch.wasm
	cp ./mi_stringsearch/bin/mi_stringsearch.wasm ./dist/mi_stringsearch.wasm

dist/mi_susan.out: dist
	make -C mi_susan bin/mi_susan.out
	cp ./mi_susan/bin/mi_susan.out ./dist/mi_susan.out

dist/mi_susan.wasm: dist
	make -C mi_susan bin/mi_susan.wasm
	cp ./mi_susan/bin/mi_susan.wasm ./dist/mi_susan.wasm

dist/pb_datamining_correlation.out: dist
	make -C pb_datamining_correlation bin/pb_datamining_correlation.out
	cp ./pb_datamining_correlation/bin/pb_datamining_correlation.out ./dist/pb_datamining_correlation.out

dist/pb_datamining_correlation.wasm: dist
	make -C pb_datamining_correlation bin/pb_datamining_correlation.wasm
	cp ./pb_datamining_correlation/bin/pb_datamining_correlation.wasm ./dist/pb_datamining_correlation.wasm

dist/pb_datamining_covariance.out: dist
	make -C pb_datamining_covariance bin/pb_datamining_covariance.out
	cp ./pb_datamining_covariance/bin/pb_datamining_covariance.out ./dist/pb_datamining_covariance.out

dist/pb_datamining_covariance.wasm: dist
	make -C pb_datamining_covariance bin/pb_datamining_covariance.wasm
	cp ./pb_datamining_covariance/bin/pb_datamining_covariance.wasm ./dist/pb_datamining_covariance.wasm

dist/pb_la_blas_gemm.out: dist
	make -C pb_la_blas_gemm bin/pb_la_blas_gemm.out
	cp ./pb_la_blas_gemm/bin/pb_la_blas_gemm.out ./dist/pb_la_blas_gemm.out

dist/pb_la_blas_gemm.wasm: dist
	make -C pb_la_blas_gemm bin/pb_la_blas_gemm.wasm
	cp ./pb_la_blas_gemm/bin/pb_la_blas_gemm.wasm ./dist/pb_la_blas_gemm.wasm

dist/pb_la_blas_gemver.out: dist
	make -C pb_la_blas_gemver bin/pb_la_blas_gemver.out
	cp ./pb_la_blas_gemver/bin/pb_la_blas_gemver.out ./dist/pb_la_blas_gemver.out

dist/pb_la_blas_gemver.wasm: dist
	make -C pb_la_blas_gemver bin/pb_la_blas_gemver.wasm
	cp ./pb_la_blas_gemver/bin/pb_la_blas_gemver.wasm ./dist/pb_la_blas_gemver.wasm

dist/pb_la_blas_gesummv.out: dist
	make -C pb_la_blas_gesummv bin/pb_la_blas_gesummv.out
	cp ./pb_la_blas_gesummv/bin/pb_la_blas_gesummv.out ./dist/pb_la_blas_gesummv.out

dist/pb_la_blas_gesummv.wasm: dist
	make -C pb_la_blas_gesummv bin/pb_la_blas_gesummv.wasm
	cp ./pb_la_blas_gesummv/bin/pb_la_blas_gesummv.wasm ./dist/pb_la_blas_gesummv.wasm

dist/pb_la_blas_symm.out: dist
	make -C pb_la_blas_symm bin/pb_la_blas_symm.out
	cp ./pb_la_blas_symm/bin/pb_la_blas_symm.out ./dist/pb_la_blas_symm.out

dist/pb_la_blas_symm.wasm: dist
	make -C pb_la_blas_symm bin/pb_la_blas_symm.wasm
	cp ./pb_la_blas_symm/bin/pb_la_blas_symm.wasm ./dist/pb_la_blas_symm.wasm

dist/pb_la_blas_syr2k.out: dist
	make -C pb_la_blas_syr2k bin/pb_la_blas_syr2k.out
	cp ./pb_la_blas_syr2k/bin/pb_la_blas_syr2k.out ./dist/pb_la_blas_syr2k.out

dist/pb_la_blas_syr2k.wasm: dist
	make -C pb_la_blas_syr2k bin/pb_la_blas_syr2k.wasm
	cp ./pb_la_blas_syr2k/bin/pb_la_blas_syr2k.wasm ./dist/pb_la_blas_syr2k.wasm

dist/pb_la_blas_syrk.out: dist
	make -C pb_la_blas_syrk bin/pb_la_blas_syrk.out
	cp ./pb_la_blas_syrk/bin/pb_la_blas_syrk.out ./dist/pb_la_blas_syrk.out

dist/pb_la_blas_syrk.wasm: dist
	make -C pb_la_blas_syrk bin/pb_la_blas_syrk.wasm
	cp ./pb_la_blas_syrk/bin/pb_la_blas_syrk.wasm ./dist/pb_la_blas_syrk.wasm

dist/pb_la_blas_trmm.out: dist
	make -C pb_la_blas_trmm bin/pb_la_blas_trmm.out
	cp ./pb_la_blas_trmm/bin/pb_la_blas_trmm.out ./dist/pb_la_blas_trmm.out

dist/pb_la_blas_trmm.wasm: dist
	make -C pb_la_blas_trmm bin/pb_la_blas_trmm.wasm
	cp ./pb_la_blas_trmm/bin/pb_la_blas_trmm.wasm ./dist/pb_la_blas_trmm.wasm

dist/pb_la_kernels_2mm.out: dist
	make -C pb_la_kernels_2mm bin/pb_la_kernels_2mm.out
	cp ./pb_la_kernels_2mm/bin/pb_la_kernels_2mm.out ./dist/pb_la_kernels_2mm.out

dist/pb_la_kernels_2mm.wasm: dist
	make -C pb_la_kernels_2mm bin/pb_la_kernels_2mm.wasm
	cp ./pb_la_kernels_2mm/bin/pb_la_kernels_2mm.wasm ./dist/pb_la_kernels_2mm.wasm

dist/pb_la_kernels_3mm.out: dist
	make -C pb_la_kernels_3mm bin/pb_la_kernels_3mm.out
	cp ./pb_la_kernels_3mm/bin/pb_la_kernels_3mm.out ./dist/pb_la_kernels_3mm.out

dist/pb_la_kernels_3mm.wasm: dist
	make -C pb_la_kernels_3mm bin/pb_la_kernels_3mm.wasm
	cp ./pb_la_kernels_3mm/bin/pb_la_kernels_3mm.wasm ./dist/pb_la_kernels_3mm.wasm

dist/pb_la_kernels_atax.out: dist
	make -C pb_la_kernels_atax bin/pb_la_kernels_atax.out
	cp ./pb_la_kernels_atax/bin/pb_la_kernels_atax.out ./dist/pb_la_kernels_atax.out

dist/pb_la_kernels_atax.wasm: dist
	make -C pb_la_kernels_atax bin/pb_la_kernels_atax.wasm
	cp ./pb_la_kernels_atax/bin/pb_la_kernels_atax.wasm ./dist/pb_la_kernels_atax.wasm

dist/pb_la_kernels_bicg.out: dist
	make -C pb_la_kernels_bicg bin/pb_la_kernels_bicg.out
	cp ./pb_la_kernels_bicg/bin/pb_la_kernels_bicg.out ./dist/pb_la_kernels_bicg.out

dist/pb_la_kernels_bicg.wasm: dist
	make -C pb_la_kernels_bicg bin/pb_la_kernels_bicg.wasm
	cp ./pb_la_kernels_bicg/bin/pb_la_kernels_bicg.wasm ./dist/pb_la_kernels_bicg.wasm

dist/pb_la_kernels_doitgen.out: dist
	make -C pb_la_kernels_doitgen bin/pb_la_kernels_doitgen.out
	cp ./pb_la_kernels_doitgen/bin/pb_la_kernels_doitgen.out ./dist/pb_la_kernels_doitgen.out

dist/pb_la_kernels_doitgen.wasm: dist
	make -C pb_la_kernels_doitgen bin/pb_la_kernels_doitgen.wasm
	cp ./pb_la_kernels_doitgen/bin/pb_la_kernels_doitgen.wasm ./dist/pb_la_kernels_doitgen.wasm

dist/pb_la_kernels_mvt.out: dist
	make -C pb_la_kernels_mvt bin/pb_la_kernels_mvt.out
	cp ./pb_la_kernels_mvt/bin/pb_la_kernels_mvt.out ./dist/pb_la_kernels_mvt.out

dist/pb_la_kernels_mvt.wasm: dist
	make -C pb_la_kernels_mvt bin/pb_la_kernels_mvt.wasm
	cp ./pb_la_kernels_mvt/bin/pb_la_kernels_mvt.wasm ./dist/pb_la_kernels_mvt.wasm

dist/pb_la_solvers_cholesky.out: dist
	make -C pb_la_solvers_cholesky bin/pb_la_solvers_cholesky.out
	cp ./pb_la_solvers_cholesky/bin/pb_la_solvers_cholesky.out ./dist/pb_la_solvers_cholesky.out

dist/pb_la_solvers_cholesky.wasm: dist
	make -C pb_la_solvers_cholesky bin/pb_la_solvers_cholesky.wasm
	cp ./pb_la_solvers_cholesky/bin/pb_la_solvers_cholesky.wasm ./dist/pb_la_solvers_cholesky.wasm

dist/pb_la_solvers_durbin.out: dist
	make -C pb_la_solvers_durbin bin/pb_la_solvers_durbin.out
	cp ./pb_la_solvers_durbin/bin/pb_la_solvers_durbin.out ./dist/pb_la_solvers_durbin.out

dist/pb_la_solvers_durbin.wasm: dist
	make -C pb_la_solvers_durbin bin/pb_la_solvers_durbin.wasm
	cp ./pb_la_solvers_durbin/bin/pb_la_solvers_durbin.wasm ./dist/pb_la_solvers_durbin.wasm

dist/pb_la_solvers_gramschmidt.out: dist
	make -C pb_la_solvers_gramschmidt bin/pb_la_solvers_gramschmidt.out
	cp ./pb_la_solvers_gramschmidt/bin/pb_la_solvers_gramschmidt.out ./dist/pb_la_solvers_gramschmidt.out

dist/pb_la_solvers_gramschmidt.wasm: dist
	make -C pb_la_solvers_gramschmidt bin/pb_la_solvers_gramschmidt.wasm
	cp ./pb_la_solvers_gramschmidt/bin/pb_la_solvers_gramschmidt.wasm ./dist/pb_la_solvers_gramschmidt.wasm

dist/pb_la_solvers_lu.out: dist
	make -C pb_la_solvers_lu bin/pb_la_solvers_lu.out
	cp ./pb_la_solvers_lu/bin/pb_la_solvers_lu.out ./dist/pb_la_solvers_lu.out

dist/pb_la_solvers_lu.wasm: dist
	make -C pb_la_solvers_lu bin/pb_la_solvers_lu.wasm
	cp ./pb_la_solvers_lu/bin/pb_la_solvers_lu.wasm ./dist/pb_la_solvers_lu.wasm

dist/pb_la_solvers_ludcmp.out: dist
	make -C pb_la_solvers_ludcmp bin/pb_la_solvers_ludcmp.out
	cp ./pb_la_solvers_ludcmp/bin/pb_la_solvers_ludcmp.out ./dist/pb_la_solvers_ludcmp.out

dist/pb_la_solvers_ludcmp.wasm: dist
	make -C pb_la_solvers_ludcmp bin/pb_la_solvers_ludcmp.wasm
	cp ./pb_la_solvers_ludcmp/bin/pb_la_solvers_ludcmp.wasm ./dist/pb_la_solvers_ludcmp.wasm

dist/pb_la_solvers_trisolv.out: dist
	make -C pb_la_solvers_trisolv bin/pb_la_solvers_trisolv.out
	cp ./pb_la_solvers_trisolv/bin/pb_la_solvers_trisolv.out ./dist/pb_la_solvers_trisolv.out

dist/pb_la_solvers_trisolv.wasm: dist
	make -C pb_la_solvers_trisolv bin/pb_la_solvers_trisolv.wasm
	cp ./pb_la_solvers_trisolv/bin/pb_la_solvers_trisolv.wasm ./dist/pb_la_solvers_trisolv.wasm

dist/pb_medely_deriche.out: dist
	make -C pb_medely_deriche bin/pb_medely_deriche.out
	cp ./pb_medely_deriche/bin/pb_medely_deriche.out ./dist/pb_medely_deriche.out

dist/pb_medely_deriche.wasm: dist
	make -C pb_medely_deriche bin/pb_medely_deriche.wasm
	cp ./pb_medely_deriche/bin/pb_medely_deriche.wasm ./dist/pb_medely_deriche.wasm

dist/pb_medely_floyd_warshall.out: dist
	make -C pb_medely_floyd_warshall bin/pb_medely_floyd_warshall.out
	cp ./pb_medely_floyd_warshall/bin/pb_medely_floyd_warshall.out ./dist/pb_medely_floyd_warshall.out

dist/pb_medely_floyd_warshall.wasm: dist
	make -C pb_medely_floyd_warshall bin/pb_medely_floyd_warshall.wasm
	cp ./pb_medely_floyd_warshall/bin/pb_medely_floyd_warshall.wasm ./dist/pb_medely_floyd_warshall.wasm

dist/pb_medely_nussinov.out: dist
	make -C pb_medely_nussinov bin/pb_medely_nussinov.out
	cp ./pb_medely_nussinov/bin/pb_medely_nussinov.out ./dist/pb_medely_nussinov.out

dist/pb_medely_nussinov.wasm: dist
	make -C pb_medely_nussinov bin/pb_medely_nussinov.wasm
	cp ./pb_medely_nussinov/bin/pb_medely_nussinov.wasm ./dist/pb_medely_nussinov.wasm

dist/pb_stencils_adi.out: dist
	make -C pb_stencils_adi bin/pb_stencils_adi.out
	cp ./pb_stencils_adi/bin/pb_stencils_adi.out ./dist/pb_stencils_adi.out

dist/pb_stencils_adi.wasm: dist
	make -C pb_stencils_adi bin/pb_stencils_adi.wasm
	cp ./pb_stencils_adi/bin/pb_stencils_adi.wasm ./dist/pb_stencils_adi.wasm

dist/pb_stencils_fdtd_2d.out: dist
	make -C pb_stencils_fdtd_2d bin/pb_stencils_fdtd_2d.out
	cp ./pb_stencils_fdtd_2d/bin/pb_stencils_fdtd_2d.out ./dist/pb_stencils_fdtd_2d.out

dist/pb_stencils_fdtd_2d.wasm: dist
	make -C pb_stencils_fdtd_2d bin/pb_stencils_fdtd_2d.wasm
	cp ./pb_stencils_fdtd_2d/bin/pb_stencils_fdtd_2d.wasm ./dist/pb_stencils_fdtd_2d.wasm

dist/pb_stencils_heat_3d.out: dist
	make -C pb_stencils_heat_3d bin/pb_stencils_heat_3d.out
	cp ./pb_stencils_heat_3d/bin/pb_stencils_heat_3d.out ./dist/pb_stencils_heat_3d.out

dist/pb_stencils_heat_3d.wasm: dist
	make -C pb_stencils_heat_3d bin/pb_stencils_heat_3d.wasm
	cp ./pb_stencils_heat_3d/bin/pb_stencils_heat_3d.wasm ./dist/pb_stencils_heat_3d.wasm

dist/pb_stencils_jacobi_1d.out: dist
	make -C pb_stencils_jacobi_1d bin/pb_stencils_jacobi_1d.out
	cp ./pb_stencils_jacobi_1d/bin/pb_stencils_jacobi_1d.out ./dist/pb_stencils_jacobi_1d.out

dist/pb_stencils_jacobi_1d.wasm: dist
	make -C pb_stencils_jacobi_1d bin/pb_stencils_jacobi_1d.wasm
	cp ./pb_stencils_jacobi_1d/bin/pb_stencils_jacobi_1d.wasm ./dist/pb_stencils_jacobi_1d.wasm

dist/pb_stencils_jacobi_2d.out: dist
	make -C pb_stencils_jacobi_2d bin/pb_stencils_jacobi_2d.out
	cp ./pb_stencils_jacobi_2d/bin/pb_stencils_jacobi_2d.out ./dist/pb_stencils_jacobi_2d.out

dist/pb_stencils_jacobi_2d.wasm: dist
	make -C pb_stencils_jacobi_2d bin/pb_stencils_jacobi_2d.wasm
	cp ./pb_stencils_jacobi_2d/bin/pb_stencils_jacobi_2d.wasm ./dist/pb_stencils_jacobi_2d.wasm

dist/pb_stencils_seidel_2d.out: dist
	make -C pb_stencils_seidel_2d bin/pb_stencils_seidel_2d.out
	cp ./pb_stencils_seidel_2d/bin/pb_stencils_seidel_2d.out ./dist/pb_stencils_seidel_2d.out

dist/pb_stencils_seidel_2d.wasm: dist
	make -C pb_stencils_seidel_2d bin/pb_stencils_seidel_2d.wasm
	cp ./pb_stencils_seidel_2d/bin/pb_stencils_seidel_2d.wasm ./dist/pb_stencils_seidel_2d.wasm

dist/resize_image.out: dist
	make -C sod resize_image.out
	cp ./sod/resize_image.out ./dist/resize_image.out

dist/resize_image.wasm: dist
	make -C sod resize_image.wasm
	cp ./sod/resize_image.wasm ./dist/resize_image.wasm

dist/license_plate_detection.out: dist
	make -C sod license_plate_detection.out
	cp ./sod/license_plate_detection.out ./dist/license_plate_detection.out

dist/license_plate_detection.wasm: dist
	make -C sod license_plate_detection.wasm
	cp ./sod/license_plate_detection.wasm ./dist/license_plate_detection.wasm

dist/cnn_face_detection.out: dist
	make -C sod cnn_face_detection.out
	cp ./sod/cnn_face_detection.out ./dist/cnn_face_detection.out

dist/cnn_face_detection.wasm: dist
	make -C sod cnn_face_detection.wasm
	cp ./sod/cnn_face_detection.wasm ./dist/cnn_face_detection.wasm

# TODO: speechtotext

dist/gps_ekf.out: dist
	make -C TinyEKF -f wasm.mk gps_ekf.out
	cp ./TinyEKF/gps_ekf.out ./dist/gps_ekf.out

dist/gps_ekf.wasm: dist
	make -C TinyEKF -f wasm.mk gps_ekf.wasm
	cp ./TinyEKF/gps_ekf.wasm ./dist/gps_ekf.wasm

dist/trap_divzero.out: dist
	make -C traps trap_divzero.out
	cp ./traps/trap_divzero.out ./dist/trap_divzero.out

dist/trap_divzero.wasm: dist
	make -C traps trap_divzero.wasm
	cp ./traps/trap_divzero.wasm ./dist/trap_divzero.wasm

dist/stack_overflow.out: dist
	make -C stack_overflow stack_overflow.out
	cp ./stack_overflow/stack_overflow.out ./dist/stack_overflow.out

dist/stack_overflow.wasm: dist
	make -C stack_overflow stack_overflow.wasm
	cp ./stack_overflow/stack_overflow.wasm ./dist/stack_overflow.wasm

dist/acronym.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/all-your-base.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/armstrong-numbers.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/bank-account.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/binary-search.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/circular-buffer.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/collatz-conjecture.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/darts.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/difference-of-squares.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/grains.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/hamming.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/hello_world.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/html.wasm: dist
	make -C html $(subst dist/,,$@)
	cp $(subst dist/,html/,$@) $@

dist/leap.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/nucleotide-count.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/pangram.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/raindrops.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/resistor-color.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/reverse-string.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/rna-transcription.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/triangle.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/two-fer.wasm: dist
	make -C exercism $(subst dist/,,$@)
	cp $(subst dist/,exercism/,$@) $@

dist/start.wasm: dist
	make -C start $(subst dist/,,$@)
	cp $(subst dist/,start/,$@) $@

dist/unreachable.wasm: dist
	make -C unreachable $(subst dist/,,$@)
	cp $(subst dist/,unreachable/,$@) $@

