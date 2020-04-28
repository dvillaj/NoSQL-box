$script_install = <<-SCRIPT
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt install -y docker-ce

  sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  sudo apt install -y postgresql-client jq

  sudo apt install -y libpq-dev python-dev python3-pip
  pip3 install -U pip
  pip3 install jupyterlab pandas sqlalchemy ipython-sql psycopg2 bottle pprintpp matplotlib wordcloud openpyxl xlrd riak cassandra-driver \
               pymongo py2neo==3.1.2 ipython-cypher networkx jgraph python-igraph
  pip3 install --upgrade requests
  
  git clone https://github.com/dvillaj/ipython-cql.git
  cd ipython-cql
  sudo python3 setup.py install
  cd ..
  rm -rf ipython-cql


SCRIPT


$script_learner = <<-SCRIPT
  sudo useradd -m -s /bin/bash  learner
  echo learner:learner | sudo chpasswd
  sudo usermod -aG sudo learner
  sudo usermod -aG docker learner

  sudo cp -r resources/learner /home
  sudo chmod +x /home/learner/*.sh
  sudo mv /home/learner/start-jupyter.sh /usr/local/bin

  sudo su - learner -c "mkdir ~/.ssh; chmod 700 ~/.ssh"
  sudo cp .ssh/authorized_keys /home/learner/.ssh

  sudo chown -R learner:learner /home/learner

  sudo su - learner -c "cd; jupyter lab --generate-config"
  sudo sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '0.0.0.0'/" /home/learner/.jupyter/jupyter_notebook_config.py
  sudo sed -i "s/#c.NotebookApp.token = '<generated>'/c.NotebookApp.token = ''/" /home/learner/.jupyter/jupyter_notebook_config.py
  sudo sed -i "s/#c.NotebookApp.password = u''/c.NotebookApp.password = u''/" /home/learner/.jupyter/jupyter_notebook_config.py
  echo "c.NotebookApp.nbserver_extensions.append('ipyparallel.nbextension')" | sudo tee -a /home/learner/.jupyter/jupyter_notebook_config.py
  
  sudo cp resources/jupyter.service /etc/systemd/system/
  sudo systemctl enable jupyter.service
  sudo systemctl daemon-reload
  sudo systemctl start jupyter.service

  sudo mkdir -p /opt/compose
  sudo chown learner:learner /opt/compose

  sudo su - learner -c "cd; mkdir notebooks; touch notebooks/.install"

  echo "source ~/.environment" | sudo tee -a /home/learner/.bashrc
  
  rm -rf resources
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-18.04"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "TallerNoSQL_v3.1"
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

  config.vm.provision "shell", inline: $script_install
  config.vm.provision "file", source: "resources", destination: "/home/vagrant/resources"  
  config.vm.provision "shell", inline: $script_learner

end
