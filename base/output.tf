output "name" {
 value = aws_ecr_repository.ecr.name
}
output "url" {
  value = aws_ecr_repository.ecr.repository_url
}
output "arn" {
  value = aws_ecr_repository.ecr.arn
}