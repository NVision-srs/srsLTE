FROM ubuntu:18.04

COPY ./srsLTE /srsLTE

RUN apt-get update -y && \
apt-get install -y software-properties-common

RUN apt-get update -y && \
	apt-get install -y cmake \
	libfftw3-dev \
	libmbedtls-dev \
	libboost-program-options-dev \
	libconfig++-dev \
	libsctp-dev

WORKDIR srsLTE/build
RUN cmake ../ && make && make install && ldconfig
RUN ./srslte_install_configs.sh service
