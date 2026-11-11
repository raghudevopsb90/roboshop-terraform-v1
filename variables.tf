variable "aws_region" {
  description = "AWS region. ami-0eec78ea4cbaaf5bd exists in us-east-1."
  type        = string
}

variable "environment" {
  description = "Deployment environment name used in tags and DNS."
  type        = string
}

variable "ami_id" {
  description = "Fixed RHEL 10 AMI ID. Do not replace this with a data source lookup."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for every RoboShop component."
  type        = string
}

variable "domain_name" {
  description = "Route53 domain name. The hosted zone must already exist."
  type        = string
}

variable "hosted_zone_id" {
  description = "Existing Route53 hosted zone ID. Terraform does not create this zone."
  type        = string
}

variable "ansible_password" {
  description = "SSH and Ansible password"
  type        = string
}

variable "ansible_user" {
  description = "SSH and Ansible user"
  type        = string
}


