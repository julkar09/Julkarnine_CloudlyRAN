#!/bin/bash
set -e

OPEN5GS_VERSION="v2.7.1"  # Stable version
OPEN5GS_DIR="$HOME/open5gs"
LOG_FILE="/vagrant/logs/open5gs_build.log"

mkdir -p /vagrant/logs

echo "[$(date)] Starting Open5GS build" | tee -a $LOG_FILE

# 1. Clone repository
cd $HOME
if [ -d "$OPEN5GS_DIR" ]; then
    echo "Open5GS directory exists, updating..." | tee -a $LOG_FILE
    cd $OPEN5GS_DIR
    git pull
else
    git clone https://github.com/open5gs/open5gs.git
    cd open5gs
fi

# Capture commit hash
COMMIT_HASH=$(git rev-parse HEAD)
echo "Build Git Commit Hash: $COMMIT_HASH" | tee -a $LOG_FILE
git log -1 --pretty=format:"%h - %an, %ar : %s" | tee -a $LOG_FILE

# 2. Install dependencies
sudo apt update
sudo apt install -y python3-pip python3-setuptools ninja-build
pip3 install --user meson

# 3. Build Open5GS
cd $OPEN5GS_DIR
meson setup build --prefix=/usr/local
ninja -C build

# 4. Install
sudo ninja -C build install

# 5. Configure MongoDB
sudo systemctl restart mongodb
sudo systemctl enable mongodb

# 6. Setup database
cd $OPEN5GS_DIR/build
sudo ninja install
sudo ldconfig

# 7. Start services for verification
sudo systemctl daemon-reload

# 8. Verify binaries
echo -e "\n=== Open5GS Binaries ===" | tee -a $LOG_FILE
ls -la /usr/local/bin/open5gs-* | tee -a $LOG_FILE

echo "[$(date)] Open5GS build completed" | tee -a $LOG_FILE

# Copy config files to shared folder
cp -r $OPEN5GS_DIR/build/config/* /vagrant/configs/open5gs/ 2>/dev/null || echo "Config copy skipped"