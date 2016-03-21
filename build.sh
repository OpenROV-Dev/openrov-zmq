#!/bin/bash
set -e
# Install prereqs
apt-get update
apt-get install automake autoconf libtool pkg-config build-essential doxygen gcc g++ -y

mkdir -p output/usr

# Build and install zeromq
git clone https://github.com/zeromq/libzmq
cd libzmq
./autogen.sh && ./configure --prefix=${PWD}/../output/usr/ && make -j4
make install && sudo ldconfig

cd ..

# Get the C++ bindings

git clone https://github.com/zeromq/cppzmq.git
mv cppzmq/zmq.hpp output/usr/include/

