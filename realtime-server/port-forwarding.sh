#!/bin/bash
boot2docker poweroff 
VBoxManage modifyvm 'boot2docker-vm' --natpf1 "tcp-port-16379,tcp,,16379,,16379"
VBoxManage modifyvm 'boot2docker-vm' --natpf1 "tcp-port-33555,tcp,,33555,,33555"
boot2docker up
