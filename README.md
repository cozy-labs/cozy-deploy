# [Cozy](https://cozy.io) Deploy

Deploy, manage and monitor multiple Cozies. Docker powered.

![gif](http://kload.fr/cozy-deploy.gif)

## Requirements

* A GNU/Linux system capable of running Docker 1.5+ (only tested on Ubuntu 14.04 x64 though)


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
wget -qO- https://raw.github.com/cozy-labs/cozy-deploy/master/bash_completion > /etc/bash_completion.d/cozy-deploy

# Initialize Nginx configuration
cozy-deploy init

# Pull the latest Cozy image
cozy-deploy pull

# OR build it manually
cozy-deploy build
```


## Usage

Manage your Cozy by their domain name.

```bash
cozy-deploy deploy my.cozy.example.com
```

Once deployed, if you have **properly set your DNS**, this Cozy will be accessible at https://my.cozy.example.com    
It may take a while for your Cozy to fully initialize.

From there, you can display logs, update, monitor or open a shell on this Cozy. Here is the full set of commands:
```
Usage: cozy-deploy COMMAND [domain]

Options:
    help                          Print the list of commands
    init                          Initialize Nginx proxy configuration in /etc/nginx/conf.d/cozy-deploy.conf
    pagekite-init                 Initialize PageKite configuration in /root/.pagekite.rc
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


## PageKite

Cozy Deploy provides a [PageKite](https://pagekite.net) seemless integration.    
Subscribe to a PageKite account, [get your Kite Secret](https://pagekite.net/home/#show_account_details), and save your settings on your host by running:

```bash
cozy-deploy pagekite-init
```

Then you will be able to deploy containers accessible to the Internet without having to deal with DNS or port opening.    

Just indicate a new PageKite domain (like `xxx-myaccount.pagekite.me`) and follow the instructions:

```bash
cozy-deploy deploy xxx-myaccount.pagekite.me
```

**Note**: Using `xxx-myaccount.pagekite.me` will deploy an HTTPS-ready container, and `xxx.myaccount.pagekite.me` will deploy an HTTP one.


## SSL certificates

SSL Certificates are located in `/etc/cozy-deploy/ssl/`.    

By default all the certificates are self-signed, except on PageKite domains. Just change one of them and restart Nginx if you want to use your own certificate.


## Bash/ZSH completion

The `bash_completion` file is automatically copied in `/etc/bash_completion.d/`. Nothing further to do on Bash.

If you are on ZSH and you want to enjoy `cozy-deploy` command completion, add this to you `.zshrc`:
```
autoload bashcompinit
bashcompinit
source /etc/bash_completion.d/cozy-deploy
```


## Upgrading

```bash
cozy-deploy update-image
```

It will update the `cozy-deploy` executable and pull the latest version of the Docker image.


## Hack

Just edit `/usr/local/bin/cozy-deploy` and you are good to go!


## Security

Cozies are running on high ports (>`49000`). Make sure that you close them and let only `80` and `443` open.


## TODO

* Backup/restore
* Snapshot (via docker commit and tags)


---


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
* Posting issues on the [Github repos](https://github.com/cozy/)
* Mentioning us on [Twitter](http://twitter.com/mycozycloud)
