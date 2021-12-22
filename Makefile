all: \
	dist/cifar10.wasm \
	dist/echo.wasm \
	dist/empty.wasm \
	dist/exit.wasm \
	dist/fibonacci.wasm \
	dist/gocr.wasm \
	dist/resize_image.wasm \
	dist/license_plate_detection.wasm \
	dist/gps_ekf.wasm


clean:
	rm -rf dist
	make -C CMSIS_5_NN clean
	make -C echo clean
	make -C empty clean
	make -C exit clean
	make -C fibonacci clean
	make -C gocr -f wasm.mk clean
	make -C sod clean
	make -C TinyEKF -f wasm.mk clean

dist:
	mkdir dist

dist/cifar10.wasm: dist
	make -C CMSIS_5_NN cifar10.wasm
	cp ./CMSIS_5_NN/cifar10.wasm ./dist/cifar10.wasm

dist/echo.wasm: dist
	make -C echo echo.wasm
	cp ./echo/echo.wasm ./dist/echo.wasm

dist/empty.wasm: dist
	make -C empty empty.wasm
	cp ./empty/empty.wasm ./dist/empty.wasm

dist/exit.wasm: dist
	make -C exit exit.wasm
	cp ./exit/exit.wasm ./dist/exit.wasm

dist/fibonacci.wasm: dist
	make -C fibonacci fibonacci.wasm
	cp ./fibonacci/fibonacci.wasm ./dist/fibonacci.wasm

dist/gocr.wasm: dist
	make -C gocr -f wasm.mk gocr.wasm
	cp ./gocr/gocr.wasm ./dist/gocr.wasm

dist/resize_image.wasm: dist
	make -C sod resize_image.wasm
	cp ./sod/resize_image.wasm ./dist/resize_image.wasm

dist/license_plate_detection.wasm: dist
	make -C sod license_plate_detection.wasm
	cp ./sod/license_plate_detection.wasm ./dist/license_plate_detection.wasm

dist/gps_ekf.wasm: dist
	make -C TinyEKF -f wasm.mk gps_ekf.wasm
	cp ./TinyEKF/gps_ekf.wasm ./dist/gps_ekf.wasm
