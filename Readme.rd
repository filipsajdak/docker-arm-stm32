docker run -it --rm --mount type=bind,source="/stm32",target=/root --privileged stm32 /bin/bash

docker run -it --rm -v `pwd`:/root ryankurte/docker-arm-embedded /bin/bash

cmake -DSTM32_CHIP=STM32F429ZI -DCMAKE_TOOLCHAIN_FILE=/opt/stm32-cmake/cmake/gcc_stm32.cmake ..

export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
