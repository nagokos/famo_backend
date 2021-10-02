variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "production"
}

variable "app_name" {
  type    = string
  default = "famo"
}

variable "domain" {
  type    = string
  default = "famo.work"
}

variable "s3_bucket_name" {
  type    = string
  default = "tfstate-terraform-famo"
}

variable "dynamodb_name" {
  type    = string
  default = "famo-dynamodb"
}

variable "db_name" {
  type    = string
  default = "rails-famo"
}

variable "db_username" {
  type    = string
  default = "root"
}

variable "db_password" {
  type    = string
  default = "password"
}
