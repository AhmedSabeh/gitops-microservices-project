variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {type = list(string)}
variable "azs" {type = list(string)}
variable "cluster_name" {}
variable "key_name" {}
variable "sns_email" {}
variable "region" {  default = "us-east-1"  }

variable "domain_name" {
  description = "The domain name for ACM certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for the domain"
  type        = string
}

