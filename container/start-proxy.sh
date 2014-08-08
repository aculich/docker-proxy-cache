#!/bin/bash

# Setup the NAT rule that enables transparent proxying
NORMAL_PORT=3128
TRANSPARENT_PORT=3129
IPADDR=$(/sbin/ip -o -f inet addr show eth0 | awk '{ sub(/\/.+/,"",$4); print $4 }')
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination ${IPADDR}:${TRANSPARENT_PORT}

# ensure proper directory ownership
chown -R proxy.proxy /var/spool/squid3

# pre-generate cache directories if they don't already exist
[ -e /var/spool/squid3/swap.state ] || squid3 -z 2>/dev/null

# Run squid and tail the logs
squid3 -N -d 9 &

echo "Transparent proxying enabled on port ${TRANSPARENT_PORT} of ${IPADDR}"
echo "For non-transparent proxy use:"
echo "    export http_proxy=http://${IPADDR}:${NORMAL_PORT}/"
echo "or"
echo "    http_proxy=http://${IPADDR}:${NORMAL_PORT}/ wget"
sleep 1
while true; do
    [ -e /var/log/squid3/access.log ] && tail -f /var/log/squid3/*.log
  sleep 1
done
