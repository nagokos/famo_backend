resource "aws_iam_role" "ecs_scheduledtasks_role" {
  name = "Ecs_Scheduled_Tasks_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_scheduledtasks_role_attach" {
  role       = aws_iam_role.ecs_scheduledtasks_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = "every-thursday-rake-task"
  description         = "毎週木曜日に選手の評価点を更新するタスクを実行"
  schedule_expression = "cron(0 15 ? * THU *)"
}

resource "aws_cloudwatch_event_target" "target" {
  target_id = aws_cloudwatch_event_rule.event_rule.id
  arn       = var.cluster_arn
  rule      = aws_cloudwatch_event_rule.event_rule.name
  role_arn  = aws_iam_role.ecs_scheduledtasks_role.arn
  input     = templatefile("${path.module}/player_task.json", {})

  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    task_definition_arn = var.task_definition_arn
    network_configuration {
      subnets          = var.public_subnet_ids
      security_groups  = [var.alb_security_group.id]
      assign_public_ip = true
    }
  }
}
