
pipeline {
	agent any 
	
	environment { 
        registry = "nourheneabbes/timesheet-devops" 
        registryCredential = 'dockerHub'
        dockerImage = '' 
    }


	stages{
	        
				
	        stage('Cloning our Git'){
					steps{
						git 'https://github.com/Nourhene-abbes/test.git' 
					}				
				}
			stage ("Verification du  version Maven..."){
			steps{
				bat """mvn -version"""
			}
		}

		stage ("Clean..."){
			steps{
				bat """mvn clean"""
			}
			
		}

		stage ("Creation du livrable..."){
			steps{
				bat """mvn package -Dmaven.test.skip=true"""
			}
		}

		stage ("Lancement des Tests Unitaires..."){
			steps{
				bat """mvn test"""
			}
		}

		stage ("Analyse avec Sonar..."){
			steps{
				bat """mvn sonar:sonar"""
			}
		}

		stage ("Deploiement dans Nexux..."){
			steps{
				bat """mvn clean package -Dmaven.test.skip=true deploy:deploy-file -DgroupId=tn.esprit.spring -DartifactId=timesheet -Dversion=3.0 -DgeneratePom=true -Dpackaging=jar -DrepositoryId=deploymentRepo -Durl=http://localhost:8081/repository/maven-releases/ -Dfile=target/timesheet-4.3.jar"""
			}
		}

		stage('Building Image'){
				steps{
					script{
						dockerImage = docker.build registry + ":$BUILD_NUMBER"
					}
				}				
			}

		stage('Deploy our image') {
                	steps {
                    	script {
                        	docker.withRegistry('', registryCredential) {
                           	dockerImage.push()
                    		}
                	}
            	}
      	  }
        	stage('Run Docker-compose') {
                	steps {
                   	bat "docker-compose up"
            	}
        	}
			
	}
	
	
	post{
	   	
        always {
            emailext body: " Bonjour Nounou, \n${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}", subject: "Jenkins Build:${currentBuild.currentResult} -  ${env.JOB_NAME}", to:'$DEFAULT_RECIPIENTS', attachLog: true
        }
		
		

	}
	
	
	} 
