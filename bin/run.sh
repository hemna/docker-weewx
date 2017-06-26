#!/usr/bin/env bash

service apache2 start

# HOME=/home/weewx is set by the Dockerfile but can be overridden in run command
echo "using $CONF"

cp -rv $HOME/conf/$CONF/* /home/weewx/

CONF_FILE=$HOME/weewx.conf

ls -la
ls -al $HOME/bin

cd $HOME
CMD="$HOME/weewx/bin/weewxd $CONF_FILE"
echo "Running '$CMD'"

$HOME/bin/weewxd $CONF_FILE
