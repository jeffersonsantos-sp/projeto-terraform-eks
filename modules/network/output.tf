output "eks_network" {
  value = aws_vpc.eks_vpc.id
}

output "subnet-public-1a" {
  value = aws_subnet.eks_subnet_public_1a.id
}

output "subnet-public-1b" {
  value = aws_subnet.eks_subnet_public_1b.id
}

output "subnet-private-1a" {
  value = aws_subnet.eks_subnet_private_1a.id
}

output "subnet-private-1b" {
  value = aws_subnet.eks_subnet_private_1b
}

