data "aws_ecs_task_definition" "app" {
  task_definition = aws_ecs_task_definition.app.family
  depends_on      = [ aws_ecs_task_definition.app ]
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.task_family_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_task_role_arn
  task_role_arn            = var.ecs_task_role_arn

  # container_definitions = file("task-definition-dev.json")
  container_definitions = <<EOT
[
  {
    "name": "dev-project-docker",
    "image": "account-id.dkr.ecr.sa-east-1.amazonaws.com/image-test:id",
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