#!/usr/bin/env groovy
pipeline {
    agent any
    stages {
        stage ("build app") {
            steps {
                script {
                    echo "building the applicaiton"
                    sh "maven clean package"
                }
            }
        }
    }
}