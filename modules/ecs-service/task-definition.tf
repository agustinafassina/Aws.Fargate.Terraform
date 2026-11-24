locals {
  container_definition = {
    name      = var.container_name
    image     = var.container_image
    essential = true

    portMappings = var.container_port == null ? [] : [
      {
        containerPort = var.container_port
        hostPort      = var.container_port
        protocol      = "tcp"
      }
    ]

    environment = [
      for name, value in var.environment_variables : {
        name  = name
        value = value
      }
    ]

    secrets = [
      for name, value_from in var.secrets : {
        name      = name
        valueFrom = value_from
      }
    ]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.service.name
        awslogs-region        = var.region
        awslogs-stream-prefix = var.container_name
      }
    }
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = var.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.cpu)
  memory                   = tostring(var.memory)
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  container_definitions    = jsonencode([local.container_definition])
}
