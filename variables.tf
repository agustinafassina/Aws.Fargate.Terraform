################### AWS CREDS ##########################

variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "profile"{
  description = "AWS profile"
}

################### EC2 INSTANCE  ##########################

variable "region" {
  description = "AWS region to deploy resources"
}

variable "subnets" {
  description = "Subnet IDs for the Fargate service"
}

variable "cpu" {
  description = "CPU value for the task definition"
}

variable "memory" {
  description = "Memory value for the task definition"
}