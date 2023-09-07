terraform {
  backend "s3" {
    # replace with your bucket name
    bucket = "your-bucket-name-here-123"

    key    = "nextjs-fargate-terraform"
    region = "eu-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
