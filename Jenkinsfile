pipeline {
    agent any

    environment {
<<<<<<< HEAD
        IMAGE_NAME = "odoo18-auto"
=======
        IMAGE_NAME = "odoo18"
        DB_HOST = "odoo18-db"
        DB_PORT = "5432"
        DB_USER = "odoo"
        DB_PASSWORD = "Pr0t3ct10n!"
        DB_NAME = "postgres"
        NETWORK_NAME = "odoo_default"
>>>>>>> f3a577ef3073a113a70dc813a8a87d0dbf7dc504
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
                    // Stops and removes any running container with the same name
                    sh "docker stop ${IMAGE_NAME} || true"
                    sh "docker rm ${IMAGE_NAME} || true"
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
<<<<<<< HEAD
                    sh "docker run -d --name ${IMAGE_NAME} -p 8069:8069 ${IMAGE_NAME}:latest"
=======
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
>>>>>>> f3a577ef3073a113a70dc813a8a87d0dbf7dc504
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
