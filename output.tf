output "eks_network_vpc" {
  value = module.eks_network.eks_network
}

output "eks_subnet_public_1a" {
  value = module.eks_network.subnet-public-1a
}

output "eks_subnet_public_1b" {
  value = module.eks_network.subnet-public-1b
}

output "eks_subnet_private_1a" {
  value = module.eks_network.subnet-private-1a
}

output "eks_subnet_private_1b" {
  value = module.eks_network.subnet-private-1b
}

output "eks_vpc_config" {
  value = module.eks_cluster.eks_vpc_config
}

output "oidc" {
  value = module.eks_cluster.oidc
}
