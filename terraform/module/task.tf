resource "aws_ecs_task_definition" "application_task" {
  family                   = "${var.project_name}-${var.env}"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.project_name}-${var.env}",
      "image": "${aws_ecr_repository.application_ecr_repo.repository_url}:${var.docker_image_tag}",
      "essential": true,
      "environment": [
        {
          "name": "NODE_ENV",
          "value": "${var.node_env}"
        }
      ],
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.app_log_group.name}",
          "awslogs-region": "eu-west-2",
          "awslogs-stream-prefix": "${var.project_name}-"
        }
      },
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_execution_role.arn
}

resource "aws_ecs_service" "application_ecs" {
  name            = "${var.project_name}-ecs-${var.env}"
  cluster         = aws_ecs_cluster.application_cluster.id
  task_definition = aws_ecs_task_definition.application_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.application_target_group.arn
    container_name   = aws_ecs_task_definition.application_task.family
    container_port   = 3000
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.application_subnet_a.id}", "${aws_default_subnet.application_subnet_b.id}", "${aws_default_subnet.application_subnet_c.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.application_service_security_group.id}"]
  }
}
