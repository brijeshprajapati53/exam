pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'azure-service-principal' // Must be configured in Jenkins credentials
        ACR_NAME = "acrbrijesh1238"
        ACR_LOGIN_SERVER = "acrbrijesh1238.azurecr.io"
        IMAGE_NAME = "mynodeapp"
        TAG = "latest"
        RESOURCE_GROUP = "examresource"
        LOCATION = "East US 2"
        // AKS_CLUSTER_NAME = "aksclusterbrijesh123"
    }

    stages {
        stage('Checkout') {
    steps {
        git branch: 'main', url: 'https://github.com/brijeshprajapati53/exam.git'
    }
}


        stage('Azure Login') {
            steps {
                withCredentials([azureServicePrincipal(
                    credentialsId: "${AZURE_CREDENTIALS_ID}",
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

        stage('Terraform Init & Apply') {
            steps {
                dir('Terraform') {
                    bat 'terraform init'
                    bat 'terraform plan'
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        //  stage('Create ACR if not exists') {
        //     steps {
        //         bat '''
        //             az acr show --name %ACR_NAME% --resource-group %RESOURCE_GROUP% --query "name" || ^
        //             az acr create --name %ACR_NAME% --resource-group %RESOURCE_GROUP% --sku Basic --location %LOCATION%
        //         '''
        //     }
        // }

        stage('Login to ACR') {
            steps {
                bat "az acr login --name %ACR_NAME%"
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

        // stage('AKS Authentication') {
        //     steps {
        //         bat """
        //             az aks get-credentials --resource-group %RESOURCE_GROUP% --name %AKS_CLUSTER_NAME% --overwrite-existing
        //         """
        //     }
        // }

        // stage('Deploy to AKS') {
        //     steps {
        //         bat 'kubectl apply -f deployment.yaml'
                
        //     }
        // }
    }

    post {
        failure {
            echo " Build failed."
        }
        success {
            echo " Application deployed successfully to AKS!"
        }
    }
}
