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

Prepares Ambassador connected to Consul discovery.

## Discovery

```
cutlery discovery
```

Prepares Consul with Registrator to support Docker service discovery. 

It has possibility to register DNSmasq entry to redirect all requests from host pointing to 'service.consul' domain to running Consul.

## Global DNS

```
cutlery global-dns
```

Sets default DNS for Docker containers on the host.

(!) *Beware it restarts Docker*

