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