cat > /vagrant/docs/03_srsran_build.md << 'EOF'
# srsRAN Project Build Documentation

## Build Information

| Parameter | Value |
|-----------|-------|
| Repository | https://github.com/srsran/srsRAN_Project |
| Git Commit Hash | 4bf1543936 |
| Version | 25.10.0 |
| Build Date | May 22, 2025 |
| Binary Location | `/home/vagrant/srsRAN_Project/build/apps/gnb/gnb` |

## Build Commands

```bash
git clone https://github.com/srsran/srsRAN_Project.git
cd srsRAN_Project
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DENABLE_UHD=ON
make -j2
sudo make install