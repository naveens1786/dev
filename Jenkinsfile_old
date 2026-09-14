pipeline {

    agent any

    environment {
        IMAGE_NAME = "devops-build"
        DOCKERHUB_USER = "navchan86"

        DEV_REPO  = "${DOCKERHUB_USER}/devops-build-dev"
        PROD_REPO = "${DOCKERHUB_USER}/devops-build-prod"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {

                        sh """
                            docker build \
                            -t ${DEV_REPO}:${BUILD_NUMBER} \
                            -t ${DEV_REPO}:latest .
                        """

                    } else if (env.BRANCH_NAME == 'master') {

                        sh """
                            docker build \
                            -t ${PROD_REPO}:${BUILD_NUMBER} \
                            -t ${PROD_REPO}:latest .
                        """
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | \
                        docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {

                        sh """
                            docker push ${DEV_REPO}:${BUILD_NUMBER}
                            docker push ${DEV_REPO}:latest
                        """

                    } else if (env.BRANCH_NAME == 'master') {

                        sh """
                            docker push ${PROD_REPO}:${BUILD_NUMBER}
                            docker push ${PROD_REPO}:latest
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {

                        sh '''
                            docker rm -f devops-build-dev 2>/dev/null || true

                            docker pull ${DEV_REPO}:latest

                            docker run -d \
                              --name devops-build-dev \
                              --restart unless-stopped \
                              -p 3000:3000 \
                              ${DEV_REPO}:latest
                        '''

                    } else if (env.BRANCH_NAME == 'master') {

                        sh '''
                            docker rm -f devops-build-prod 2>/dev/null || true

                            docker pull ${PROD_REPO}:latest

                            docker run -d \
                              --name devops-build-prod \
                              --restart unless-stopped \
                              -p 3001:3000 \
                              ${PROD_REPO}:latest
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }

        success {
            echo "Pipeline completed successfully for ${BRANCH_NAME}"
        }

        failure {
            echo "Pipeline failed for ${BRANCH_NAME}"
        }
    }
}
