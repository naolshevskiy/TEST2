pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            steps {
                dir('apps/webbooks') {
                    sh './mvnw clean package -DskipTests=false'
                }
            }
        }

        stage('Publish Artifact and Trigger Deploy') {
            when {
                branch 'main'
            }
            steps {
                dir('apps/webbooks') {
                    // Архивируем JAR из target/
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }

                script {
                    // Получаем имя JAR-файла
                    def jarName = sh(
                        script: 'cd apps/webbooks && ls target/*.jar | xargs basename',
                        returnStdout: true
                    ).trim()

                    // Запускаем деплой-пайплайн
                    build job: 'webbooks-deploy',
                          parameters: [
                              string(name: 'JAR_FILE', value: jarName),
                              string(name: 'BUILD_NUMBER', value: env.BUILD_NUMBER)
                          ],
                          wait: false
                }
            }
        }
    }
}
