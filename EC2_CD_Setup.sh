#!/bin/bash
sudo yum -y update
sudo yum -y install ruby
sudo yum -y install wget
cd /home/ec2-user
wget https://heyheyheyheyhey.s3.amazonaws.com/install/install_script.rb
chmod +x install_script.rb
ruby install_script.rb auto
sudo yum install -y python-pip
sudo pip install awscli
