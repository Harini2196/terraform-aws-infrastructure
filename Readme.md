# Infrastructure as Code

* removes manual effort for repeatable infrastructure provisioning.
* Consistency across environments.
* manageable infrastructure.
* Allows Version control
* Speeds up automation


# Why Terraform ?
* Cloud Agnostic
* Open Source
* Track changes by maintaining state of the current infrastructure.
* Developer friendly, JSON like code structure.
* Concurrency

# Terraform Installation
If you wish you to install specific version of terraform use

## Windows
Unzip the downloaded file. move the terraform executable file to working directory

''' https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_darwin_amd64.zip'''

## Mac
'''
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
'''

## Linux

### Centos
    '''
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install terraform
    '''
### Ubuntu
'''
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
'''

Terraform versions can be managed by tfenv.
https://github.com/tfutils/tfenv


### Terraform documentation
https://developer.hashicorp.com/terraform/cli

### AWS resource cofiguration using terraform
https://registry.terraform.io/providers/hashicorp/aws/latest/docs
