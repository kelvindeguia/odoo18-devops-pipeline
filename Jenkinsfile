pipeline {
    agent any

    environment {
        IMAGE_NAME = "odoo18-auto"
        DB_CONTAINER = "odoo18-db"
        DB_HOST = "db"
        DB_USER = "odoo"
        DB_PASSWORD = "odoo"
        ODOO_PORT = "8070"
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
                    sh """
                    docker run -d \
                        --name ${IMAGE_NAME} \
                        --link ${DB_CONTAINER}:${DB_HOST} \
                        -e HOST=${DB_HOST} \
                        -e USER=${DB_USER} \
                        -e PASSWORD=${DB_PASSWORD} \
                        -p ${ODOO_PORT}:8069 \
                        ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build & Deploy successful! Odoo running at http://localhost:${ODOO_PORT}"
        }
        failure {
            echo "❌ Build failed. Check console output."
        }
    }
}
