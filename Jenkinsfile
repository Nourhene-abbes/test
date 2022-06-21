
pipeline {
	agent any 
	
	environment { 
        registry = "nourheneabbes/timesheet-devops" 
        registryCredential = 'dockerHub'
        dockerImage = '' 
    }


	stages{
	  
        	stage('Run Docker-compose') {
                	steps {
                   	bat "docker-compose version"
            	}
        	}
			
	}
	
	
	post{
	   	
        always {
            emailext body: " Bonjour Nounou, \n${currentBuild.currentResult}: Job ${env.JOB_NAME}\nMore Info can be found here: ${env.BUILD_URL}", subject: "Jenkins Build:${currentBuild.currentResult} -  ${env.JOB_NAME}", to:'$DEFAULT_RECIPIENTS', attachLog: true
        }
		
		

	}
	
	

	} 



