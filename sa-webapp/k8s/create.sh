#!/usr/bin/env bash

#Create LB Service for WebApp
kubectl apply -f service-sa-web-app-lb.yaml
# Create WebApp Deployment
kubectl apply -f sa-web-app-deployment.yaml --record
kubectl get pods --show-labels
kubectl get svc

# Watch rolling deployment
# kubectl rollout status deployment sa-web-app

# Scale replica count up/down
# kubectl scale --replicas=1 -f sa-web-app-deployment.yaml.yaml
