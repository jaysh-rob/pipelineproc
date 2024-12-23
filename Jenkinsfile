pipeline {
    agent none

    environment {
        DEV_SERVER_IP = 'ec2-user@3.109.154.51'
    }

    tools {
        maven "mymaven" // Ensure 'mymaven' is defined in Jenkins global tools configuration
    }

    parameters {
        string(defaultValue: 'Test', description: 'Environment to deploy', name: 'ENV')
        booleanParam(defaultValue: true, description: 'Decide to run test cases', name: 'executiveTests')
        choice(choices: ['1.1', '1.2', '1.3'], name: 'APPVERSION')
        choice(name: 'BRANCH_NAME', choices: ['feature', 'develop', 'master'], description: 'Branch to deploy')
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                echo "This is for compile ${params.ENV}"
                sh "mvn compile"
            }
        }

        stage('Test') {
            when {
                expression { params.executiveTests == true }
            }
            agent any
            steps {
                echo "This is for Test"
                sh "mvn test"
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' // Ensure this path exists
                }
            }
        }

stage('Package') {
    agent any
    when {
        expression { params.BRANCH_NAME == 'feature' }
    }
    steps {
        script {
            // Capture user input for the version
            def selectedVersion = input message: "Select the version",
                ok: "Version Selected",
                parameters: [
                    choice(name: 'SELECTED_VERSION', choices: ['1.5', '2.5', '3.5'], description: 'Choose a version to deploy')
                ]

            echo "This is for Package ${selectedVersion}"

            // Use SSH agent for credentials
            sshagent(['slave2']) {
                sh '''
                    scp -o StrictHostKeyChecking=no server-script.sh ec2-user@3.109.154.51:/home/ec2-user
                    ssh -o StrictHostKeyChecking=no ec2-user@3.109.154.51 "bash ~/server-script.sh"
                '''
            }
        }
    }
}

    }
}
