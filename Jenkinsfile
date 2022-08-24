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
         stage('Checking Git-secrets in Git repo'){
            steps{
                sh 'rm /root/Desktop/trffulehog_report || true'
                sh 'docker rm -f trufflehog || true'
                sh 'docker run -d --name trufflehog trufflehog:1.0 --json https://github.com/RaviTejaEH/hello-world.git > /root/Desktop/trffulehog_report'
                sh 'cat /root/Desktop/trffulehog_report'
            }
        }
        stage('Source-Comppsition-analysis'){
            steps{
                sh 'rm owasp* || true'
                sh 'docker rm -f dependency-check || true'
                sh "wget 'https://raw.githubusercontent.com/RaviTejaEH/hello-world/master/owasp-dependency-check.sh'"
                sh 'chmod +x owasp-dependency-check.sh'
                sh 'bash owasp-dependency-check.sh'
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Deploy to container'){
            steps{
                sh "cp /root/.jenkins/workspace/'Sample Build-Pipeline Script'/webapp/target/*.war /opt/apache-tomcat-10.0.23/webapps/"
            }
        }
    }
}
