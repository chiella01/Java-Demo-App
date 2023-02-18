#!/usr/bin/env groovy
pipeline {
    agent any
    tools {
        maven 'maven-3.6'
    }
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