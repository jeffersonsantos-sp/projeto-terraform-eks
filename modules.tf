module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = local.tags

}


module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  subnet_public_1a = module.eks_network.subnet-public-1a
  subnet_public_1b = module.eks_network.subnet-public-1b
}


module "eks_nodes" {
  source            = "./modules/managed-nodes"
  project_name      = var.project_name
  tags              = local.tags
  cluster_name      = var.cluster_name
  subnet-private-1a = module.eks_network.subnet-private-1a
  subnet-private-1b = module.eks_network.subnet-private-1b

}

module "k8s" {
  source = "./modules/kubernetes"
}