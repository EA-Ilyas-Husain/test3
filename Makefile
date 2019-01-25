SHELL := /bin/bash

.PHONY = instances

instances: 
        terraform init 
        terraform apply -auto-approve
        gcloud config set project clarapcp-ea-ilyas-husein
        gcloud container clusters get-credentials --region europe-west1-b gke-cluster-1

.PHONY = deploy-expose

deploy-expose:
        kubectl create deployment hellowhale --image ilyashusain/hellowhale
        kubectl expose deployment/hellowhale --port 80 --name hellowhalesvc --type LoadBalancer
        sudo rm -R /var/lib/jenkins/.kube/
        sudo mkdir /var/lib/jenkins/.kube
        sudo cp /home/ihusain1994/.kube/config /var/lib/jenkins/.kube/
        sudo chown jenkins:jenkins /var/lib/jenkins/.kube/config
        sudo service jenkins restart
