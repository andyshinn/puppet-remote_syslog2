# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
  end

  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  config.vm.synced_folder "./", "/etc/puppet/modules/remote_syslog2"
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "spec/fixtures/manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "spec/fixtures/modules"
    puppet.hiera_config_path = "spec/fixtures/puppet/hiera.yaml"
  end
end
