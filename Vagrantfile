Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "nosql-box"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "TallerNoSQL_v4"
    vb.cpus = 2
    vb.memory = 3048
  end

  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
    rm /home/vagrant/.ssh/me.pub
  SHELL

  # Ports
  config.vm.network :forwarded_port, guest: 7687, host: 7687, id: 'bolt'
  config.vm.network :forwarded_port, guest: 8082, host: 8082, id: 'bottle'
  config.vm.network :forwarded_port, guest: 8001, host: 8001, id: 'jupyter'
  config.vm.network :forwarded_port, guest: 27017, host: 27017, id: 'mongod'
  config.vm.network :forwarded_port, guest: 3100, host: 3100, id: 'mongoku'
  config.vm.network :forwarded_port, guest: 7474, host: 7474, id: 'neo4j'
  config.vm.network :forwarded_port, guest: 5432, host: 5432, id: 'postgres'
  config.vm.network :forwarded_port, guest: 5050, host: 5050, id: 'pgadmin'
  config.vm.network :forwarded_port, guest: 8087, host: 8087, id: 'riak-protocol-buffer'
  config.vm.network :forwarded_port, guest: 8098, host: 8098, id: 'riak-http'
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'

  config.vm.provision "file", source: "resources", destination: "/home/vagrant/resources"  
  config.vm.provision "shell", path: "scripts/install.sh"
  config.vm.provision "shell", inline: "rm -rf /home/vagrant/resources"
end
