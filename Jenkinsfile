pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'brijeshprajapati53/node-app:latest'
        DOCKER_HUB_CREDENTIALS = 'azure-service-principal' // This is the credential ID used in Jenkins
        ACR_NAME = "examregister121"
        ACR_LOGIN_SERVER = "brijeshprajapati53"
        IMAGE_NAME = "node-app"
        TAG = "latest"
        RESOURCE_GROUP = "examResourceGroup"
    }

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/brijeshprajapati53/exam.git'
            }
        }
        
        stage('Azure Login') {
            steps {
                withCredentials([azureServicePrincipal(
                    credentialsId: 'azure-service-principal',
                    subscriptionIdVariable: 'AZ_SUBSCRIPTION_ID',
                    clientIdVariable: 'AZ_CLIENT_ID',
                    clientSecretVariable: 'AZ_CLIENT_SECRET',
                    tenantIdVariable: 'AZ_TENANT_ID'
                )]) {
                    bat '''
                        az login --service-principal -u %AZ_CLIENT_ID% -p %AZ_CLIENT_SECRET% --tenant %AZ_TENANT_ID%
                        az account set --subscription %AZ_SUBSCRIPTION_ID%
                    '''
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                bat """
                    az acr login --name %ACR_NAME%
                    docker build -t %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%TAG% .
                    docker push %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%TAG%
                """
            }
        }
    }
}
