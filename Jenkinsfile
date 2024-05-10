pipeline {
    agent { label 'aws-slave' }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
        TF_VAR_username       = credentials('RDS_USERNAME')
        TF_VAR_password       = credentials('RDS_PASSWORD')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/minasaeedbasta/jenkins-terraform-ansible-ci-cd.git'
            }
        }
        stage('Terraform init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply --var-file dev.tfvars --auto-approve'
                }
            }
        }
    }
}
