#! /bin/bash

<<task
	cloning repo from git 
	instaling dependencies 
	running the app from docker
task

git_clone(){
	echo "cloning repo"
	git clone https://github.com/aaditya-2905/Car-catalogue.git
}

installing_dependencies(){
	sudo apt install docker.io -y
}

system_services(){
	sudo apt update
	sudo chown $USER /var/run/docker.sock
	sudo systemctl enable --now nginx docker
	sudo systemctl restart docker
}

deployment(){
	docker build -t car-catalogue-project .
	docker run -d -p 8080:80 car-catalogue-project
}

echo "*********** Deployment started ************"


if ! git_clone; then
	echo "clone already exits"
	cd Car-catalogue
fi

if ! installing_dependencies; then
	echo "Dependencies not installed"
	exit 1
fi

if ! system_services; then
	echo "services not started"
	exit 1
fi
deployment
echo "*********** Deployment Done ***********"

