resource "aws_vpc_endpoint" "db-endpoint" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids

  tags = {
    Name = "${var.project_name}-dynamodb-endpoint"
  }
}

