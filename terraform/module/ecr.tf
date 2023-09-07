resource "aws_ecr_repository" "application_ecr_repo" {
  name = "${var.project_name}-repo-${var.env}"
  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_ecr_lifecycle_policy" "application_ecr_repo_policy" {
  repository = aws_ecr_repository.application_ecr_repo.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["${var.project_name}"],
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}