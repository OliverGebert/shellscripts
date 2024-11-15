# Shell Scripts in this folder

This folder contains bash scripts for usage on localhost

- luser_demo01.sh - hello world, assign variables and use echo
- luser_demo02.sh - display UID, use if then else fi
- luser_demo03.sh - check UID is vagrant, use exit code ${?}
- luser_demo04.sh - prompt for UID and PWD and create account, read STDIN, useradd -c, passwd -e commands
- luser_demo05.sh - create a random number
- luser_demo06.sh - positional parameters and arguments to assign random pwd to use ${@} to use all paramters as a list, date, sha256sum, head commands
- luser-demo07.sh - use WHILE Do Doing loop
- luser-demo08.sh - redirect STDOUT, STDERR, with > >> &> &|
- luser-demo09.sh - case command instead of nested if
- luser-demo10.sh - use functions
- luser-demo11.sh - use getops to parse option passed to the bash script
- luser-demo12.sh - delete a user

# Vagrant usage

By default vagrant operates on all boxes defined in the VAGRANTFILE. If [VM] is defined it only operates on the defined box. The curent directory (.) is synced to /vagrant on the host machine.

There are three VMs configured:

```
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

```

- to list options: `vagrant`

- to install a new image: `vagrant box add _user/version_`

- to init a Vagrantfile: `vagrant init`

- to edit the Vagrantfile: `vi Vagrantfile`

- to bring up a VMs: `vagrant up [VM]`

- to remote login via ssh, requires [VM]: `vagrant ssh [VM]`

- to change into connected directory of VM: `cd /vagrant`

- to halt the virtual machine: `vagrant halt [VM]`

- to destroy the VM: `vagrant destroy [VM]`

- to show status of all VMs in Vagrantfile: `vagrant status`
