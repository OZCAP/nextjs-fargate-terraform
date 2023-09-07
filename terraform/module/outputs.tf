output "module_ecr_repo_name" {
  value       = aws_ecr_repository.application_ecr_repo.name
  description = "The name of the ECR repository"
}