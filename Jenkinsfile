pipeline {
    agent any

    environment {
        IMAGE_NAME = "odoo18"
        DB_HOST = "odoo18-db"
        DB_PORT = "5432"
        DB_USER = "odoo"
        DB_PASSWORD = "Pr0t3ct10n!"
        DB_NAME = "postgres"
        NETWORK_NAME = "odoo18-network"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kelvindeguia/odoo18-devops-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Create Network if Not Exists') {
            steps {
                script {
                    sh '''
                        if [ -z "$(docker network ls --filter name=^${NETWORK_NAME}$ -q)" ]; then
                            echo "Creating network ${NETWORK_NAME}..."
                            docker network create ${NETWORK_NAME}
                        else
                            echo "Network ${NETWORK_NAME} already exists."
                        fi
                    '''
                }
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                script {
                    sh "docker stop ${IMAGE_NAME} || true"
                    sh "docker rm ${IMAGE_NAME} || true"
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    sh '''
                        docker run -d \
                          --name ${IMAGE_NAME} \
                          --network odoo_default \
                          -e DB_HOST=odoo18-db \
                          -e DB_PORT=5432 \
                          -e DB_USER=odoo \
                          -e DB_PASSWORD=odoo \
                          -e DB_NAME=postgres \
                          -p 8069:8069 \
                          ${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build & Deploy successful!"
        }
        failure {
            echo "❌ Build failed. Check console output."
        }
    }
}
