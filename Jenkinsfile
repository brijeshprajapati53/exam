pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'brijeshprajapati53/node-app'
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials-id' // Add this in Jenkins > Credentials
    }

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/yourusername/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}").push('latest')
                    }
                }
            }
        }
    }
}
