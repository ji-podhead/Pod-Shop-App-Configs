pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: 'main']],
                     userRemoteConfigs: [[
                        url: 'git@github.com:the-pod-shop/Pod-Shop-App-Configs.git',
                        credentialsId: 'git'
                    ]])
            }
        }

       stage('info') {
            steps {
                script {
                    sh'''
                  ls
                  '''
                  
                }
            }
       }
       stage('Retrieve All Secrets') {
            steps {
                script {
                    export VAULT_ADDR='http://127.0.0.1:8200'
                    // Definieren der Vault-Endpunkt-URL
                    def vaultEndpoint = 'https://your-vault-server/v1/keyvalue'
                    
                    // Laden der Liste der Secrets aus der Textdatei
                    def secretsText = readFile './terraform/secrets.txt'.trim()

                    // Durchlaufen der Liste und Abrufen jedes Secrets
                    secretsText.split('\n').each { line ->
                        def parts = line.split(/\s+/)
                        if (parts.size() == 2) {
                            def secretPath = parts[0]
                            def secretKey = parts[1]

                            // Abrufen des Geheimnisses aus Vault
                            def secretValue = sh(script: """
                                vault kv get -format=json '${vaultEndpoint}/${secretPath}' | jq -r '.data.data.${secretKey}'
                            """.trim(), returnStdout: true).trim()

                            echo "Retrieved '${secretKey}' from '${secretPath}': ${secretValue}"
                        }
                    }
                }
            }
        }
        
       
               stage('Analyze Terraform Plan with Checkov') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN')]) {
                        sh '''
                                echo "--------remove old  plan -------"
                                cd terraform     # we need to cd to terraform in every stage
                                rm -f ./*.binary
                                rm -f ./*.xml
                                rm -f ./*.plan
                                rm -f ./*.json
                                ls -la
                                
             
                                
                                echo "--------start terraform plan -------"
                                terraform init -upgrade
                                terraform plan -var="vault_token=${VAULT_TOKEN}" --out tfplan.binary
                                terraform show -json tfplan.binary | jq > tfplan.json
                                ls -la
                                
                                echo "-------- checkov scan -------"
                                checkov -f tfplan.json -o junitxml
                                chmod +x ./checkov_results.xml
                                ls -la
                                cat tfplan.json
                                cat ./checkov_results.xml
                                

                                
                                
                            '''
                    }
                }
            }
        }
    }
    post {
        always {
            withChecks(name: 'test', includeStage: true) {
                junit 'checkov_results.xml'
            }
        }
    }
}

options {
    preserveStashes()
    timestamps()
}
