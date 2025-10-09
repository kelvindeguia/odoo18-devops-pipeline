pipeline {
    agent any

    environment {
        IMAGE_NAME = "odoo18"
        DB_HOST = "odoo18-db"
        DB_PORT = "5432"
        DB_USER = "odoo"
        DB_PASSWORD = "Pr0t3ct10n!"
        DB_NAME = "postgres"
        NETWORK_NAME = "odoo_default"
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
                          --network ${NETWORK_NAME} \
                          -p 8069:8069 \
                          -v \$PWD/odoo.conf:/etc/odoo/odoo.conf \
                          -v \$PWD/custom_addons:/mnt/extra-addons \
                          -v \$PWD/odoo-data:/var/lib/odoo \
                          ${IMAGE_NAME}:latest
                    """
                    // 👉 If you want auto-upgrade custom module on each deployment, append:
                    //   -- -u isw_lighthouse
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
