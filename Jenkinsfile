@Library('general-jenkins-library@master') _
def POD_LABEL = "docker-jenkins-${UUID.randomUUID().toString()}"
pipeline {
    agent {
        kubernetes {
        label POD_LABEL
        defaultContainer 'jnlp'
        yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  role: CI
spec:
  containers:
  - name: terraform
    image: samer1984/terraform-aws-cached-plugin
    command:
    - cat
    tty: true
    env:
    - name: AWS_ACCESS_KEY_ID
      valueFrom:
        secretKeyRef:
          name: aws-configure
          key: AWS_ACCESS_KEY_ID
    - name: AWS_SECRET_ACCESS_KEY
      valueFrom:
        secretKeyRef:
          name: aws-configure
          key: AWS_SECRET_ACCESS_KEY
    volumeMounts:
    - name: kube-config
      mountPath: /root/.kube
  volumes:
  - name: kube-config
    hostPath:
      path: /home/sam/.kube/kubeconfig-to-let-jenkins-connect
"""
	}
  }
  stages {
    stage('Checkout SCM') {
        steps {
            container('terraform') {
              // clone master
              gitCo(
                  branch: "master",
                  url: "https://github.com/samer-habash/lambda_app.git"
            )}
        }
    }
    stage('zip app') {
        steps {
            container('terraform') {
                sh """
                    apk add zip
                    zip app.zip app.py
                """
            }
        }
    }
    stage('terraform apply') {
        steps {
            container('terraform') {
                // Will need to do terraform init in order for the terraform backend works
                // since my image already has aws plugin cached and installed.
                sh """
                    terraform init
                    terraform plan
                    terraform apply -auto-approve
                """
            }
        }
    }
    stage('terraform apply backend') {
        steps {
            container('terraform') {
                sh """
                    cd remote-backend
                    terraform init
                    terraform apply -auto-approve
                """
            }
        }
    }
  }
}