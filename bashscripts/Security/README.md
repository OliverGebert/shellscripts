# Shell scripts in this folder

This folder contains utility scripts for kali usage, copy into $PATH

# Vagrant usage

By default vagrant operates on all boxes defined in the VAGRANTFILE. If [VM] is defined it only operates on the defined box. The curent directory (.) is synced to /vagrant on the host machine.

There is one VM configured:

```
Vagrant.configure("2") do |config|
    config.vm.box = "kalilinux/rolling"

    config.vm.define "kali01" do |kali01|
        kali01.vm.hostname = "kali01"
        kali01.vm.network "private_network", ip: "10.9.8.10"
    end
end
```

- to list options: `vagrant`

- to install a new image: `vagrant box add _user/version_`

- to init a Vagrantfile: `vagrant init`

- to edit the Vagrantfile: `vi Vagrantfile`

- to bring up a VMs: `vagrant up [VM]`

- to remote login via ssh, requires [VM]: `vagrant ssh [VM]`

- change into connected VM directory: `cd /vagrant`

- login with: `vagrant:vagrant`

- to halt the virtual machine: `vagrant halt [VM]`

- to destroy the VM: `vagrant destroy [VM]`

- to show status of all VMs in Vagrantfile: `vagrant status`
