#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        'maven-3.6'
    }
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