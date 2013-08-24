# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provision :shell, :path => "puppet/puppet-install.sh"

  config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.options = ["--verbose"]
  end

  config.vm.provider :virtualbox do |vb|
    vb.name = "mytechbooks"
    vb.customize ["modifyvm", :id,
                 "--memory", "1024",
                 "--cpus", "2",
                 "--nictype1", "Am79C973",
                 "--nictype2", "Am79C973",
                 "--natdnshostresolver1", "on"]
  end

  config.vm.box = "basedevel"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 9293, host: 9292, :auto => true
  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.synced_folder "..", "/home/vagrant/apps", :nfs => true

  # config.vm.synced_folder "../data", "/vagrant_data"
end
