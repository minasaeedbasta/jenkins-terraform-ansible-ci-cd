pipeline {
    agent { label 'slave1'}

    parameters {
        choice(name: 'action',choices: ['apply', 'destroy'],description: 'Apply or destroy resources')
        booleanParam(name: 'autoApprove', defaultValue: true, description: 'Automatically run apply after generating plan?')
        choice(name: 'environment',choices: ['dev', 'prod'],description: 'Workspace/environment file to use for deployment')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
        TF_VAR_rds_username   = credentials('RDS_USERNAME')
        TF_VAR_rds_password   = credentials('RDS_PASSWORD')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/minasaeedbasta/jenkins-terraform-ansible-ci-cd.git'
            }
        }
        stage('Plan') {
            steps {
                dir('terraform'){
                    sh 'terraform init -input=false'
                    script {
                        def workspace = sh(script: "terraform workspace list | grep ${params.environment} || true", returnStdout: true).trim()
                        if (workspace.isEmpty()) {
                            sh "terraform workspace new ${params.environment}"
                        }
                    }
                    sh 'terraform workspace select ${environment}'
                    sh "terraform plan -input=false -out tfplan --var-file=${params.environment}.tfvars"
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }  
            }

        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                dir('terraform'){
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                }
            }
        }

        stage('Apply or Destroy') {
            steps {
                dir('terraform'){
                    script {
                        if (params.action == 'apply') {
                            sh "terraform apply -auto-approve tfplan"
                        } else if (params.action == 'destroy') {
                            sh "terraform destroy --var-file=${params.environment}.tfvars -auto-approve"
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            dir('terraform'){
                archiveArtifacts artifacts: 'tfplan.txt'
            }
        }
    }
}