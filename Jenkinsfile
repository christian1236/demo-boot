pipeline {
    agent any

    tools {
        maven 'MVN'
    }

    stages {
        stage('Checkout') {
            steps {
                sh 'mvn clean'
                
                script {
                    try {
                        sh 'docker stop demo-boot && docker rm demo-boot'
                    } catch (Exception e) {
                        echo "***********NO CONTAINER TO REMOVE************"
                    }
                }
                
                script {
                    try {
                        sh 'docker rmi demo-boot'
                    } catch (Exception e) {
                        echo "***********NO IMAGE TO REMOVE************"
                    }
                }
            }
        }
        stage('Cleaning Workspace') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
            
            post {
                success {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            steps {
                 echo "... Package ..."
                sh 'mvn package -DskipTests'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "... Build Docker Image ..."
                sh 'docker build -t demo-boot .'
            }
        }
        stage('Run Docker Image') {
            steps {
                echo "... Run Docker Image ..."
                sh 'docker run -d --rm -p 8081:8080 --name=demo-boot demo-boot'
            }
        }
    }
}
