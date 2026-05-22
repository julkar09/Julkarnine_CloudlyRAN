#!/bin/bash
set -e

SRSSRAN_DIR="$HOME/srsRAN_Project"
LOG_FILE="/vagrant/logs/srsran_build.log"

mkdir -p /vagrant/logs

echo "[$(date)] Starting srsRAN build" | tee -a $LOG_FILE

# 1. Clone repository
cd $HOME
if [ -d "$SRSSRAN_DIR" ]; then
    cd $SRSSRAN_DIR
    git pull
else
    git clone https://github.com/srsran/srsRAN_Project.git
    cd srsRAN_Project
fi

# Capture commit hash
COMMIT_HASH=$(git rev-parse HEAD)
echo "Build Git Commit Hash: $COMMIT_HASH" | tee -a $LOG_FILE

# 2. Install dependencies
sudo apt update
sudo apt install -y build-essential cmake libfftw3-dev libmbedtls-dev \
    libboost-program-options-dev libconfig++-dev libsctp-dev \
    libuhd-dev libzmq3-dev libyaml-cpp-dev

# 3. Build srsRAN
mkdir -p build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
          -DENABLE_UHD=ON \
          -DENABLE_ZEROMQ=ON
make -j$(nproc)

# 4. Install
sudo make install
sudo ldconfig

# 5. Verify gNB binary
echo -e "\n=== srsRAN Binaries ===" | tee -a $LOG_FILE
which sr sgnb || find /usr/local -name "srsgnb" 2>/dev/null | tee -a $LOG_FILE

# 6. Copy default configs
sudo cp $SRSSRAN_DIR/build/apps/gnb/gnb.conf /vagrant/configs/srsran/gnb.yaml 2>/dev/null || echo "Config copy later"

echo "[$(date)] srsRAN build completed" | tee -a $LOG_FILE