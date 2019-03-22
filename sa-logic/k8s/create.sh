#!/usr/bin/env bash

# Create Python App Deployment that holds our backend logic
kubectl apply -f sa-logic-deployment.yaml --record

# Create Service giving us an HA entry point to our backend service
kubectl apply -f service-sa-logic.yaml
