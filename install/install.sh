sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce

sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
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