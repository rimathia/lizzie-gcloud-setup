#!/bin/bash
set -eu

echo "This will certainly not work if the leelaz setup script didn't run yet"

echo "Installing required packages"

sudo apt install zlib1g-dev libzip-dev libboost-filesystem-dev

# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
echo "Building and installing a modern enough cmake (not tested)"

sudo apt remove --purge --auto-remove cmake
version=3.15
build=2
mkdir ~/temp
cd ~/temp
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
tar -xzvf cmake-$version.$build.tar.gz
cd cmake-$version.$build/
./bootstrap
make -j4
sudo make install
sudo ln -s /usr/local/bin/cmake /usr/bin/

# haven't managed to get CUDA backend to compile yet
echo "Installing KataGo"
cd /katago
git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
cmake . -DBUILD_MCTS=1 -DUSE_BACKEND=OPENCL -DCMAKE_C_COMPILER=/usr/bin/gcc-8 -DCMAKE_CXX_COMPILER=/usr/bin/g++-8
cmake --build .
cd /katago
cp KataGo/cpp/katago .
./download-best-network.sh

