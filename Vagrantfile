Vagrant.configure("2") do |config|

  # Ubuntu 20.04
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "nosql-box"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "NoSQL_Box"
    vb.cpus = 2
    vb.memory = 3048
  end

  # Ports
  config.vm.network :forwarded_port, guest: 8082, host: 8082, id: 'bottle'
  config.vm.network :forwarded_port, guest: 8001, host: 8001, id: 'jupyter'
  config.vm.network :forwarded_port, guest: 27017, host: 27017, id: 'mongod'
  config.vm.network :forwarded_port, guest: 3100, host: 3100, id: 'mongoku'
  config.vm.network :forwarded_port, guest: 7474, host: 7474, id: 'neo4j'
  config.vm.network :forwarded_port, guest: 7687, host: 7687, id: 'bolt'
  config.vm.network :forwarded_port, guest: 5432, host: 5432, id: 'postgres'
  config.vm.network :forwarded_port, guest: 5050, host: 5050, id: 'pgadmin'
  config.vm.network :forwarded_port, guest: 8087, host: 8087, id: 'riak-protocol-buffer'
  config.vm.network :forwarded_port, guest: 8098, host: 8098, id: 'riak-http'
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'


  config.vm.provision "file", source: "public-keys", destination: "~/.ssh/me.pub"
  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/me.pub >> /root/.ssh/authorized_keys
    rm /home/vagrant/.ssh/me.pub
  SHELL

 
  config.vm.synced_folder "shared/deploy", "/opt/deploy"
  config.vm.provision "shell", inline: "/opt/deploy/install.sh"

end