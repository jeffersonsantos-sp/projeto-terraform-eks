output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster
}

output "oidc" {
  value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
}