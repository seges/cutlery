#!/bin/bash

cd /usr/local
if [ -x /usr/local/cutlery ]; then
	cd cutlery
	git pull
else
	git clone https://github.com/seges/cutlery.git
fi

[ ! -x /usr/local/bin/cutlery ] && ln -s /usr/local/cutlery/bin/cutlery /usr/local/bin/cutlery || echo "cutlery already linked"
