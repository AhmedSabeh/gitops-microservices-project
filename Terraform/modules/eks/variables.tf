variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.31"
}

variable "private_subnets" {
  description = "List of private subnet IDs for EKS worker nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "EC2 instance types for worker nodes"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

