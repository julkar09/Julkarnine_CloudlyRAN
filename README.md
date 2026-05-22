cat > /vagrant/README.md << 'EOF'
# Julkarnine_CloudlyRAN

5G Core + gNB simulation using Open5GS and srsRAN on Vagrant Ubuntu 22.04.

## Final Status

| Component | Status |
|-----------|--------|
| Vagrant VM | ✅ Working |
| Open5GS Build | ✅ Working |
| srsRAN Build | ✅ Working |
| Open5GS + srsRAN Integration | ⚠️ Partially Working |

## Key Learnings

1. **Open5GS Build Process**: Successfully built Open5GS v2.7.7 from source with all dependencies (MongoDB, RabbitMQ, meson build system).

2. **srsRAN Build Challenges**: Faced linker errors with main branch, resolved by switching to release-24.10 branch.

3. **Integration Complexity**: Understanding NGAP protocol, SCTP association, and PLMN/TAC alignment between gNB and AMF.

4. **Network Configuration**: Required proper IP binding (192.168.56.10) for external communication, eventually used localhost (127.0.0.1) for stability.

5. **Debugging Skills**: Used tcpdump, ss, netstat, and log analysis to identify connection and PLMN mismatch issues.

## Known Issues

| Issue | Status | Workaround |
|-------|--------|------------|
| srsRAN 5G gNB config parser | ⚠️ Unresolved | Use command-line arguments instead of config file |
| PLMN format mismatch | ⚠️ Unresolved | Open5GS expects MCC/MNC separate, srsRAN sends combined |
| Open5GS SBI warnings | ⚠️ Minor | Can be ignored for basic N2 integration |
| Systemd auto-restart | ✅ Resolved | Disabled systemd services, run manually |

## References Used

1. [Open5GS Official Documentation](https://open5gs.org/open5gs/docs/)
2. [srsRAN Project Documentation](https://docs.srsran.com/projects/project/)
3. [Open5GS GitHub Repository](https://github.com/open5gs/open5gs)
4. [srsRAN Project GitHub](https://github.com/srsran/srsRAN_Project)
5. [5G NR NGAP Specification (3GPP TS 38.413)](https://www.3gpp.org/ftp/Specs/archive/38_series/38.413/)

## How to Reproduce

```bash
# Clone repository
git clone https://github.com/yourusername/Julkarnine_CloudlyRAN.git
cd Julkarnine_CloudlyRAN

# Start VM
vagrant up
vagrant ssh

# Build Open5GS
cd /vagrant/scripts
./build_open5gs.sh

# Build srsRAN
./build_srsran.sh

# Start AMF
sudo /usr/local/bin/open5gs-amfd -c /etc/open5gs/amf.yaml

# Run gNB (in another terminal)
cd /home/vagrant/srsRAN_Project/build/apps/gnb
sudo ./gnb --gnb_id=1 --cu_cp.amf.addr=127.0.0.1 --cu_cp.amf.port=38412