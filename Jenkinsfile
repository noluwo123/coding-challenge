pipeline {
    agent any
  
    environment {
        AWS_DEFAULT_REGION = "us-east-1"
        THE_BUTLER_SAYS_SO = credentials('aws-creds')
    }

    stages {
        stage('Checkout...') {
            steps {
                git branch: 'main', url: 'https://github.com/noluwo123/coding-challenge.git'
            }
        }
      
        stage("Build Backend Docker Image...") {
            steps {
                sh "docker build -t lightfeather-backend:$BUILD_NUMBER -f backend/Dockerfile ./backend"
            }
        }

        stage("Build Frontend Docker Image...") {
            steps {
                sh "docker build -t lightfeather-frontend:$BUILD_NUMBER -f frontend/Dockerfile ./frontend"
            }
        }
	
        stage('Publish to ECR...') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 139282551466.dkr.ecr.us-east-1.amazonaws.com
        
                docker tag lightfeather-frontend:$BUILD_NUMBER 139282551466.dkr.ecr.us-east-1.amazonaws.com/lightfeather-frontend:$BUILD_NUMBER
                docker push 139282551466.dkr.ecr.us-east-1.amazonaws.com/lightfeather-frontend:$BUILD_NUMBER
              
                docker tag lightfeather-backend:$BUILD_NUMBER 139282551466.dkr.ecr.us-east-1.amazonaws.com/lightfeather-backend:$BUILD_NUMBER
                docker push 139282551466.dkr.ecr.us-east-1.amazonaws.com/lightfeather-backend:$BUILD_NUMBER
                '''
            }
        }
    }
  
    post {
        always {
            node('master') {
                cleanWs()
            }
        }
    }
}
