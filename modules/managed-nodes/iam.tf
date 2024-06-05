resource "aws_iam_role" "eks_role_nodes" {
  name = "${var.project_name}-eks_role_nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-role_nodes"
    }
  )
}

resource "aws_iam_role_policy_attachment" "eks_role_nodes_attachment_worker" {
  role       = aws_iam_role.eks_role_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"


}

resource "aws_iam_role_policy_attachment" "eks_role_nodes_attachment_registry" {
  role       = aws_iam_role.eks_role_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"


}

resource "aws_iam_role_policy_attachment" "eks_role_nodes_attachment_cni_policy" {
  role = aws_iam_role.eks_role_nodes.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}