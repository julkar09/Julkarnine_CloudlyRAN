# Environment Setup for CloudlyRAN

## Prerequisites
- **VirtualBox** 6.1 or later (Download: https://www.virtualbox.org/)
- **Vagrant** 2.2.19 or later (Download: https://www.vagrantup.com/)
- **Minimum Host Resources**: 8GB RAM, 20GB free disk

## Network Configuration

| Interface | IP Address | Purpose |
|-----------|------------|---------|
| eth0 (NAT) | 10.0.2.15 | Internet access for downloads |
| eth1 (Host-Only) | 192.168.56.10 | gNB ↔ AMF communication |

## How to Start

```bash
cd Julkarnine_CloudlyRAN
vagrant up
vagrant ssh