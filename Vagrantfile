Vagrant.configure("2") do |config|

  # Control Machine (Ansible Controller)
  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/jammy64"  # Ubuntu 22.04 LTS
    control.vm.hostname = "control"
    control.vm.network "private_network", type: "static", ip: "192.168.50.11"
    control.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
    control.vm.provision "shell", inline: <<-SHELL
	
      sudo apt update
	  sudo apt install -y software-properties-common
	  sudo add-apt-repository --yes --update ppa:ansible/ansible
	  sudo apt install -y ansible
	  ansible-galaxy collection install ansible.posix
	  
    SHELL
  end

  # ComA Machine
  config.vm.define "comA" do |comA|
    comA.vm.box = "ubuntu/focal64" # Ubuntu 20.04 LTS
    comA.vm.hostname = "comA"
    comA.vm.network "private_network", type: "static", ip: "192.168.50.12"
    comA.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # ComB Machine
  config.vm.define "comB" do |comB|
    comB.vm.box = "ubuntu/jammy64" # ubuntu 22.04 LTS
    comB.vm.hostname = "comB"
    comB.vm.network "private_network", type: "static", ip: "192.168.50.13"
    comB.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

end
