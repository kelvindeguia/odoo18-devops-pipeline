pipeline {
    agent any

    environment {
        // Replace with your GitHub repo URL (HTTPS or SSH)
        GIT_REPO = 'https://github.com/kelvindeguia/odoo18-devops-pipeline.git'
        // Optional: name for your Docker image
        IMAGE_NAME = 'odoo18-custom'
    }

    stages {
        stage('Pull Latest Code') {
            steps {
                echo 'Pulling latest code from GitHub...'
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Odoo 18 Docker image...'
                script {
                    sh 'docker build -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Recreate Containers') {
            steps {
                echo 'Restarting containers using docker-compose...'
                script {
                    // Stop and remove old containers, rebuild and restart fresh ones
                    sh '''
                    docker compose down
                    docker compose up -d --build
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Deployment failed. Check logs for details.'
        }
    }
}
