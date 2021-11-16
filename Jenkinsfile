pipeline {
    agent any
    tools {
      maven 'maven3'
    }  
    stages{
        stage('Build') {
            steps{
                sh 'mvn clean package'
                echo "Build version no: ${POM_VERSION}"               
            }          
        }  
         stage('SonarQube analysis') {
              steps{
                  withSonarQubeEnv('SonarQube 8.9.3') { 
                  sh "mvn sonar:sonar"
                  echo 'Test'    
                 }
             }
        }
        stage("Quality Gate") {
            steps {
               //timeout(time: 1, unit: 'HOURS') {
               //waitForQualityGate abortPipeline: true
             // }
                echo 'Test'
            }
          } 
        stage('Upload war to nexus') {
            steps{
                 nexusArtifactUploader artifacts: [
                     [
                         artifactId: 'WebApp', 
                         classifier: '', 
                         file: 'target/WebApp.war', 
                         type: 'war'
                     ]
                 ], 
                 credentialsId: 'Nexuslogin', 
                 groupId: 'Demoapp', 
                 nexusUrl: '3.16.181.122:8081', 
                 nexusVersion: 'nexus3', 
                 protocol: 'http', 
                 repository: 'demo', 
                 version: '1.1.2'
            }          
        }
        stage('Deploy to prod') {
            steps{
                ansiblePlaybook become: true, becomeUser: 'root', credentialsId: 'ansible', inventory: 'ansible/hosts', playbook: 'ansible/deploy.yaml'
            }          
        }
    }
}
