################### AWS CONFIGURATION ##########################

variable "profile" {
  description = "AWS profile"
  type        = string
  default     = null
  nullable    = true
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS resources are deployed"
  type        = string
}

variable "subnets" {
  description = "Subnet IDs for the Fargate service"
  type        = list(string)
}

################### ECS SERVICES ##########################

variable "services" {
  description = "Map of Docker services to deploy in the ECS cluster"
  type = map(object({
    image                 = optional(string)
    image_tag             = optional(string, "latest")
    container_name        = optional(string)
    container_port        = optional(number)
    cpu                   = number
    memory                = number
    desired_count         = optional(number, 1)
    assign_public_ip      = optional(bool, true)
    ingress_cidr_blocks   = optional(list(string), ["0.0.0.0/0"])
    environment_variables = optional(map(string), {})
    secrets               = optional(map(string), {})
    log_retention_in_days = optional(number, 14)
  }))
}