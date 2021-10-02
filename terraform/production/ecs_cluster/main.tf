locals {
  name = "rails-famo"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.name
}
