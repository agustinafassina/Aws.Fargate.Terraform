resource "aws_ecs_cluster" "cluster" {
  name = local.ecs_cluster_name
}