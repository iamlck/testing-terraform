output "cp" {
  value = aws_ecs_capacity_provider.cp.name
}
output "sg" {
  value = aws_security_group.sg.id
}
output "redis_sg" {
  value = aws_security_group.redis_sg.id
}
output "ip_role" {
  value = local.iam_instance_profile
}