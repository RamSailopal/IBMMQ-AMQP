#!/bin/bash
#
#   Set up AMQP channel
#
#   Run as user Ram
#
cd /opt/mqm/bin
. setmqenv -s
#
#   Create the queue manager
#
crtmqm QM2
#
#   Start the queue manager
#
strmqm QM2
#
#   Alter/Enable the IBMMQ AMQP channel type reading in commands from /home/data/AMQP.mqsc
#
runmqsc QM2 < /home/data/AMQP.mqsc
#
#   Set permissions on channel
#
setmqaut -m QM2 -t topic -n SYSTEM.BASE.TOPIC -p app -all +pub +sub
setmqaut -m QM2 -t qmgr -p app -all +connect
#
#   Install node to demonstrate sending/receiving to queue
#
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 20
cd /home/ram
npm install mqlight