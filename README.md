1. Install docker (assuming you are using [BCE in VirtualBox](http://collaboratool.berkeley.edu/using-virtualbox.html)): `sudo apt-get install -y docker.io`
2. Give yourself permissions to run docker: `sudo adduser $USER docker`
3. Restart your shell/GUI or: `newgrp docker`
4. Pull an ubuntu docker image in the background while you complete
   the steps after this: `docker pull ubuntu:utopic`
4. Clone the repository: `git clone https://github.com/aculich/docker-proxy-cache`
5. Change to: `cd docker-proxy-cache/container`
6. Build the docker container: `docker build -t docker-proxy-cache .`
7. Assuming you are still on the container directory go back one dir: `cd ..`
8. Start the proxy-cache with: `sh ./run-docker-proxy-cache.sh`
   If your CACHEDIR is not in /cache/proxy/squid3 then you'll need to
   specify it when running: `CACHEDIR=/foo/bar/baz sh ./run-docker-proxy-cache.sh`
9. In another shell test if the proxy cache might be running properly: `./test-docker-proxy-cache.sh`
