pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub-cred')
        DOCKER_USER = "bhanusiva"
        IMAGE = "devops-build-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push to Dev Repo') {
            when { branch 'dev' }
            steps {
                sh '''
                echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                docker tag $IMAGE $DOCKER_USER/dev:latest
                docker push $DOCKER_USER/dev:latest
                '''
            }
        }

        stage('Push to Prod Repo') {
            when { branch 'main' }
            steps {
                sh '''
                echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                docker tag $IMAGE $DOCKER_USER/prod:latest
                docker push $DOCKER_USER/prod:latest
                '''
            }
        }

        stage('Deploy Dev') {
            when { branch 'dev' }
            steps {
                sh '''
                docker stop devops-container || true
                docker rm devops-container || true
                docker run -d -p 80:80 --name devops-container $DOCKER_USER/dev:latest
                '''
            }
        }
    }
}
