#!/bin/bash

ping -c 1 www.google.es > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: No Internet connection."
    exit 2
fi

while [ ! -f /home/learner/notebooks/.install -a  "$1" != "-f" ]; do
    read -p "This process downloads the latest version of the notebooks (deleting the current ones). Continue? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done

rm -rf /opt/compose/compose*

git clone https://github.com/dvillaj/compose-postgres.git /opt/compose/compose-postgres 
git clone https://github.com/dvillaj/compose-riak.git /opt/compose/compose-riak
git clone https://github.com/dvillaj/compose-cassandra /opt/compose/compose-cassandra
git clone https://github.com/dvillaj/compose-mongodb.git /opt/compose/compose-mongodb
git clone https://github.com/dvillaj/compose-neo4j /opt/compose/compose-neo4j


if [ -f /home/learner/notebooks/.install ]; then
    docker pull postgres:12.2
    docker pull dpage/pgadmin4:4.20
    docker pull dvillaj/riak
    docker pull cassandra:3.11
    docker pull mongo:4.2.5
    docker pull neo4j:3.5.11
    docker pull huggingface/mongoku:1.3.0
fi

rm -rf /home/learner/notebooks
git clone https://github.com/dvillaj/Taller_BBDD.git /home/learner/notebooks