pipeline {
    agent any

    tools {
        jdk 'JDK17'
    }

    stages {
        stage('Build and Test') {
            steps {
                dir('apps/webbooks') {
                    // ВСЕГДА даём права — даже если Git их не сохранил
                    sh 'chmod +x ./mvnw'
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
                        script: 'basename target/*.jar',
                        returnStdout: true
                    ).trim()
                    build job: 'webbooks-deploy',
                         parameters: [
                             string(name: 'JAR_FILE', value: jarName),
                             string(name: 'CI_BUILD_NUMBER', value: env.BUILD_NUMBER)
                         ],
                         wait: false
                }
            }
        }
    }
}
