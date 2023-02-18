#!/usr/bin/env groovy
pipeline {
    agent any {
        tools {
            maven "maven-3.6"
        }
        stages {
            stage("build app") {
                steps {
                    scripts {
                        echo " building the application"
                        sh "mvn clean package"
                    }
                }
            }
        }
    }
}