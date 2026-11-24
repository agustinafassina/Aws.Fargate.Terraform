resource "aws_ecs_service" "service" {
  name                 = var.service_name
  cluster              = var.cluster_id
  task_definition      = aws_ecs_task_definition.service.arn
  launch_type          = "FARGATE"
  desired_count        = var.desired_count
  force_new_deployment = true

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.service.id]
    assign_public_ip = var.assign_public_ip
  }
}
