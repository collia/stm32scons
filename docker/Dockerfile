FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
RUN useradd -ms /bin/bash  user

RUN apt-get update && \
    apt-get upgrade -y -q && \
    apt-get install -y ccache libncurses5-dev \
      libssl-dev bc bison flex util-linux dosfstools e2fsprogs \
      wget make git gcc-arm-none-eabi gdb-arm-none-eabi libusb-dev libusb-1.0 \
      libtool autotools-dev  automake pkg-config usbutils scons && \
    mkdir /home/user/stm && \
    mkdir /home/user/stm32cubef1


RUN git clone git://git.code.sf.net/p/openocd/code openocd-code &&\
	cd openocd-code && \
	git checkout tags/v0.9.0 && \
	./bootstrap && \
	./configure --enable-maintainer-mode --disable-werror --enable-jlink --enable-stlink && \
	make && \
	sudo make install	

#USER user

WORKDIR /home/user/stm

ENTRYPOINT ["/bin/bash", "-c"]
