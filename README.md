# cutlery Docker toolkit

![alt text](http://seges.github.io/cutlery/images/logo.png "cutlery")

Set of tools to help to work with Docker, orchestration, service discovery, etc... suitable to be installed on server but as well on developer's machine.

Cutlery is capable of preparing following scenario:

* start [Consul](http://www.consul.io) and [Registrator](https://github.com/gliderlabs/registrator) container on the host responsible for Service discovery, DNS resolution of registered services and containers, automated container registration and service lookup
* set up host's DNS resolution of Consul-registered services
* set up central [Ambassador](https://github.com/progrium/ambassadord) responsible for transparently calling services among containers utilizing Consul

It is minimal and sufficient set of containers to allow transparent service discovery independent of your environment.

# Requirements

* bash

# Install

```
curl -L https://github.com/seges/cutlery/raw/master/setup.sh | sudo sh
```

# Run

```
cutlery <command>
```

## Ambassador

```
cutlery ambassador
```

Prepares Ambassador connected to Consul discovery. You can have more ambassadors running at once if you specify different names.

If you need to connect two services, e.g. web to database, you need an ambassador container running and:

* database containing environment variable ```SERVICE_NAME``` or ```SERVICE_<exposed port>_NAME``` definitions in order to register it in Consul, e.g. ```SERVICE_5555_NAME=db``` and publishing port ```-p 5555``` (there is no need to specify exact port)
* web containing environment variable ```BACKEND_<local port>```, e.g. ```BACKEND_5432=db.service.consul``` and link to ambassador - ```--link="ambassador:backends"```

In this scenario, you point all database connections within web container to ```backends:5432``` and Ambassador container ensures proxying of the request to database container with proper port resolution, because it discovers it from Consul service entry for ```db.service.consul``` - the IP and port. Thus you don't need to explicitly bind ports to host and keep the scalability at maximum level.

Link alias ```backends``` is automatically added to container's ```/etc/hosts``` with the IP of Ambassador to handle the proxying.

## Discovery

```
cutlery discovery
```

Prepares Consul with Registrator to support Docker service discovery. 

It has possibility to register DNSmasq entry to redirect all requests from host pointing to 'service.consul' domain to running Consul.

If you want to start service discovery on the host with public IP 10.20.30.40 which is standalone (e.g. your development environment), execute:

```
cutlery discovery start "-advertise 10.20.30.40 -bootstrap"
```

You can provide usual Consul arguments and they will be passed to the container upon startup.

Every container containing ```SERVICE_NAME``` or ```SERVICE_<exposed port>_NAME``` environment variables will be registered in Consul by Progrium's Registrator.

### Host DNS resolution

There are situations (especially in development) when you want to access services from host which are registered in Consul by their appropriate DNS names (e.g. ```db.service.consul```). You have the possibility to add an entry into your host's ```/etc/hosts``` file but that is cumbersome and might contain stale data after some time. In case you are using NetworkManager or standalone DNSmasq, Cutlery can register route to DNSmasq to resolve all ```service.consul``` domain names to Consul container.

```
cutlery discovery register
```

The command restarts networking in order to be applied.

### DNS firewall access

!!! TBD

```
cutlery discovery fw
```

## Global DNS

```
cutlery global-dns
```

Sets default DNS for Docker containers on the host.

(!) *Beware it restarts Docker*

So for example if you want to register default DNS for containers that will be published on Docker's bridge IP, you execute:

```
cutlery global-dns docker0
```

