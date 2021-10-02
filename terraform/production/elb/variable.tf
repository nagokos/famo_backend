variable "app_name" {}

variable "vpc_id" {}

variable "public_subnet_ids" {}

variable "acm_id" {}

variable "domain" {}

variable "ingress_ports" {
  type    = list(number)
  default = [80, 443]
}
