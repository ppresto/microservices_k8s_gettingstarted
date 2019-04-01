#!/usr/bin/env bash

#Create LB Service
kubectl apply -f service-sa-frontend-lb.yaml
kubectl get svc

# Create frontend Deployment
kubectl apply -f sa-frontend-deployment.yaml --record
kubectl get pods --show-labels

# Watch rolling deployment
# kubectl rollout status deployment sa-frontend

# Scale replica count up/down
# kubectl scale --replicas=1 -f sa-frontend-deployment.yaml
