# Find the ASG for the EKS node group
data "aws_autoscaling_groups" "eks_node_asg" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = [var.node_group_name]
  }
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "${var.cluster_name}-alerts-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

# CloudWatch CPU Alarm for EKS Node Group
resource "aws_cloudwatch_metric_alarm" "node_group_avg_cpu" {
  alarm_name          = "${var.cluster_name}-HighCPU"
  alarm_description   = "High CPU across EKS Node Group"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.metric_period
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    AutoScalingGroupName = data.aws_autoscaling_groups.eks_node_asg.names[0]
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]
}

