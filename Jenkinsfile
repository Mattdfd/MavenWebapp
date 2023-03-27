pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Mattdfd/MavenWebapp']])

                // Run Maven on a Unix agent.
                //sh "mvn clean install"

                // To run Maven on a Windows agent, use
                bat "mvn clean install"
            }
        }
            stage('Build Docker Image'){
                
                steps{
                    script{
                        bat 'docker build -t mattdfd/maven-lab-3 .'
                    }
                
                }
            }
            stage('login dockerhub'){
                steps{
                    script{
                       withCredentials([string(credentialsId: 'dockhubPwd', variable: 'dockhubPwd')])  {
                        bat "docker login -u mattdfd -p ${dockhubPwd} "
}
                        
                    }
                }
            }
            
            stage("docker push"){
                steps{
                    script{
                        bat "docker push mattdfd/maven-lab-3 "
                    }
                }
            }

           
            
        }
    
}