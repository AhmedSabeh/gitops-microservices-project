module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.cluster_name
  cluster_version   = "1.31"
  private_subnets   = module.vpc.private_subnet_ids
  instance_types    = ["t3.micro"]
  desired_size      = 2
  min_size          = 1
  max_size          = 2
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  table_name   = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
}

module "vpc_endpoint" {
  source          = "./modules/vpc-endpoint"
  vpc_id          = module.vpc.vpc_id
  route_table_ids = module.vpc.private_route_table_ids
  project_name    = var.project_name
  region          = var.region
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  region            = var.region
  cluster_name      = var.cluster_name
  node_group_name   = module.eks.eks_node_group_name
  sns_email         = var.sns_email
  depends_on        = [ module.eks ]
}
