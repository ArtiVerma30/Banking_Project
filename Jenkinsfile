pipeline {
    agent any
    environment {
   
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ArtiVerma30/Banking_Project.git'
            }
        }
        stage('Build Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('HTML Report') {
            steps {
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t artiverma30/banking-project:1.0 .'
            }
        }
         stage('Docker Push Image') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'docker_password', usernameVariable: 'docker_login')]) {
               sh 'docker login -u ${docker_login} -p ${docker_password}'
             }
                   
                sh 'docker push artiverma30/banking-project:1.0'
                }
        }
        stage('configure server with terraform and deploy using Ansible') {
           steps {
		      dir('my-serverfiles') {
		      sh 'sudo chmod 600 Artikeypair.pem'
		      sh 'terraform init'
		      sh 'terraform validate'
		      sh 'terraform apply --auto-approve'
			}
        }
    }
  }
}  
