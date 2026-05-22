echo '# Debugging Notes

## Issues Faced & Solutions

### 1. Open5GS Service Not Found
**Problem:** `systemctl start open5gs-amfd` → Unit not found
**Solution:** Run binary directly
```bash
sudo /usr/local/bin/open5gs-amfd -c /etc/open5gs/amf.yaml