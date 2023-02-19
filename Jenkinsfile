#!/usr/bin/env groovy
pipeline {
    agent any 
        tools {
            maven "maven-3.6"
        }
        environment {
            IMAGE_NAME = 'bemnji/demo-app:java-maven-app-2.0'
        }
        stages {
            stage("building app") {
                steps {
                    script {
                        echo "building the application"
                        sh "mvn clean package"
                    }
                }
            }
            stage("build image") {
                steps {
                    script {
                        echo "building the image"
                        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]){
                            sh "sudo docker build -t $IMAGE_NAME ."
                            sh " echo $PASS | sudo docker login -u $USER --password-stdin"
                            sh "sudo docker push $IMAGE_NAME"
                        }
                    }
                }
            }
            stage("provision server") {
                environment {
                    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                }
                steps {
                    script {
                        dir('terraform') {
                            sh "terraform init"
                            sh "terraform apply -auto-approve"
                            EC2_PUBLIC_IP = sh (
                                script: "terraform output ec2_public_ip",
                                returnStdout: true
                            ).trim()
                        }
                    }
                }
            }
            stage("deploy stage") {
                environment {
                    DOCKER_CREDS = credentials('docker-hub-credentials')
                }
                steps {
                    script {
                        echo "deploying docker image to EC2 ..."
                        echo "${EC2_PUBLIC_IP}"
                        def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
                        def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                        sshagent(['server-ssh-key']) {
                            sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ec2-user"
                            sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                        }                    }
                }
            }
        }
    }
