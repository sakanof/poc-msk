resource "aws_iam_role" "eks_nodesrole" {
  name               = "EKSNodesRole-${var.aws_account}-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.eks_nodes_trust_policy.json
  description        = "IAM Role EKS Nodes Cluster."
}

resource "aws_iam_role_policy_attachment" "amazon_worker_node_policy_attachment" {
  role       = aws_iam_role.eks_nodesrole.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_attachment" {
  role       = aws_iam_role.eks_nodesrole.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only_policy_attachment" {
  role       = aws_iam_role.eks_nodesrole.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}