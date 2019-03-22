#!/usr/bin/env bash

#Create LB Service
kubectl apply -f sa-frontend/k8s/service-sa-frontend-lb.yaml
# Create frontend Deployment
kubectl apply -f sa-frontend/k8s/sa-frontend-deployment.yaml --record

# Create Service giving us an HA entry point to our backend service
kubectl apply -f sa-logic/k8s/service-sa-logic.yaml
# Create Python App Deployment that holds our backend logic
kubectl apply -f sa-logic/k8s/sa-logic-deployment.yaml --record

#Create LB Service for WebApp
kubectl apply -f sa-webapp/k8s/service-sa-web-app-lb.yaml
# Create WebApp Deployment
kubectl apply -f sa-webapp/k8s/sa-web-app-deployment.yaml --record
kubectl get pods --show-labels
kubectl get svc
