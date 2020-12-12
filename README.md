# Based on Terraform AWS Free Tier git project

Added installation of Git, Docker, Docker Compose, to ultimately setup Fabric-Test Network on Docker

[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](./LICENSE)

### Project description

This is a [Terraform](https://www.terraform.io/) project that creates a Fabric-Test network. 

It can build the next infrastructure:

* A [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) in the us-east-2
* A public [Subnet](https://docs.aws.amazon.com/vpc/latest/userguide/working-with-vpcs.html#AddaSubnet) in the `VPC` using us-east-2b AZ
* An [IGW](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) to enable access to or from the Internet for `VPC`
* A [Route Table](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) to associate `IGW`, `VPC` and `Subnet`
* An [EC2 Instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html) in the public `Subnet` with SSH access using AMI of Ubuntu 18.04 rel. 20201211.1
* Install git, docker, docker-compose and Fabric-Test Network via user_data file src/free-tier/install.sh

### Pre steps

1. [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
2. Create AWS account
3. If the file `~/.aws/credentials` does't exist, create it and add you Terraform profile to the file. For example:
   ```text
   [terraform]
   aws_access_key_id = Your access key
   aws_secret_access_key = Your secret access key 
   ```
4. Create S3 bucket to store Terraform state
5. Create config file `./src/free-tier/backend/config.tf` that will contain information how to store state in a given bucket. See [example](./src/free-tier/backend/example.config.tf).
6. Create SSH key pair to connect to EC2 instance:
   ```bash
   cd ./src/free-tier/provision/access

   # it creates "free-tier-ec2-key" private key and "free-tier-ec2-key.pub" public key
   ssh-keygen -f free-tier-ec2-key
   ``` 
   
### Build infrastructure

1. `cd ./src/free-tier`
2. `terraform init -backend-config="./backend/config.tf"`
3. `terraform plan`
4. `terraform apply`

### Post steps

After building the infrastructure you can try to connect to you `EC2 instance` via SSH:

1. `cd ./src/free-tier`
2. `ssh -i ./provision/access/free-tier-ec2-key ubuntu@[EC2 public IP]`
3. `cat /tmp/postinstall.log` should produce the following output

git version 2.17.1
Docker version 20.10.0, build 7287ab3
docker-compose version 1.27.4, build 40524192
CONTAINER ID   IMAGE                               COMMAND             CREATED         STATUS                  PORTS                              NAMES
e7740e6fcb4e   hyperledger/fabric-peer:latest      "peer node start"   5 seconds ago   Up 2 seconds            0.0.0.0:7051->7051/tcp             peer0.org1.example.com
fef5d5404df5   hyperledger/fabric-peer:latest      "peer node start"   5 seconds ago   Up Less than a second   7051/tcp, 0.0.0.0:9051->9051/tcp   peer0.org2.example.com
3d8b21c0e822   hyperledger/fabric-orderer:latest   "orderer"           5 seconds ago   Up 1 second             0.0.0.0:7050->7050/tcp             orderer.example.com

4. To see error messages from postinstall check the contents of /var/log/cloud-init-output.log

To destroy infrastructure:

1. `cd ./src/free-tier`
2. `terraform destroy`
