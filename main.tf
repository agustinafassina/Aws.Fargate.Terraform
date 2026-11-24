terraform {
  required_version = ">= 1.15.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 7.0.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

locals {
  environment      = terraform.workspace
  aws_profile      = coalesce(var.profile, "default")
  name_prefix      = "tf-${local.environment}-${local.aws_profile}"
  ecs_cluster_name = "${local.name_prefix}-ecs"

  services = {
    for service_name, service in var.services : service_name => merge(service, {
      container_name = coalesce(service.container_name, service_name)
      image          = coalesce(service.image, "${module.ecr[service_name].repository_url}:${service.image_tag}")
    })
  }
}

module "ecs-cluster" {
  source = "./modules/ecs-cluster"

  ecs_cluster_name = local.ecs_cluster_name
}

module "ecr" {
  for_each = var.services

  source   = "./modules/ecr"
  ecr_name = "${local.name_prefix}-${each.key}-ecr"
}

module "iam" {
  source = "./modules/iam"

  ecs_execution_role_name = "${local.name_prefix}-execution-role"
  ecs_task_role_name      = "${local.name_prefix}-task-role"
}

module "ecs-service" {
  for_each = local.services

  source = "./modules/ecs-service"

  environment            = local.environment
  region                 = var.region
  service_name           = "${local.name_prefix}-${each.key}"
  cluster_id             = module.ecs-cluster.cluster_id
  vpc_id                 = var.vpc_id
  subnets                = var.subnets
  assign_public_ip       = each.value.assign_public_ip
  container_name         = each.value.container_name
  container_image        = each.value.image
  container_port         = each.value.container_port
  cpu                    = each.value.cpu
  memory                 = each.value.memory
  desired_count          = each.value.desired_count
  environment_variables  = each.value.environment_variables
  secrets                = each.value.secrets
  ingress_cidr_blocks    = each.value.ingress_cidr_blocks
  log_retention_in_days  = each.value.log_retention_in_days
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn
}