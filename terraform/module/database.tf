#################################################################
# UNCOMMENT FOR DATABASE - the whole file (5 of 5)
#################################################################
# resource "aws_vpc" "allopen-vpc" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true
# }

# resource "aws_internet_gateway" "open_gateway" {
#   vpc_id = aws_vpc.allopen-vpc.id
# }

# resource "aws_route" "internet-route" {
#   route_table_id         = aws_vpc.allopen-vpc.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.open_gateway.id
# }

# data "aws_availability_zones" "available" {
#   state = "available"
# }

# resource "aws_subnet" "allopen-subnets" {
#   count                   = length(data.aws_availability_zones.available.names)
#   vpc_id                  = aws_vpc.allopen-vpc.id
#   cidr_block              = "10.0.${count.index}.0/24"
#   map_public_ip_on_launch = true
#   availability_zone       = element(data.aws_availability_zones.available.names, count.index)
# }

# resource "aws_db_subnet_group" "postgresql_subnet_group" {
#   name        = "${var.project_name}-allopensubgroup-${var.env}"
#   description = "Postgres database open to the world"
#   subnet_ids  = aws_subnet.allopen-subnets.*.id

# }

# resource "aws_security_group" "allopen-sg" {
#   name        = "${var.project_name}-allopen-sg-${var.env}"
#   description = "AllOpen security group"
#   vpc_id      = aws_vpc.allopen-vpc.id
#   # Allow all inbound traffic
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Allow all outbound traffic.
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_db_instance" "db" {
#   identifier                   = "${var.project_name}-${var.env}-rds"
#   depends_on                   = [aws_internet_gateway.open_gateway]
#   allocated_storage            = 20
#   vpc_security_group_ids       = [aws_security_group.allopen-sg.id]
#   db_subnet_group_name         = aws_db_subnet_group.postgresql_subnet_group.name
#   engine                       = "postgres"
#   engine_version               = "14.7"
#   username                     = var.db_username
#   db_name                      = var.db_username
#   password                     = var.db_password
#   instance_class               = "db.t4g.micro"
#   publicly_accessible          = true
#   skip_final_snapshot          = true
#   allow_major_version_upgrade  = true
#   auto_minor_version_upgrade   = true
#   performance_insights_enabled = true
#   apply_immediately            = true
# }

