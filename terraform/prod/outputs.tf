output "ecr_repo_name" {
  description = "The name of the ECR repository"
  value       = module.app_infra.module_ecr_repo_name
}