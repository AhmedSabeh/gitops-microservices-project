output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.db-endpoint.id
}

output "vpc_endpoint_arn" {
  value = aws_vpc_endpoint.db-endpoint.arn
}

