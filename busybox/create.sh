#!/usr/bin/env bash

# Create
kubectl apply -f https://k8s.io/examples/admin/dns/busybox.yaml
# Check Status
sleep 10
kubectl get pods busybox
# Use nslookup to test kube.dns
kubectl exec -ti busybox -- nslookup kubernetes.default

#troubleshooting
# https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

# Verify DNS Service is running and endpoints are exposed
#kubectl get svc --namespace=kube-system
#kubectl get ep kube-dns --namespace=kube-system

# CoreDNS logs:
#for p in $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name); do kubectl logs --namespace=kube-system $p; done

# kube-dns logs:  look for W, E, or F at beginning of line to see warn/error/fail messages
#kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c kubedns
#kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c dnsmasq
#kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c sidecar

# Add log plugin to CoreDNS (add "log" to section  .:53 { )
#kubectl -n kube-system edit configmap coredns
# For kube-dns
#kubectl -n kube-system edit configmap kube-dns
