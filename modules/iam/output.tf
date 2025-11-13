#### Returns the ARN of the ECS Task Role created in this module and used in the ECS Cluster module ####
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}