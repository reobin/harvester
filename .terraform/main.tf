resource "aws_security_group" "main" {
  name   = "harvester"
  vpc_id = var.aws_vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecr_repository" "main" {
  name = "harvester"
}

resource "aws_ecs_cluster" "main" {
  name = "harvester"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "main" {
  name = "harvester"
}

resource "aws_ecs_task_definition" "main" {
  family = "harvester"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024

  container_definitions = jsonencode([
    {
      name              = "harvester"
      memoryReservation = 512
      image             = "${var.aws_account_id}.dkr.ecr.us-east-1.amazonaws.com/harvester:latest"

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.main.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "harvester"
        }
      }

      environment = [
        {
          name  = "HARVEST_ACCOUNT_ID"
          value = var.harvest_account_id
        },
        {
          name  = "HARVEST_API_TOKEN"
          value = var.harvest_api_token
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "main" {
  name        = "harvester"
  cluster     = aws_ecs_cluster.main.id
  launch_type = "FARGATE"

  task_definition = aws_ecs_task_definition.main.arn
  network_configuration {
    subnets          = var.aws_subnet_ids
    security_groups  = [aws_security_group.main.id]
    assign_public_ip = true
  }
}
