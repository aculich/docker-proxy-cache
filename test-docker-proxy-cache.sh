#!/bin/bash

CID=$(docker ps -q proxy)
IPADDR=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
echo "export http_proxy=http://${IPADDR}:3128/ containerip=${IPADDR}"
export http_proxy=http://${IPADDR}:3128/ containerip=${IPADDR}
squidclient -h ${IPADDR} mgr:info
URL=http://us.archive.ubuntu.com/ubuntu/pool/main/w/wget/wget_1.15-1ubuntu1_amd64.deb
http_proxy=http://${IPADDR}:3128/ wget -O/dev/null $URL
squidclient -h ${IPADDR} -m PURGE $URL
http_proxy=http://${IPADDR}:3128/ wget -O/dev/null $URL
http_proxy=http://${IPADDR}:3128/ wget -O/dev/null $URL
