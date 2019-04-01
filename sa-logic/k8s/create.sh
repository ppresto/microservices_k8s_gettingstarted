#!/usr/bin/env bash

# Create Python App Deployment that holds our backend logic
kubectl apply -f sa-logic-deployment.yaml --record

# Create Service giving us an HA entry point to our backend service
kubectl apply -f service-sa-logic.yaml

# Watch rolling deployment
# kubectl rollout status deployment sa-logic

# Scale replica count up/down
# kubectl scale --replicas=1 -f sa-logic-deployment.yaml
