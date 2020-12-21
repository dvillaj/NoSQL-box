function addLocalUser {
    echo "Adding learning user ..."

    useradd -m -s /bin/bash  learner
    echo learner:learner | chpasswd

    cp -r resources/learner /home
    chmod +x /home/learner/*.sh

    usermod -aG sudo learner

    su - learner -c "mkdir ~/.ssh; chmod 700 ~/.ssh"
    cp .ssh/authorized_keys /home/learner/.ssh

    chown -R learner:learner /home/learner

    echo "source ~/.environment" | tee -a /home/learner/.bashrc

    mkdir -p /opt/compose
    chown learner:learner /opt/compose

    su - learner -c "cd; mkdir notebooks; touch notebooks/.install"
}

function installSystemPackages {
    echo "Instaling system packages ..."

    apt -qq update
    apt install -qq -y autoconf automake libtool build-essential libssl-dev libffi-dev libpq-dev python3-virtualenv jq
}

function installNodeJs {
    echo "Instaling NodeJs"

    curl -sL https://deb.nodesource.com/setup_14.x -o ~/nodesource_setup.sh
    bash ~/nodesource_setup.sh
    apt install -y nodejs
    rm ~/nodesource_setup.sh
}

function installPython3.6 {
    echo "Instaling python 3.6"

    add-apt-repository -y ppa:deadsnakes/ppa
    apt -qq update
    apt install -y python3.6 python3.6-dev

    su - learner -c "virtualenv -p /usr/bin/python3.6 /home/learner/venv"
}


function installDocker {
    echo "Installing docker ..."

    
    apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt install -qq -y docker-ce

    echo "Installing docker compose ..."

    curl -sL https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    usermod -aG docker learner
}


function installPythonPackages {
    echo "Instaling python packages"

    su - learner -c "source /home/learner/venv/bin/activate; pip install -r /home/vagrant/resources/python/requeriments.txt"
    su - learner -c "source /home/learner/venv/bin/activate; pip install git+https://github.com/dvillaj/ipython-cql.git"
}



function configJupyterLab {
    echo "Config Jupyter Lab ..."

    mv /home/learner/start-jupyter.sh /usr/local/bin

    su - learner -c "source /home/learner/venv/bin/activate; cd; jupyter lab --generate-config"
    cat /home/vagrant/resources/python/jupyter.config >> /home/learner/.jupyter/jupyter_notebook_config.py

    cp resources/jupyter.service /etc/systemd/system/
    systemctl enable jupyter.service
    systemctl daemon-reload
    systemctl start jupyter.service
}

echo "Installing ..."


addLocalUser
installSystemPackages
installNodeJs
installPython3.6
installDocker
installPythonPackages
configJupyterLab

# jupyter lab build