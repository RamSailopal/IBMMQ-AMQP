# Demonstration of AMQP compatibility with IBMMQ

## Setup

With [Vagrant](https://www.vagrantup.com/) and [Oracle](https://www.virtualbox.org/) Virtual Box installed:

    git clone https://github.com/Keyzo-IT/IBMMQ-AMQP/blob/main/docker-compose.yml
    cd IBMMQ-AMQP

Get a copy of the latest IBMMQ developer tar file from [here](https://www.ibm.com/docs/en/ibm-mq/9.3?topic=roadmap-mq-downloads&cm_sp=ibmdev-_-developer-articles-_-ibmcom) i.e. in this case **9.3.4.0-IBM-MQ-Advanced-for-Developers-UbuntuLinuxX64.tar.gz** and place it in the mount folder (**NOTE** - the name of the tar file may need changing in the **Vagrantfile**)

Run:

    vagrant up

Once provisioned, log into the environment and change to the user **ram**

    vagrant ssh
    sudo su ram
    bash
    cd /home/data
    ./QM1.sh
    ./QM2.sh

The script **QM1.sh** will create and setup a new "standard" IBMMQ queue manager as well as starting the web interface. **QM2.sh** will create an additional queue manager QM2 and set this up for AMQP pub/sub communications. The script will also install node as well as the node [mqlight](https://github.com/mqlight/nodejs-mqlight) library to demonstrate the queue in action.

## Creating a new Topic

Log onto the IBMMQ web interface on https://localhost:9443

username: **mqadmin**
password: **mqadmin**

Click:

* Manage
    * Local queue managers
        * QM2
            * Events
                * Create

Add a new topic called *Test*

## Subscribing to the Topic

Back on you Vagrant terminal, run:

    ./recv.sh

This will open a subscription connection to the Test topic just created

## Publishing a message via the UI

In the IBMMQ web UI, navigate to:

* Manage
    * Local queue managers
        * QM2
            * Events
                * Test

Click on the subscription listed and then **Create**

Input some text for a sample message and click **Put**

The message should appear in your terminal.

## Publishing messages with nodejs

Open another terminal Window, navigate to the repo directory and then:

    vagrant ssh
    sudo su ram
    bash
    cd /home/data
    ./send.sh

This will send a "Hello World!" message to the Test topic and it should show in the other "receiving" terminal





