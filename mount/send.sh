#!/bin/bash
#
#   Run an example node app to send a messages "Hello world" to the default AMQP queue
#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
cd /home/ram/node_modules/mqlight/samples
node send.js -s amqp://app:test@localhost:5672