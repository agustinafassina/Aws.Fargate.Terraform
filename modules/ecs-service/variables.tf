variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the service runs"
  type        = string
}

variable "subnets" {
  description = "Subnet IDs for the Fargate service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign a public IP to the Fargate task"
  type        = bool
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image URI"
  type        = string
}

variable "container_port" {
  description = "Container port to expose. Leave null for workers without inbound traffic."
  type        = number
  nullable    = true
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
}

variable "memory" {
  description = "Memory for the task"
  type        = number
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "environment_variables" {
  description = "Environment variables for the container"
  type        = map(string)
}

variable "secrets" {
  description = "Container secrets where the value is a Secrets Manager or SSM parameter ARN"
  type        = map(string)
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks allowed to reach the container port"
  type        = list(string)
}

variable "log_retention_in_days" {
  description = "CloudWatch Logs retention in days"
  type        = number
}

variable "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}
