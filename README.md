# NoSQL Box

Vagrant to create a NoSQL box including:

- Postgres
- Riak
- Cassandra
- Mongodb
- Neo4j
- JupyterLab

This box is based in Ubuntu 20.04 and Docker.

# Dependencies

- [Postgres Docker Compose](https://github.com/dvillaj/compose-postgres)
- [Cassandra Docker Compose](https://github.com/dvillaj/compose-cassandra)
- [MongoDb Docker Compose](https://github.com/dvillaj/compose-mongodb)
- [Neo4j Docker Compose](https://github.com/dvillaj/compose-neo4j)
- [Riak Docker Compose](https://github.com/dvillaj/compose-riak)
- [Riak Docker Image](https://github.com/dvillaj/docker-riak)
- [Cql Python package](https://github.com/dvillaj/ipython-cql.git)
- [Setup script](https://raw.githubusercontent.com/dvillaj/files-repository/master/NoSQL-box/setup.sh)

# TODO

- Riak bug (Python 3.8)


## Install

`vagrant up`

The build process expect to have a public key in ~/.ssh (id_rsa & id_rsa.pub) 

## Access to the machine

User: `learner`
Password: `learner`


`ssh learner@localhost -p 2222`


## Environment variables

```
alias postgres="docker-compose -f /opt/compose/compose-postgres/docker-compose.yml"
alias riak="docker-compose -f /opt/compose/compose-riak/docker-compose.yml"
alias riak-admin="docker exec -it compose-riak_coordinator_1 riak-admin"
alias cassandra="docker-compose -f /opt/compose/compose-cassandra/docker-compose.yml"
alias mongo="docker-compose -f /opt/compose/compose-mongodb/docker-compose.yml"
alias neo4j="docker-compose -f /opt/compose/compose-neo4j/docker-compose.yml"
```

## Jupyter Lab

http://localhost:8001

## Postgres

### Up

```
postgres up -d
```

### Down

```
postgres down
```

### pgAdmin 4

http://localhost:5050

User: `pgadmin4@pgadmin.org`  
Password: `admin`

To connect with the postgres server create a new Server Connection using the following parameters:

```
General/Name: postgres
Connection/Host: postgres
Connection/Username: postgres
Connection/Password: postgres
```

## Riak


### Coordinator / Up

```
riak up -d coordinator
```

### Scale the Cluster (4 members)

```
riak up -d --scale member=4
```

### Down

```
riak down
```


### Admin Riak

http://localhost:8098/admin/



## Cassandra


### Up

```
cassandra up -d
```

### Down

```
cassandra down
```



## MongoDb

Download latest version of [Robo 3T](https://robomongo.org/) and connect to Mongo: `localhost:27017`

### Up

```
mongo up -d
```

### Down

```
mongo down
```

### Mongo Client

http://localhost:3100/


## Neo4j

http://localhost:7474

### Up

```
neo4j up -d
```

### Down

```
neo4j down
```


## JupyterLab

### Logging

```
sudo journalctl -f -u jupyter
```