#!/bin/bash
#
#   Set up standard IBMMQ channel
#
#   Run as user ram
#
#
#   Need to do next step in every shell before interacting with IBMMQ
#
cd /opt/mqm/bin
. setmqenv -s
#
#   Create Queue manager QM1
#
crtmqm QM1
#
#   Start the queue
#
strmqm QM1
cd /tmp
#
#   Get some sample config
#   
wget mq-dev-config.mqsc https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/mqsc/mq-dev-config.mqsc
#
#   Add the sample config to the queue
#
runmqsc QM1 < "./mq-dev-config.mqsc"
runmqsc QM1 < /home/data/MQ.mqsc
cd /opt/mqm/bin
#
#   Set the permissions on the queue fort adding and reading
#
./setmqaut -m QM1 -t qmgr -g mqclient +connect +inq
./setmqaut -m QM1 -n DEV.** -t queue -g mqclient +put +get +browse +inq
#
#   Need environmental variables before interating with queue
#
export MQSERVER='DEV.APP.SVRCONN/TCP/localhost(1414)'
export MQSAMP_USER_ID='app'
cd /opt/mqm/samp/bin
(echo "test";echo "This is a test";echo "") | ./amqsputc DEV.QUEUE.1 QM1
(echo "test") | ./amqsgetc DEV.QUEUE.1 QM1
#
#   Start the web server
#
cd /opt/mqm/bin
./strmqweb
#
#   Ensure that the web server is listening on all interfaces not just the local one.
#
./setmqweb properties -k httpHost -v "*"
