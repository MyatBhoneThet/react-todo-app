pipeline {
    agent {
        docker {
            image 'node:18'
        }
    }

    environment {
        DOCKER_HUB_USER = 'myatbhonethet'
        IMAGE_NAME = 'todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
    }

    stages {

        stage('Build') {
    steps {
        sh '''
        apt-get update
        apt-get install -y python3 make g++
        ln -sf /usr/bin/python3 /usr/bin/python
        npm install
        '''
    }
}

        stage('Test') {
            steps {
                sh 'npm test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_USER/todo-app:latest
                    '''
                }
            }
        }
    }
}
