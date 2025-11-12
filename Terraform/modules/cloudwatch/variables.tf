variable "region" {
  type    = string
  default = "us-east-1"
}

variable "sns_email" {
  description = "Email to receive CloudWatch alerts"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS Node Group to monitor"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization threshold for alarm"
  type        = number
  default     = 80
}

variable "metric_period" {
  description = "Period in seconds for metric evaluation"
  type        = number
  default     = 300
}

