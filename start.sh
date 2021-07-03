#!/bin/bash

# starting the cluster 
minikube start

# Check minikube status
minikube status

# Viewing the nodes
minikube kubectl -- get nodes

# Viewing the pods
minikube kubectl -- get po -A

# Viewing the service
minikube kubectl -- get svc

# Install helm 
curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Creating the namespace for zookeeper
minikube kubectl -- create ns zk

# Install Zookeeper
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install zookeeper --set replicaCount=1 bitnami/zookeeper -n zk

# Verify Zookeeper
minikube kubectl -- get pods -n zk
minikube kubectl -- get svc -n zk

# Install clickhouse operator
minikube kubectl -- apply -f ./clickhouse-operator-install.yaml

# Install clickhouse-db
minikube kubectl -- apply -f ./develop-cluster.yaml

# Wait for the clickhouse-db cluster to up
echo "Waiting for ClickHouse and Zookeeper to bootup..."
while true; do
    string=$(minikube kubectl -- get clickhouseinstallation.clickhouse.altinity.com/ch-cluster | awk 'FNR == 2 {print $4}')
    sleep 10s
    echo "Status: $(minikube kubectl -- get clickhouseinstallation.clickhouse.altinity.com/ch-cluster | awk 'FNR == 2 {print $4}')"
    [[ $string == "Completed" ]] && break
done
echo "ClickHouse and Zookeeper are up."

# Check ClickHouse is working
export SIGNAL_CLICKHOUSE_URL=$(minikube service ch-lb --url | head -n 1)
export NODE_PORT=$(kubectl get service ch-lb --output='jsonpath={.spec.ports[0].nodePort}')
export NODE_IP=$(minikube ip)
echo "Running healthcheck for ClickHouse..."
echo "Checking: http://ch:ch-123456789@$NODE_IP:$NODE_PORT/?query=SELECT%201..."
echo "Result: $(curl -s http://ch:ch-123456789@$NODE_IP:$NODE_PORT/?query=SELECT%201)"
echo "======================================================================"
echo "SIGNAL_CLICKHOUSE_URL: http://ch:ch-123456789@$NODE_IP:$NODE_PORT/"
echo "======================================================================"

# view logs

minikube kubectl -- logs -f chi-ch-cluster-clickhouse-cp-0-0-0 -c clickhouse-pod