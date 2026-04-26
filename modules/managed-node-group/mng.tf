resource "aws_eks_node_group" "eks_mng" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-mng"
  node_role_arn   = aws_iam_role.eks_mng_role.arn
  subnet_ids      = [
    var.private_subnet_1a,
    var.private_subnet_1b
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_mng_role_attachment_worker_node,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_cni,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr_pull,
    aws_iam_role_policy_attachment.eks_mng_role_attachment_ecr_public_read_only
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-mng"
    }
  )
}

resource "aws_eks_access_entry" "eks_mng_access_entry" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.eks_mng_role.arn
  type          = "EC2_LINUX"
}