#!/bin/bash

# Install Minikube on Linux machines

if [ $(dpkg-query -W -f='${Status}' minikube 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  wget -q https://github.com/kubernetes/minikube/releases/download/v1.22.0-beta.0/minikube_1.22.0.beta.0-0_amd64.deb;
#  curl -sLO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb;
  sleep 2s;
  sudo dpkg -i minikube_1.22.0.beta.0-0_amd64.deb;
  sudo rm -rf minikube_1.22.0.beta.0-0_amd64.deb
fi
