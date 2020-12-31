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

### Box's IP

```
vagrant ssh -c "hostname -I |  cut -d' ' -f2" 2>/dev/null
``` 


## Setup Ports by NAT

```
vagrant halt

VBoxManage modifyvm "NoSQL_Box" --natpf1 "bolt,tcp,,7687,,7687"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "bottle,tcp,,8082,,8082"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "jupyter,tcp,,8001,,8001"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "mongod,tcp,,27017,,27017"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "mongoku,tcp,,3100,,3100"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "neo4j,tcp,,7474,,7474"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "postgres,tcp,,5432,,5432"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "pgadmin,tcp,,5050,,5050"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "riak-protocol-buffer,tcp,,8087,,8087"
VBoxManage modifyvm "NoSQL_Box" --natpf1 "riak-http,tcp,,8098,,8098"
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