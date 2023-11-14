#!/bin/bash
#
# Run an example node app to receive messages from the default AMQP queue
#
# Run as user Ram
#   
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
cd /home/ram/node_modules/mqlight/samples
node recv.js -t Test -s amqp://app:test@localhost:5672