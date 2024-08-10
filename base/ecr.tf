# ELASTIC CONTAINER REGISTRY REPO
resource "aws_ecr_repository" "ecr" {
  name                 = local.ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  encryption_configuration {
    encryption_type = "AES256"
    kms_key         = ""
  }
}

# ECR REPO LIFECYCLE POLICY
resource "aws_ecr_lifecycle_policy" "repo_lifecycle" {
  repository = aws_ecr_repository.ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Set the image's max count of 5",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.RETENTION}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}