#!/bin/bash

set -e

# Color messages if run in a TTY
if [ -t 1 ]; then
    cyan='\e[0;36m'
    green='\e[0;32m'
    red='\e[0;31m'
    white='\e[0m'
else
    cyan='\e[0m'
    green='\e[0m'
    red='\e[0m'
    white='\e[0m'
fi

# Check that the script is running as root
if [ "$(id -u)" != "0" ]; then
   echo -e "${red}This script must be run as root${white}" 1>&2
   exit 1
fi

# Check version
lsb_release -a | grep -q 14.04
if [ $? -ne 0 ]; then
    echo -e "${red}Error: cozy-deploy is only compatible with Ubuntu 14.04${white}" 1>&2
    exit 1
else
    echo -e "${red}This script will install and configure Nginx and Docker on your system."
    echo -e "/!\ Do not trust this script unless you have read it and know what it is doing."
    echo
    echo -e "${cyan}Continuing in 20 seconds${white}"
    sleep 20
fi

# Add Nginx 1.6 repository
echo -e "${cyan} > Adding Nginx repository (1/5)${white}"
apt-get update --quiet > /dev/null
apt-get install --quiet --yes --force-yes \
  software-properties-common \
  python-software-properties \
  bash-completion \
  openssl \
  wget
add-apt-repository -y ppa:nginx/stable

# Add Docker repository
echo -e "${cyan} > Adding Docker repository (2/5)${white}"
echo "deb https://get.docker.com/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Install Nginx (1.6+) and Docker (1.5+)
echo -e "${cyan} > Installing Docker and Nginx (3/5)${white}"
apt-get update --quiet > /dev/null
apt-get install --quiet --yes --force-yes nginx lxc-docker

# Make sure docker service is running
service docker restart
sleep 20

# Copy executables
cp cozy-deploy /usr/local/bin/cozy-deploy \
|| wget -qO- https://raw.github.com/cozy-labs/cozy-deploy/master/cozy-deploy > /usr/local/bin/cozy-deploy

cp bash_completion /etc/bash_completion.d/cozy-deploy \
|| wget -qO- https://raw.github.com/cozy-labs/cozy-deploy/master/bash_completion > /etc/bash_completion.d/cozy-deploy

# Initialize Nginx configuration and fetch the base container
echo -e "${cyan} > Initializing Nginx configuration (4/5)${white}"
cozy-deploy init
echo -e "${cyan} > Downloading Cozy official Docker image (5/5)${white}"
cozy-deploy pull
