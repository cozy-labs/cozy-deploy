# Cozy Deploy

Deploy, manage and monitor multiple Cozies. Docker powered.


## Requirements

* An Ubuntu 14.04 host (only tested on `x64`)


## Installing

* Automatic install

```bash
wget -qO- https://raw.github.com/cozy-labs/cozy-deploy/master/install.sh | sudo bash
```

* Manual install
```bash
# Install Nginx (1.6+ recommended)
add-apt-repository -y ppa:nginx/stable
apt-get install nginx

# Install docker (1.5+ required)
echo "deb https://get.docker.com/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
apt-get install lxc-docker

# Copy cozy-deploy executable
wget -qO- https://raw.github.com/cozy-labs/cozy-deploy/master/cozy-deploy > /usr/local/bin/cozy-deploy

# Copy bash_completion
https://raw.github.com/cozy-labs/cozy-deploy/master/bash_completion > /etc/bash_completion.d/cozy-deploy

# Initialize Nginx configuration
cozy-deploy init

# Pull the latest Cozy image
cozy-deploy pull

# OR build it manually
cozy-deploy build
```


## Upgrading

```bash
cozy-deploy update-image
```

It will update the `cozy-deploy` script and pull the latest version of the Docker image.


## Usage

Manage your Cozy by their domain name.

```bash
cozy-deploy my.cozy.example.com
```

Once deployed, if you have **properly set your DNS**, this Cozy will be accessible at https://my.cozy.example.com
It may take a while for your Cozy to fully initialize.

From there, you can display logs, update, monitor or open a shell on this Cozy. Here is the full set of commands:
```
Usage: cozy-deploy COMMAND [domain]

Options:
    help                          Print the list of commands
    commands                      Print the list of commands
    init                          Initialize Nginx proxy configuration in /etc/nginx/conf.d/cozy-deploy.conf
    pull                          Fetch the latest cozy/full official image from Docker Hub
    build                         Build a cozy/full image manually from the GitHub repository https://github.com/cozy-labs/cozy-docker
    update-image                  Update cozy-deploy and the base image

    list                          List deployed Cozies
    list-domains                  Only list domain names associated with actual Cozies
    start-all                     Start all previously stopped Cozies
    update-all                    Launch application updates on all the Cozies
    upgrade-all                   Launch a system upgrade on all the Cozies
    monitor                       Monitor resources used by the Cozies or by a specific Cozy

    deploy  <domain>              Deploy a new Cozy container
    remove  <domain>              Remove a Cozy, its data and its configuration
    enter   <domain>              Open a shell in the specified Cozy
    status  <domain>              Show the status of the Cozy's services
    logs    <domain>              Display the last lines of interesting log files in the specified Cozy
    update  <domain>              Launch application updates on a Cozy
    upgrade <domain>              Launch a system upgrade on a Cozy
```


## SSL certificates

Certificates are available in `/etc/cozy-deploy/ssl/`.    
By default all the certificates are self-signed. Just change one of them and restart Nginx if you want to put your own certificate.


## ZSH completion

If you are on ZSH and you want to enjoy `cozy-deploy` command completion, add this to you `.zshrc`:
```
autoload bashcompinit
bashcompinit
source /etc/bash_completion.d/cozy-deploy
```


## Hack

Just edit `/usr/local/bin/cozy-deploy` and you are good to go !


## Security

Cozies are running on high ports (>`49000`). Make sure that you close them and let only `80` and `443` open.


## TODO

* Backup/restore
* Snapshot (via docker commit and tags)
* Pagekite?


## What is Cozy?

![Cozy Logo](https://raw.github.com/mycozycloud/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you
with a new experience. You can install Cozy on your own hardware where no one
profiles you.


## Community

You can reach the Cozy Community by:

* Chatting with us on IRC #cozycloud on irc.freenode.net
* Posting on our [Forum](https://forum.cozy.io)
* Posting issues on the [Github repos](https://github.com/mycozycloud/)
* Mentioning us on [Twitter](http://twitter.com/mycozycloud)
