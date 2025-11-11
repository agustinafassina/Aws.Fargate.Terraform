resource "aws_ecs_service" "app_service" {
  name            = local.ecs_fargate_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.security_group.id]
    assign_public_ip = true
  }
}