output "sns_topic_arn" {
  value       = aws_sns_topic.alerts.arn
  description = "ARN of the SNS topic for CloudWatch alerts"
}

output "cloudwatch_alarm_name" {
  value       = aws_cloudwatch_metric_alarm.node_group_avg_cpu.alarm_name
  description = "Name of the CPU alarm for EKS node group"
}

output "cloudwatch_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.node_group_avg_cpu.arn
  description = "ARN of the CPU alarm"
}

