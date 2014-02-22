FROM ubuntu:12.10
MAINTAINER Kevin McCarthy <me@kevinmccarthy.org>

# Based on instructions found here:
# http://www.dogeco.in/wiki/index.php/Compiling_Dogecoind_on_Ubuntu/Debian

RUN apt-get update
RUN apt-get install -y  ntp git build-essential libssl-dev libdb-dev libdb++-dev libboost-all-dev
RUN git clone https://github.com/dogecoin/dogecoin
RUN cd dogecoin/src && make USE_UPNP= USE_QRCODE= -f makefile.unix && strip dogecoind
RUN ln -s /dogecoin/src/dogecoind /bin/dogecoind

ADD . /dogecoind
WORKDIR /dogecoind

EXPOSE 22555
EXPOSE 22556

ADD	enter /enter
RUN	chmod +x /enter
ENTRYPOINT ["/enter"]
