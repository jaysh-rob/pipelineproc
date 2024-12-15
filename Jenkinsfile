pipeline {
    agent none

    tools {
        maven "mymaven" // Ensure 'mymaven' is defined in Jenkins global tools configuration
    }

    parameters {
        string (defaultValue: 'Test', description: 'Environment to deploy ', name: 'ENV')
        booleanParam (defaultValue: true, description: 'Decide to run test cases', name: 'executiveTests')  // Corrected the typo
        choice (choices: ['1.1', '1.2', '1.3'], name: 'APPVERSION') // Fixed the extra space in choice options
    }

    stages {
        stage('Compile') { // Compile stage
            agent any
            steps {
                echo "This is for compile ${params.ENV}" // Fixed ENV parameter reference
                sh "mvn compile"
            }
        }

        stage('Test') { // Test stage
            when {
                expression {
                    return params.executiveTests == true // Corrected the boolean check
                }
            }
            agent any
            steps {
                echo "This is for Test"
                sh "mvn test"
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'  // Ensure this path is correct
                }
            }
        }

        stage('Package') { // Package stage
        when{
            expression{
                BRANCH_NAME=='feature'
            }
        }

        input{
            message "Select the version"
            ok "Version Selected"
            parameters{
                choice(name:'APPVERSION', choices:['1.5', '2.5', '3.5'])
            }
        }
            agent any
            
            steps {
                echo "This is for Package ${params.APPVERSION}" // Fixed parameter reference for app version
                sh "mvn package"
            }
        }
    }
}
