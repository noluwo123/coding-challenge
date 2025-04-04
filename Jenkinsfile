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
                sh "docker build -t projectlightfeather-backend:$BUILD_NUMBER -f backend/Dockerfile ./backend"
            }
        }

        stage("Build Frontend Docker Image...") {
            steps {
                sh "docker build -t projectlightfeather-frontend:$BUILD_NUMBER -f frontend/Dockerfile ./frontend"
            }
        }
	
        stage('Publish to ECR...') {
            steps {
                sh '''
                aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o3l1z7u7
        
                docker tag projectlightfeather-frontend:$BUILD_NUMBER public.ecr.aws/o3l1z7u7/projectlightfeather-frontend:$BUILD_NUMBER
                docker push public.ecr.aws/o3l1z7u7/projectlightfeather-frontend:$BUILD_NUMBER
              
                docker tag projectlightfeather-backend:$BUILD_NUMBER public.ecr.aws/o3l1z7u7/projectlightfeather-backend:$BUILD_NUMBER
                docker push public.ecr.aws/o3l1z7u7/projectlightfeather-backend:$BUILD_NUMBER
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
