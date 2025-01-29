pipeline {
    agent any
        environment {
            // Define environment variables for AWS credentials
            AWS_ACCESS_KEY_ID = credentials('aws_access_key_id') // Fetch from Jenkins credentials
            AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key') // Fetch from Jenkins credentials
            AWS_DEFAULT_REGION = 'ap-south-1' //
        }

        stages {
            stage('Checkout') {
                steps {
                    // Checkout code from the repository
                    git "https://github.com/aroraaman25/Sample-Application.git"
                }
            }

            stage('Credential Validation') {
                steps {
                    // Validate AWS Secrets stored in Jenkins Credentials
                    sh '''
                    export aws_access_key_id=$aws-access-key-id
                    export aws_secret_access_key=$aws-secret-access-key
                    '''
                }
            }
            
            stage('Terraform init') {
                steps {
                    script {
                        // initialize Terraform
                        sh 'terraform init'
                    }
                }
            }

            stage('Terraform Plan') {
                steps {
                    sh 'terraform plan'
                }
            }

            stage('Terraform Apply') {
                steps {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        post {
            success {
                echo 'terraform deployment succeeded'
            }

            failure {
                echo 'terraform deployment failed'
            }
        }

    }