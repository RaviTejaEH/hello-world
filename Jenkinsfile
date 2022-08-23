pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('initialize'){
            steps{
                echo "PATH = ${PATH}"
                echo 'executed 1st command'
                echo "M2_HOME = ${M2_HOME}"
                echo 'executed 2nd command' 
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Deploy to container'){
            steps{
                sshagent(['tomcat-deployer']){
                    sh 'scp -o StrictHostKeyChecking=no /root/.jenkins/workspace/Sample Build-Pipeline Script/webapp/target/*.war root@192.168.244.133:/opt/apache-tomcat-10.0.23/webapps/webapp.war'
                    }
            }
        }
    }
}
