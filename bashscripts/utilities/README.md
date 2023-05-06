# Shell scripts in this folder

This folder contains utility scripts for local usage, copy into $PATH

- add-user.sh - exercise script for own usag, bringing the demos together
- disable-user.sh - script to disable or delete a local user
- backup_file.sh - script to backup a given file to /var/tmp and log the status depending on log level
- show-attacker.sh - script uses awk, cut, uniq and sort to analyse http log file and print most used IP adresses for login failures. uses _syslog.log_ as example file.

# Vagrant usage

By default vagrant operates on all boxes defined in the VAGRANTFILE. If [VM] is defined it only operates on the defined box. The curent directory (.) is synced to /vagrant on the host machine.

There are three VMs configured:

    config.vm.box = "jasonc/centos7"

    config.vm.define "admin01" do |admin01|
        admin01.vm.hostname = "admin01"
        admin01.vm.network "private_network", ip: "10.9.8.10"
    end

    config.vm.define "server01" do |server01|
        server01.vm.hostname = "server01"
        server01.vm.network "private_network", ip: "10.9.8.11"
    end

    config.vm.define "server02" do |server02|
        server02.vm.hostname = "server02"
        server02.vm.network "private_network", ip: "10.9.8.12"
    end

- to list options: `vagrant`

- to install a new image: `vagrant box add _user/version_`

- to init a Vagrantfile: `vagrant init`

- to edit the Vagrantfile: `vi Vagrantfile`

- to bring up a VMs: `vagrant up [VM]`

- to remote login via ssh, requires [VM]: `vagrant ssh [VM]`

- to halt the virtual machine: `vagrant halt [VM]`

- to destroy the VM: `vagrant destroy [VM]`

- to show status of all VMs in Vagrantfile: `vagrant status`
