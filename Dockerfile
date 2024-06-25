pipeline {
    agent {
        docker {
            // Utiliza una imagen Docker que tenga Jenkins, Maven, o el entorno que necesites
            image 'maven:3.8.4-openjdk-11' 
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Mapea el socket de Docker para poder ejecutar Docker desde dentro del contenedor
        }
    }
    
    stages {
        stage('Build') {
            steps {
                // Ejemplo de cómo ejecutar un comando Maven dentro del contenedor Docker
                sh 'mvn --version'
                sh 'mvn clean install'
            }
        }
        
        stage('Test') {
            steps {
                // Ejemplo de cómo ejecutar pruebas dentro del contenedor Docker
                sh 'mvn test'
            }
        }
        
        stage('Deploy') {
            steps {
                // Ejemplo de cómo construir y desplegar una imagen Docker
                sh 'docker build -t mi-aplicacion .'
                sh 'docker run -d -p 8080:8080 mi-aplicacion'
            }
        }
    }
}
