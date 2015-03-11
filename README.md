# cutlery Docker toolkit

![alt text](http://seges.github.io/images/logo.png "cutlery")

Set of tools to help to work with Docker, orchestration, service discovery, etc...

# Requirements

* bash

# Install

```
curl https://raw.githubusercontent.com/seges/cutlery/master/setup.sh | sudo sh
```

# Run

```
cutlery
```

## Ambassador

Prepares Ambassador connected to Consul discovery.

## Discovery

Prepares Consul with Registrator to support Docker service discovery. It has possibility to register DNSmasq entry to redirect all requests from host pointing to 'service.consul' domain to running Consul.

## Global DNS

Sets default DNS for Docker containers.

(!) *Beware it restarts Docker*

