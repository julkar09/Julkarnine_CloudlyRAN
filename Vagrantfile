# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ubuntu 22.04 (Jammy) box
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "cloudlyran"

  # Networking - Host-only network for gNB <-> Core communication
  config.vm.network "private_network", ip: "192.168.56.10"
  # NAT for internet access (default)
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", use_dhcp_assigned_default_route: true

  # Resource allocation for source builds (Open5GS + srsRAN need 4GB+)
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Julkarnine_CloudlyRAN_VM"
    vb.memory = "4096"    # 4GB RAM
    vb.cpus = 2            # 2 CPU cores
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Sync folder (default /vagrant)
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Shell provisioning for dependencies
  config.vm.provision "shell", path: "scripts/setup_dependencies.sh", privileged: false

  # Post-provision message
  config.vm.post_up_message = <<-MSG
    ✅ CloudlyRAN VM is ready!
    📍 IP: 192.168.56.10
    🔧 SSH: vagrant ssh
    📁 Shared folder: /vagrant
    📜 Build scripts: cd /vagrant/scripts
  MSG
end