#!/bin/bash
set -eu

echo "This will certainly not work if the leelaz setup script didn't run yet"

echo "Installing required packages"

sudo apt install -y zlib1g-dev libzip-dev libboost-filesystem-dev

echo "Installing recent cmake"
sudo apt remove cmake -y
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt-get update
sudo apt-get install cmake -y

echo "Installing KataGo"
sudo apt-get install libcudnn7 libcudnn7-dev unzip -y
cd /katago
git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
cmake . -DBUILD_MCTS=1 -DUSE_BACKEND=CUDA -DCMAKE_CUDA_COMPILER=/usr/local/cuda-10.1/bin/nvcc -DCMAKE_C_COMPILER=/usr/bin/gcc-8 -DCMAKE_CXX_COMPILER=/usr/bin/g++-8
cmake --build .
cd /katago
ln -s KataGo/cpp/katago .
./download-katago-network.sh
