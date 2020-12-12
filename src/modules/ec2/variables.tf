variable "ec2_should_be_created" {
  description = "Should the EC2 be created?"
  type        = bool
  default     = true
}

variable "ec2_name" {
  description = "The Name of the EC2"
  type        = string
  default     = "Fabric-Test EC2"
}

variable "ec2_security_group_name" {
  description = "The Name of the EC2 Security Group"
  type        = string
  default     = "Fabric-Test EC2 Security Group"
}

variable "ec2_security_group_description" {
  description = "The Description of the EC2 Security Group"
  type        = string
  default     = "Fabric-Test EC2 Security Group"
}

variable "ec2_ami" {
  description = "The Amazon Machine Image"
  type        = string
  default     = "ami-0b9487791bf873774" # Ubuntu 18.04 LTS (64-bit x86)  Fabric-Test eligible
}

variable "ec2_instance_type" {
  description = "The EC2 Instance type"
  type        = string
  default     = "t2.micro" # Fabric-Test eligible
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the Public Subnet"
  type        = string
}

variable "ec2_ssh_key_name" {
  description = "The SSH Key Name"
  type        = string
  default     = "Fabric-Test-ec2-key"
}

variable "ec2_ssh_public_key_path" {
  description = "The local path to the SSH Public Key"
  type        = string
}
