pipeline {
    agent any

    stages {        
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }
       stage ("terraform validate script") {
            steps {
                sh ('terraform validate') 
            }
        }
        stage ("plan") {
            steps {
                sh ('terraform plan') 
            }
        }
        stage ("Validate apply") {
            input {
                message "Are you sure you want to apply this plan?"
                ok "Apply this plan."
            }
            steps{
                echo "Apply command has been accepted"
            }
        }
        stage (" Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve -var-file="dev.tfvars"')
           }
        }
    }
}

