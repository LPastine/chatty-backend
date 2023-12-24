#!/bin/bash

function program_is_installed {
  local return_=1

  type $1 >/dev/null 2>&1 || { local return_=0; }
  echo "$return_"
}

sudo yum update -y

# Check if NodeJs is installed. If not, install it
if [ $(program_is_installed node) == 0]; then
  sudo yum install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
  sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
fi

# Check if Git is installed. If not, install it
if [ $(program_is_installed git) == 0]; then
  sudo yum install git -y
fi

# Check if Docker is installed. If not, install it
if [ $(program_is_installed docker) == 0]; then
  sudo amzon-linux-extras install docker -y
  sudo systemctl start docker
  sudo docker run --name chatapp-redis -p 6379:6379 --restart always --detach redis
fi

# Check if PM2 is installed. If not, install it
if [ $(program_is_installed pm2) == 0]; then
  npm install -g pm2
fi

cd /home/ec2-user

git clone -b develop https://github.com/LPastine/chatty-backend.git
cd chatty-backend
npm install
aws s3 sync s3://chatapp-env-files/develop .
unzip env-file.zip
cp .env.production .env
npm run build
npm run start
