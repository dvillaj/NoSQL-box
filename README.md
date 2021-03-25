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



## Setup Ports by SSH Tunnelling


Replace `<MACHINE_IP>` with the real Box's IP

```
ssh -N -L 8001:127.0.0.1:8001 \
             -L 3100:127.0.0.1:3100 \
             -L 27017:127.0.0.1:27017 \
             -L 7474:127.0.0.1:7474 \
             -L 5050:127.0.0.1:5050 \
             -L 8098:127.0.0.1:8098 \
             -L 8082:127.0.0.1:8082 \
             -L 7687:127.0.0.1:7687 \
            learner@<MACHINE_IP>
```

## Jupyter Lab

http://localhost:8001