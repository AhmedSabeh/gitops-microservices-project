output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_cluster_security_group_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}

output "eks_node_group_name" {
  value = aws_eks_node_group.eks_nodes.node_group_name
}

output "eks_node_asg_name" {
  value = aws_eks_node_group.eks_nodes.resources[0].autoscaling_groups[0].name
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

