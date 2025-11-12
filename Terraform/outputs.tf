output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_node_group_name" {
  value = module.eks.eks_node_group_name
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}
