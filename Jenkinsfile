pipeline {
    agent none

tools {

     maven  "mymaven" 
}

    stages {
        
        stage('Compile') { //prod
	    agent any	
            steps {
                echo "This is for compile"
                sh "mvn compile"

            }

        }
        
        stage('Test') { //Test
	    agent any
            steps {
                  echo "This is for Test"
                  sh "mvn test"
            }

        }
        
        stage('Package') { //Dev
	    agent {label 'linux_slave'}

            steps {
                
                echo "This is for Package"
                sh "mvn package"

            }

        }        
    }
}

