terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  access_key               = var.aws_access_key_id
  secret_key               = var.aws_secret_access_key
  region                   = var.region
}

locals {
  environment              = terraform.workspace
  aws_profile              = var.profile
  ecs_cluster_name         = "tf-${local.environment}-${local.aws_profile}-ecs"
  ecs_role_name            = "tf-${local.environment}-${local.aws_profile}-execution-role"
  ecs_fargate_name         = "tf-${local.environment}-${local.aws_profile}-project-docker"
  ecs_security_group_name  = "tf-${local.environment}-${local.aws_profile}-sg"
  task_family_name         = "tf-${local.environment}-${local.aws_profile}-project-docker"
  ecr_name                 = "tf-${local.environment}-${local.aws_profile}-ecr-image"
}

module "ecs-cluster" {
  source = "./modules/ecs-cluster"

  environment              = local.environment
  ecs_cluster_name         = local.ecs_cluster_name
  ecs_security_group_name  = local.ecs_security_group_name
  vpc_id                   = var.vpc_id
  subnets                  = var.subnets
  ecs_fargate_name         = local.ecs_fargate_name
  task_family_name         = local.task_family_name
  cpu                      = var.cpu
  memory                   = var.memory
  ecs_task_role_arn        = module.iam.ecs_task_role_arn
}

module "ecr" {
  source = "./modules/ecr"
  ecr_name               = local.ecr_name
}
module "iam" {
  source = "./modules/iam"
  ecs_role_name          = local.ecs_role_name
}