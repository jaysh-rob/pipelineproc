#!/bin/bash


sudo yum install java-1.8.0-openjdk-devel -y

sudo yum install git -y

sudo yum install maven -y 


if [ -d "pipelineproc" ]
then
    echo "Directory pipelineproc already exists"
    cd /home/ec2-user/pipelineproc
    git pull origin feature 
else
    git clone https://github.com/jaysh-rob/pipelineproc.git
fi

cd /home/ec2-user/pipelineproc 

mvn package 

