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

    mkdir -p /opt/compose
    chown learner:learner /opt/compose

    su - learner -c "cd; mkdir notebooks; touch notebooks/.install"
}

function installSystemPackages {
    echo "Instaling system packages from packages.conf  ..."

    apt -qq update
    apt install -y $(grep -vE "^\s*#" resources/system/packages.conf  | tr "\n" " ")
}

function installNodeJs {
    echo "Instaling NodeJs"

    curl -sL https://deb.nodesource.com/setup_14.x -o ~/nodesource_setup.sh
    bash ~/nodesource_setup.sh
    apt install -y nodejs
    rm ~/nodesource_setup.sh
}

# Python 3.6 is needed for riak
function installPython3.6 {
    echo "Instaling python 3.6 ..."

    # http://lavatechtechnology.com/post/install-python-35-36-and-37-on-ubuntu-2004/

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
    echo "Instaling python packages from requeriments.txt ..."

    su learner -c "source /home/learner/venv/bin/activate;  pip install -r resources/system/requeriments.txt"
}


function installJupyterLabExtensions_Learner {
    echo "Installing lab extensions ..."

    source /home/learner/venv/bin/activate

    # export jupyter notebooks with images embebed
    # Version 0.5.1 
    pip install jupyter_contrib_nbextensions
    jupyter contrib nbextension install --user

    pip install jupyter_nbextensions_configurator
    jupyter nbextensions_configurator enable --user


    echo "Git Client"
    pip install jupyterlab-git
    jupyter lab build

    echo "Table of Contents"
    jupyter labextension install @jupyterlab/toc

    echo "Drawio"
    jupyter labextension install jupyterlab-drawio

    echo "Variable Inspector"
    jupyter labextension install @lckr/jupyterlab_variableinspector
}

function installJupyterLabExtensions {
    export -f installJupyterLabExtensions_Learner
    su learner -c "bash -c installJupyterLabExtensions_Learner"
}

function serviceJupyterLab {
    echo "Config Jupyter Lab ..."

    mkdir /etc/jupyter
    cp resources/system/start-jupyter.sh /usr/local/bin
    chmod a+x /usr/local/bin/start-jupyter.sh
    cp resources/system/jupyter.service /etc/systemd/system/

    systemctl enable jupyter.service
    systemctl daemon-reload
    systemctl start jupyter.service
}


echo "Setting up NoSQL box ..."

addLocalUser
installSystemPackages
installNodeJs
installPython3.6
installDocker
installPythonPackages
installJupyterLabExtensions
serviceJupyterLab