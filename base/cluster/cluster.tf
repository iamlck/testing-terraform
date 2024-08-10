resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name
  
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}




