pipeline {
    agent { label 'aws-slave' }

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
                    sh 'terraform apply --var-file ${terraform_dev_varfile} --auto-approve'
                }
            }
        }
    }
}
