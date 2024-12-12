pipeline {
    agent any

tools {

     maven  "mvn_proj" 
}

    stages {
        
        stage('Compile') {
            steps {
                echo "This is for compile"
                sh "mvn compile"

            }

        }
        
        stage('Test') {
            steps {
                  echo "This is for Test"
                  sh "mvn test"
            }

        }
        
        stage('Package') {
            steps {
                
                echo "This is for Package"
                sh "mvn package"

            }

        }        
    }
}

