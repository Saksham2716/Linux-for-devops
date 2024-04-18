#!/bin/bash
<<task deploy an app
and handle the code for errors
task

code_clone() {
	echo "Cloning the app..."
	sleep 2
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_requirements() {
	sudo apt-get install docker.io nginx docker-compose -y
}

required_restarts() {
	sudo chown $USER /var/run/docker.sock
	#sudo systemctl enable docker
	#sudo systemctl enable nginx
	#sudo systemctl restart docker
}

deploy(){
	docker build -t notes-app .
        docker-compose up -d #docker run -d -p 8000:8000 notes-app:latest
}

echo "******************Deployment Started*****************"
sleep 2

if ! code_clone; then
	echo "The directory already exists"
	cd django-notes-app
fi

if ! install_requirements; then
	echo "Installation Failed"
	exit 1
fi
if ! required_restarts; then
       echo "System Fault Identified"
       exit 1
fi       
if ! deploy; then
	echo "Deployment Failed, Sending Mail to Admin"
	#sendmail
fi

echo "******************Deployment Done*****************"
