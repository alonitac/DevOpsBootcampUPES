pipeline {
    agent any

    environment {
        PATH = "/var/lib/jenkins/.local/bin:${env.PATH}"
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    parameters {
        string(name: 'serverGroup', defaultValue: 'all')
        choice(name: 'region', choices: ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2', 'eu-central-1', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1'])
    }

    stages {
        stage("Init") {
            steps {
                sh 'python3 -m pip install ansible'
                sh 'ansible-galaxy collection install community.general'
            }
        }

        stage("Generate Inventory") {
            steps {
                sh 'aws ec2 describe-instances --region ${region} --filters "Name=tag:serverGroup,Values=${serverGroup}" --query "Reservations[].Instances[]" > hosts.json'
                sh 'python3 ansible_inv_gen.py'
            }
        }

        stage('Check') {
            steps {
                sh ''
            }
        }

        stage('Play') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: '<ssh-credentials-id>', usernameVariable: 'ssh_user', keyFileVariable: 'privatekey')]) {
                    sh '''
                    ansible-playbook site.yaml --extra-vars "hosts=${serverGroup}" --user=${ssh_user} -i hosts --private-key ${privatekey}
                    '''
                }
            }
        }
    }
}