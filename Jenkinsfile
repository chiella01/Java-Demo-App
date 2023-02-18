#!/usr/bin/env groovy
pipeline {
    agent any
    stages {
        stage ("building app") {
            steps {
                script {
                    echo "building the applicaiton"
                    sh "maven clean package"
                }
            }
        }
    }
}