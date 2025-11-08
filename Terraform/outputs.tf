output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "node_group_name" {
  value = module.eks.node_group_name
}

output "certificate_arn" {
  value = module.route53-acm.certificate_arn
}

output "hosted_zone_id" {
  value = module.route53-acm.hosted_zone_id
}

