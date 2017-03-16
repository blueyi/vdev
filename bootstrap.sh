#!/usr/bin/env bash

# Add the code to Vagrantfile
# config.vm.provision :shell, path: "bootstrap.sh"

# change source mirror
cd /etc/apt/
mv sources.list sources.list.bak
bash -c "cat /vagrant/sources.list.cn > sources.list"
apt-get update -y
# apt-get upgrade -y

# install build tools
apt-get install -y make build-essential linux-headers-`uname -r` libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils

# install useful tools
apt-get install -y git vim exuberant-ctags wget curl

# git configure


# c/c++ env
apt-get install gcc g++ cmake gdb

# python env
apt-get install -y python
# install pyenv
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

# .bashrc vimplugin config
git clone https://github.com/blueyi/my-utils.git ~/.my-utils
python ~/.my-utils/common/createSoftLink.py
python ~/.my-utils/common/vimPlugin.py

source ~/.bashrc
# 
# # install python
pyenv install 2.7.13


# install apache2
# apt-get install -y apache2
# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

# install nginx
# apt-get install -y nginx git


