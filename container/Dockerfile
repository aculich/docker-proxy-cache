# docker build -t docker-proxy-cache .

FROM ubuntu:utopic

RUN apt-get update && apt-get install -y squid3 iptables
ADD squid.conf /etc/squid3/squid.conf

# The original configuration in squid.conf.dist-utopic is available
# for reference to compare the features added for our customized
# proxying purposes:
#    diff -w -u squid.conf.dist-utopic squid.conf
ADD start-proxy.sh /usr/local/bin/start-proxy.sh

# Allow the host to connect to the standard (non-transparent) proxy port
EXPOSE 3128

CMD ["/usr/local/bin/start-proxy.sh"]
