#### Returns the ARN of the ECS execution role used by ECS to start tasks ####
output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

#### Returns the ARN of the ECS task role assumed by the running containers ####
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}