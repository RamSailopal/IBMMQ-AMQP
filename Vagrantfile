
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.network "forwarded_port", guest: 9443, host: 9443
  config.vm.network "forwarded_port", guest: 52785, host: 52785
  config.vm.synced_folder "mount/", "/home/data"
  config.vm.boot_timeout = 600
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt update
    sudo useradd mqclient
    (echo "test";echo "test") | sudo passwd -q mqclient
    sudo useradd app
    (echo "test";echo "test") | sudo passwd -q app
    sudo adduser app mqclient
    cd /tmp
    cp /home/data/9.3.4.0-IBM-MQ-Advanced-for-Developers-UbuntuLinuxX64.tar.gz .
    tar -xvf 9.3.4.0-IBM-MQ-Advanced-for-Developers-UbuntuLinuxX64.tar.gz
    cd MQServer/
    (sleep 1;echo "1";sleep 1;echo "") | sudo ./mqlicense.sh
    sudo echo "deb [trusted=yes] file:/tmp/MQServer ./" > /etc/apt/sources.list.d/ibmmq-install.list
    sudo apt update
    #
    # Need to make sure that ibmmq-amqp exists for amqp to work.
    #
    sudo apt install -y "ibmmq-*"
    sudo chmod +x /opt/mqm/bin/strmqm
    sudo chmod +x /opt/mqm/bin/crtmqm
    sudo cp /opt/mqm/web/mq/samp/configuration/basic_registry.xml /var/mqm/web/installations/Installation1/servers/mqweb/mqwebuser.xml
    sudo chown mqm.mqm /var/mqm/web/installations/Installation1/servers/mqweb/mqwebuser.xml
    sudo useradd ram -m -G mqm
  SHELL
end
