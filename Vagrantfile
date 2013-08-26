# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  config.vm.provision :shell, :path => "puppet/puppet-install.sh"

  config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.options = ["--verbose"]
  end

  config.vm.define :develrigg do |config|

    box_name = 'develrigg'
    host_name = "local.#{box_name}.com"

    config.vm.provider :virtualbox do |vb|
      vb.name = "mytechbooks"
      vb.customize ["modifyvm", :id,
                   "--name", box_name,
                   "--memory", "1024",
                   "--cpus", "2",
                   "--nictype1", "Am79C973",
                   "--nictype2", "Am79C973"]
    end

    config.vm.box = "basedevel"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.vm.hostname = host_name
    config.vm.network :private_network, ip: "33.33.33.10"
    config.vm.network :forwarded_port, guest: 80,   host: 8080, :auto => true
    config.vm.network :forwarded_port, guest: 9292, host: 9293, :auto => true

    config.vm.synced_folder "..", "/home/vagrant/apps", :nfs => true

  end

end
