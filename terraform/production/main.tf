provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.60.0"
    }
  }
  backend "s3" {
    bucket         = "tfstate-terraform-famo" # 作成したS3バケット
    region         = "ap-northeast-1"
    profile        = "production"
    key            = "terraform.tfstate"
    dynamodb_table = "famo-dynamodb"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Terraform = "true"
    Name      = "terraform"
  }
}

resource "aws_dynamodb_table" "terraform_and_rails_state_lock" {
  name         = var.dynamodb_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform = "true"
    Name      = "terraform"
  }
}

module "network" {
  source = "./network"

  app_name = var.app_name
}

module "acm" {
  source = "./acm"

  domain = var.domain
}

module "elb" {
  source = "./elb"

  app_name          = var.app_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  acm_id            = module.acm.acm_id
  domain            = var.domain
}

module "ecs_cluster" {
  source = "./ecs_cluster"
}

module "rds" {
  source = "./rds"

  app_name           = var.app_name
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  vpc_id             = module.network.vpc_id
  alb_security_group = module.elb.alb_security_group
  private_subnet_ids = module.network.private_subnet_ids
}

module "ecs_rails" {
  source = "./ecs_rails"

  app_name           = var.app_name
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_host            = module.rds.db_address
  vpc_id             = module.network.vpc_id
  http_listener_arn  = module.elb.http_listener_arn
  https_listener_arn = module.elb.https_listener_arn
  alb_security_group = module.elb.alb_security_group
  cluster_name       = module.ecs_cluster.cluster_name
  public_subnet_ids  = module.network.public_subnet_ids
}

module "s3" {
  source = "./s3"

  bucket_name = "famo-avatar-bucket"
}

module "ecs_task_schedule" {
  source = "./ecs_task_schedule"

  cluster_arn         = module.ecs_cluster.cluster_arn
  task_definition_arn = module.ecs_rails.task_definition_arn
  public_subnet_ids   = module.network.public_subnet_ids
  alb_security_group  = module.elb.alb_security_group
}
