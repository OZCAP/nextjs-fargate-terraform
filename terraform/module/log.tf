resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "${var.project_name}-${var.env}"
  tags = {
    Environment = var.env
    Project    = var.project_name
  }
}