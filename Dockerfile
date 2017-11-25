FROM ubuntu:latest
MAINTAINER Filip Sajdak <filip.sajdak@gmail.com>

LABEL Description="Modern C++ environment for building projects for STM32F429"

RUN apt-get update && apt-get install -y \
  git \
  cmake \
  make \
  automake \
  libffi-dev \
  libssl-dev \
  libusb-1.0.0 \
  libusb-1.0.0-dev \
  software-properties-common \
  gawk \
  genromfs \
  ccache

# arm-none-eabi custom ppa
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
  apt-get update && \
  apt-get install -y gcc-arm-embedded

# STLink util
RUN git clone https://github.com/texane/stlink.git /tmp/stlink && \
  cd /tmp/stlink && mkdir build && cd build && \
  cmake .. && make && make install ; cd -

ENV LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH  
  
# STM32Cube_FW_F4_V1.8.0
RUN git clone https://github.com/chettrick/stm32cubef4 /tmp/stm32cubef4 && \
  mv /tmp/stm32cubef4/STM32Cube_FW_F4_V1.8.0/ /opt/
  
# stm32-cmake
RUN git clone https://github.com/ObKo/stm32-cmake /opt/stm32-cmake && \
  cp -rv /opt/stm32-cmake/cmake/* /usr/share/cmake-3.5/Modules/
  
# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt && \
  rm -rf /tmp/*
