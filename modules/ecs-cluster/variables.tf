########################### ECS ############################################

variable "ecs_cluster_name" {
  description = "ECS cluster name"
}

variable "ecs_security_group_name" {
  description = "ECS security group name"
}

variable "subnets" {
  description = "Subnets"
}

variable "ecs_fargate_name" {
  description = "ECS Fargate service name"
}

variable "task_family_name" {
  description = "ECS task family name"
}

variable "cpu" {
  description = "CPU units for the task"
}

variable "memory" {
  description = "Memory for the task"
}

variable "environment" {
  description = "Environment variables for the container"
}

variable "ecs_task_role_arn" {
  description = "ARN del rol IAM para las tareas ECS"
}
