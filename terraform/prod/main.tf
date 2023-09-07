provider "aws" {
  region = "eu-west-2"
}

module "app_infra" {
  source                = "../module"
  project_name          = "nextjs-fargate-terraform"
  env                   = "prod"
  desired_count         = 1
  docker_image_tag      = var.docker_image_tag

  # UNCOMMENT FOR DATABASE (3 of 5)
  # db_username           = "nextjs-fargate-terraform-prod"
  # db_password           = var.db_password
}