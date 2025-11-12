variable "vpc_id" {
  description = "VPC ID where the endpoint will be created"
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for private subnets"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

