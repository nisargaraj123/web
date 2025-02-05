pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=nisarga", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop nisarga"
                    sh "docker rm nisarga"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/Chandu/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app nisargaraj/app'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Nisarga@992" | docker login -u "nisargaraj" --password-stdin'
                sh 'docker push nisargaraj/app'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull nisargaraj/app'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name nisarga -p 8081:8080 nisargaraj/app'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f nisarga'
        }
        always{
            echo 'Deployed'
        }
    }

}