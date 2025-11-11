resource "aws_ecs_task_definition" "app" {
  family                   = local.task_family_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOT
[
  {
    "name": "app-container",
    "image": "account-id.dkr.ecr.sa-east-1.amazonaws.com/image-test:id-tag",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "essential": true
  }
]
EOT
}