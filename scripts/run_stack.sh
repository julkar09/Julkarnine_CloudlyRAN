echo '#!/bin/bash

echo "========================================="
echo "Starting CloudlyRAN Stack"
echo "========================================="

# Kill old processes if running
sudo pkill -9 -f open5gs-amfd 2>/dev/null
sudo pkill -9 -f gnb 2>/dev/null

# Start AMF
echo "Starting Open5GS AMF..."
sudo /usr/local/bin/open5gs-amfd -c /etc/open5gs/amf.yaml &
sleep 3
echo "✓ AMF started on 127.0.0.1:38412"

# Start gNB
echo "Starting srsRAN gNB..."
cd /home/vagrant/srsRAN_Project/build/apps/gnb
sudo ./gnb --gnb_id=1 --cu_cp.amf.addr=127.0.0.1 --cu_cp.amf.port=38412 &
sleep 2
echo "✓ gNB started"

echo "========================================="
echo "Stack is running. Press Ctrl+C to stop."
echo "========================================="

wait' > /vagrant/scripts/run_stack.sh