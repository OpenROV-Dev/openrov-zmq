#!/bin/bash
set -e
# Install prereqs
#apt-get update
#apt-get install automake autoconf libtool pkg-config build-essential doxygen gcc g++ -y

mkdir -p output/usr

# Cleanup
rm -rf build
mkdir -p build

cd build 

# Build and install zeromq
wget http://download.zeromq.org/zeromq-4.1.4.tar.gz
tar xf zeromq-4.1.4.tar.gz
cd zero*

./autogen.sh && ./configure --without-libsodium --enable-static --disable-shared --prefix=${PWD}/../../output/usr/ && make -j4
make install && sudo ldconfig

cd ..

# Get the C++ bindings
git clone https://github.com/zeromq/cppzmq.git
mv cppzmq/zmq.hpp ../output/usr/include/

# Get Cpperomq
git clone https://github.com/jship/CpperoMQ.git
mv CpperoMQ/include/CpperoMQ ../output/usr/include/
