echo '# References

## Official Documentation

1. **Open5GS Docs** - https://open5gs.org/open5gs/docs/
2. **srsRAN Project Docs** - https://docs.srsran.com/projects/project/
3. **Vagrant Docs** - https://developer.hashicorp.com/vagrant/docs

## GitHub Repositories

4. **Open5GS** - https://github.com/open5gs/open5gs
5. **srsRAN Project** - https://github.com/srsran/srsRAN_Project

## 3GPP Specifications

6. **NGAP Protocol (TS 38.413)** - https://www.3gpp.org/ftp/Specs/archive/38_series/38.413/
7. **5G NR (TS 38.104)** - https://www.3gpp.org/ftp/Specs/archive/38_series/38.104/

## Tools Used

| Tool | Version |
|------|---------|
| Ubuntu | 22.04 |
| Vagrant | 2.2.19 |
| VirtualBox | 6.1 |
| Meson | 0.61.2 |
| CMake | 3.22.1 |

## Commands Reference

```bash
# Build Open5GS
meson setup build --prefix=/usr/local
ninja -C build
sudo ninja -C build install

# Build srsRAN
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j2
sudo make install

# Run AMF
sudo /usr/local/bin/open5gs-amfd -c /etc/open5gs/amf.yaml

# Run gNB
sudo ./gnb --gnb_id=1 --cu_cp.amf.addr=127.0.0.1 --cu_cp.amf.port=38412
```' > /vagrant/docs/07_references.md