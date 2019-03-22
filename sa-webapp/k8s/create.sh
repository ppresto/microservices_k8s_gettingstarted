#!/usr/bin/env bash

#Create LB Service for WebApp
kubectl apply -f service-sa-web-app-lb.yaml
# Create WebApp Deployment
kubectl apply -f sa-web-app-deployment.yaml --record
kubectl get pods --show-labels
kubectl get svc
