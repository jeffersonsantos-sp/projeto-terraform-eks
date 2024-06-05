resource "aws_eks_node_group" "eks_hml_node_group" {
  cluster_name    = "${var.project_name}-eks_cluster"
  node_group_name = var.project_name
  node_role_arn   = aws_iam_role.eks_role_nodes.arn
  instance_types  = ["t3.medium"]

  subnet_ids = [
    var.subnet-private-1a,
    var.subnet-private-1b
  ]



  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }


  depends_on = [
    aws_iam_role_policy_attachment.eks_role_nodes_attachment_cni_policy,
    aws_iam_role_policy_attachment.eks_role_nodes_attachment_registry,
    aws_iam_role_policy_attachment.eks_role_nodes_attachment_worker,
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-node-group"
    }
  )
}