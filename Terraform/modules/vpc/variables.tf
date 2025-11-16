variable "project_name" {}
variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "cluster_name" {
  description = "EKS cluster name, used for tagging subnets"
  type        = string
}
