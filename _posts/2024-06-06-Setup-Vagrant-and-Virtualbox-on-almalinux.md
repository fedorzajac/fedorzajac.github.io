---
layout: post
title:  "Setup Vagrant and Virtualbox on almalinux"
date:   2024-06-06 21:08:53 +0200
categories: Setup Vagrant and Virtualbox on almalinux
---

### Setup Vagrant and Virtualbox on almalinux

```bash
# Install necessary tools
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant
sudo yum install docker

# Create project directory
mkdir -p ~/Documents/projects
cd ~/Documents/projects/

# Initialize Vagrant
vagrant init

# Install VirtualBox
sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
sudo yum install VirtualBox-7.0

# Add user to libvirt group
sudo usermod -aG libvirt $USER
loginctl terminate-user $USER

# Start Vagrant
vagrant up
```


### Additional info

[fish](https://fishshell.com/docs/current/cmds/history.html)

[fedora images](https://fedoraproject.org/cloud/download)

[Vagrantfile](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/kubeadm-clusters/virtualbox/Vagrantfile)
