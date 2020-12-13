# NoSQL Box

Vagrant to create a NoSQL box 

- Postgres
- Riak
- Cassandra
- Mongodb
- Neo4j

This box is based in Ubuntu 18.04 and Docker.

# Dependencies

- https://github.com/dvillaj/compose-postgres
- https://github.com/dvillaj/compose-riak
- https://github.com/dvillaj/compose-cassandra
- https://github.com/dvillaj/compose-mongodb
- https://github.com/dvillaj/compose-neo4j
- https://github.com/dvillaj/docker-riak
- https://github.com/dvillaj/ipython-cql.git

## Install

`vagrant up`

The build process expect to have a public key in ~/.ssh (id_rsa & id_rsa.pub) 

## Access to the machine

User: `learner`
Password: `learner`


`ssh learner@localhost -p 2222`


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
