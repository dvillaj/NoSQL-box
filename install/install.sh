echo "Installing docker ..."
apt -qq update
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt install -qq -y docker-ce

echo "Installing docker compose ..."
curl -sL https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Instaling postgress client ..."
apt install -qq -y postgresql-client jq

echo "Instaling python packages"
apt install -qq -y libpq-dev python-dev python3-pip
pip3 install -U pip
pip3 install -r /home/vagrant/resources/python/requeriments.txt
pip3 install -U requests
  
git clone https://github.com/dvillaj/ipython-cql.git
cd ipython-cql
python3 setup.py install
cd ..
rm -rf ipython-cql