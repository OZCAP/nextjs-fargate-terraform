variable "docker_image_tag" {
  type = string
}
variable "project_name" {
  type = string
}
variable "env" {
  type = string
}
variable "desired_count" {
  type = number
}
variable "node_env" {
  type = string
}

# UNCOMMENT FOR DATABASE (4 of 5)
# variable "db_password" {
#   type = string
# }
# variable "db_username" {
#   type = string
# }