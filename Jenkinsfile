pipeline {
    agent {label 'slave'}

    stages {
        stage('Build') {
                steps {
                    sh 'docker build -f Dockerfile . -t sandronael/django_app:v1.0'
                      }
                   post{
                    success{
                         slackSend(color: '#00FF00',message: "BuildingStarted: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'(${env.BUILD_URL}console)")
                      }
                  }
            }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId:"dockerhub",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")]){
                sh 'docker login --username $USERNAME --password $PASSWORD'
                sh 'docker push sandronael/django_app:v1.0'
                }
            }
        }
         stage('Deploy') {
            steps {
                sh 'docker run -d -p 3000:3000 sandronael/django_app:v1.0'
            }  
    }
  }
    
    post {
      success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
      }

      failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
      }

      aborted {
      slackSend (color: '#000000', message: "ABORTED: Job '${env.JOB_NAME}  [${env.BUILD_NUMBER}]' (${env.BUILD_URL}console)")
      }
    }
}
