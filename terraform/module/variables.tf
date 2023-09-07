variable "docker_image_tag" {
  type = string
}
variable "project_name" {
  type = string
}
variable "domain" {
  type = string
}
variable "env" {
  type = string
}
variable "desired_count" {
  type = number
}
variable "nextauth_secret" {
  type = string
}
variable "google_client_id" {
  type = string
}
variable "google_client_secret" {
  type = string
}
variable "stripe_secret_key" {
  type = string
}
variable "stripe_webhook_secret" {
  type = string
}
variable "stripe_account_id" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
}

# UNCOMMENT FOR DATABASE (4 of 5)
# variable "db_password" {
#   type = string
# }
# variable "db_username" {
#   type = string
# }