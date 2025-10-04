pipeline {
    agent any

    tools {
        jdk 'JDK17'        // ← то имя, что ты задал в Global Tool Configuration
        maven 'Maven3'     // (опционально, если настроил Maven там же)
    }

    stages {
        stage('Build and Test') {
            steps {
                dir('apps/webbooks') {
                    sh './mvnw -B clean package'
                }
            }
        }

        stage('Deploy if main') {
            when {
                branch 'main'
            }
            steps {
                dir('apps/webbooks') {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
                script {
                    def jarName = sh(
                        script: 'basename apps/webbooks/target/*.jar',
                        returnStdout: true
                    ).trim()
                    build job: 'webbooks-deploy',
                         parameters: [
                             string(name: 'JAR_FILE', value: jarName)
                         ],
                         wait: false
                }
            }
        }
    }
}
