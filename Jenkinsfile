def project = 'cicd-234921'
def  appName = 'sa-webapp'
def  feSvcName = "sa-frontend"
def  imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

pipeline {
  agent {
    kubernetes {
      label 'microservices-gettingstarted'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  containers:
  - name: python
    image: python:3.6.6-alpine
    command:
    - cat
    tty: true
  - name: nginx
    image: nginx:latest
    command:
    - cat
    tty: true
  - name: openjdk
    image: ppresto/myopenjdk:latest
    command:
    - cat
    tty: true
  - name: gcloud
    image: gcr.io/cloud-builders/gcloud
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
"""
}
  }
  stages {
    stage('Test') {
      steps {
        container('openjdk') {
          sh """
            ls -al
          """
        }
      }
    }
    stage('Build webapp') {
      steps {
        container('openjdk') {
          sh """
            cd sa-webapp
            mvn install
          """
        }

      }
    }
    stage('Deploy Canary') {
      // Canary branch
      when { branch 'canary' }
      steps {
        container('kubectl') {
          // Change deployed image in canary to the one we just built
          //sh("sed -i.bak 's#gcr.io/cloud-solutions-images/gceme:1.0.0#${imageTag}#' ./k8s/canary/*.yaml")
          sh("kubectl --namespace=production apply -f sa-webapp/k8s/")
          //sh("kubectl --namespace=production apply -f k8s/services/")
          //sh("kubectl --namespace=production apply -f k8s/canary/")
          sh("echo http://`kubectl --namespace=production get service/${appName} -o jsonpath='{.status.loadBalancer.ingress[0].ip}'` > ${feSvcName}")
        }
      }
    }
    stage('Deploy Production') {
      // Production branch
      when { branch 'master' }
      steps{
        container('kubectl') {
        // Change deployed image in canary to the one we just built
          //sh("sed -i.bak 's#gcr.io/cloud-solutions-images/gceme:1.0.0#${imageTag}#' ./k8s/production/*.yaml")
          sh("kubectl --namespace=production apply -f sa-webapp/k8s/")
          //sh("kubectl --namespace=production apply -f k8s/services/")
          //sh("kubectl --namespace=production apply -f k8s/production/")
          sh("echo http://`kubectl --namespace=production get service/${appName} -o jsonpath='{.status.loadBalancer.ingress[0].ip}'` > ${feSvcName}")
        }
      }
    }
    stage('Deploy Dev') {
      // Developer Branches
      when {
        not { branch 'master' }
        not { branch 'canary' }
      }
      steps {
        container('kubectl') {
          // Create namespace if it doesn't exist
          sh("kubectl get ns ${env.BRANCH_NAME} || kubectl create ns ${env.BRANCH_NAME}")
          // Don't use public load balancing for development branches
          sh("sed -i.bak 's#LoadBalancer#ClusterIP#' ./k8s/services/frontend.yaml")
          sh("sed -i.bak 's#gcr.io/cloud-solutions-images/gceme:1.0.0#${imageTag}#' ./k8s/dev/*.yaml")
          sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/services/")
          sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/dev/")
          echo 'To access your environment run `kubectl proxy`'
          echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${env.BRANCH_NAME}/services/${feSvcName}:80/"
        }
      }
    }
  }
}
