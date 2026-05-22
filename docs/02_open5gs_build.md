# Open5GS Build Documentation

## Build Information

| Parameter | Value |
|-----------|-------|
| Repository | https://github.com/open5gs/open5gs |
| Git Commit Hash | `a1b2c3d4e5f6...` (replace with actual) |
| Version | v2.7.1 |
| Build Date | $(date) |
| Build Directory | `~/open5gs/build` |
| Install Prefix | `/usr/local` |

## Build Commands Executed

```bash
git clone https://github.com/open5gs/open5gs.git
cd open5gs
meson setup build --prefix=/usr/local
ninja -C build
sudo ninja -C build install