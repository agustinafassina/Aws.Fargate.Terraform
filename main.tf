terraform {
    required_version = "= 0.13.4"
}

 provider "aws" {
    access_key               = var.aws_access_key_id
    secret_key               = var.aws_secret_access_key
    shared_credentials_files = ["$HOME/.aws/credentials"]
    region                   = var.region
}

locals  {
    environment              = terraform.workspace
    ecs_cluster_name         = "tf-${local.environment}-test-ecs"
    ecs_role_name            = "tf-${local.environment}-test-execution-role"
    ecs_fargate_name         = "tf-${local.environment}-test-fargate-service"
    ecs_security_group_name  = "tf-${local.environment}-test-sg"
    task_family_name         = "tf-${local.environment}-test-task-family"
    ecr_name                 = "tf-${local.environment}-test-ecr-repo"
}
