variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Partition key for DynamoDB"
  type        = string
  default     = "id"
}

variable "billing_mode" {
  description = "Billing mode: PAY_PER_REQUEST or PROVISIONED"
  type        = string
  default     = "PAY_PER_REQUEST"
}
