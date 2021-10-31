# NoSQL Box

Vagrant to create a Ubuntu local box used to play with the following NoSQL databases:

- Postgres
- Riak
- Cassandra
- Mongodb
- Neo4j

Additional info can be found in the following repo: https://github.com/dvillaj/NoSQL-Services

## Install

```
vagrant up
```

## Jupyter Lab

http://localhost:8001


## Monitoring

http://localhost:61208


## SSH Config

Fix `~\.ssh\config` 

```
Host localhost
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null
        LogLevel=error
```