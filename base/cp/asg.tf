resource "aws_autoscaling_group" "asg" {
  name = local.asg
  vpc_zone_identifier       = var.VPC_SUBNET
  desired_capacity          = var.DESIRED_INSTANCE_COUNT
  min_size                  = var.MIN_INSTANCE_COUNT
  max_size                  = var.MAX_INSTANCE_COUNT
  protect_from_scale_in     = true
  health_check_grace_period = 300
  health_check_type         = "EC2"
  default_cooldown          = 30
  capacity_rebalance        = "true"
  termination_policies      = ["Default"]

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity  = var.ASG_ON_DEMAND_CAPACITY
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.lt.id
      }
    }
  }
}
