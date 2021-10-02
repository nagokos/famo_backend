data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "log" {
  count = length(var.apps_name)
  name  = "/ecs/rails-famo/${var.apps_name[count.index]}"
}

module "iam_role" {
  source = "../iam_role"

  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy_arn = data.aws_iam_policy.ecs_task_excution_role_policy.arn
}

resource "aws_lb_target_group" "target_group" {
  name = "rails-famo"

  vpc_id = var.vpc_id

  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port = 80
    path = "/"
  }
}

resource "aws_lb_listener_rule" "http_rule" {
  listener_arn = var.http_listener_arn

  action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.target_group.arn

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_listener_rule" "http_to_https" {
  listener_arn = var.https_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.app_name

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = templatefile("${path.module}/container_definitions.json", {
    account_id  = data.aws_caller_identity.current.account_id
    db_name     = var.db_name
    db_host     = var.db_host
    db_username = var.db_username
  })
  execution_role_arn = module.iam_role.iam_role_arn
}

resource "aws_ecs_service" "ecs_service" {
  name                              = "${var.app_name}-service"
  launch_type                       = "FARGATE"
  desired_count                     = "1"
  cluster                           = var.cluster_name
  task_definition                   = aws_ecs_task_definition.task_definition.arn
  health_check_grace_period_seconds = 3600

  network_configuration {
    security_groups  = [var.alb_security_group.id]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }
}
