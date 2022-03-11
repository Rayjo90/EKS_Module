# Create IAM Role for Cluster
resource "aws_iam_role" "clusterrole" {
  count = var.create_cluster_role ? 1 : 0

  name                  = var.cluster_role_name
  description           = var.role_description
  path                  = var.role_path
  force_detach_policies = var.role_force_detach_policies
  permissions_boundary  = var.role_permissions_boundary
  tags                  = var.tags
  assume_role_policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#Attach EKS Cluster Policy to EKS Cluster IAM Role
resource "aws_iam_role_policy_attachment" "aws-eks-cluster-policy" {
  count = var.create_cluster_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.clusterrole[0].name

}

#Attach EKS Service Role Policy to EKS Cluster IAM Role
resource "aws_iam_role_policy_attachment" "aws-eks-service-policy" {
  count = var.create_cluster_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.clusterrole[0].name
}

# Attach additional One Policy to EKS Cluster IAM Role
resource "aws_iam_role_policy_attachment" "additional_one_ekscluster" {
  count = var.create_cluster_role && var.attach_policy ? 1 : 0

  role       = aws_iam_role.clusterrole[0].name
  policy_arn = var.clusterpolicy
}

# Attach additional more than one Policy to EKS Cluster IAM Role
resource "aws_iam_role_policy_attachment" "additional_many_ekcluster" {
  count = var.create_cluster_role && var.attach_policies ? var.number_of_policies : 0

  role       = aws_iam_role.clusterrole[0].name
  policy_arn = var.clusterpolicies[count.index]
}

# Create IAM Role for EKS Node Group
resource "aws_iam_role" "eksnodegrouprole" {
  count = var.create_eks_nodegroup_role ? 1 : 0

  name                  = var.eks_nodegroup_role_name
  description           = var.nodegroup_role_description
  path                  = var.nodegroup_role_path
  force_detach_policies = var.nodegroup_role_force_detach_policies
  permissions_boundary  = var.nodegroup_role_permissions_boundary
  tags                  = var.tags

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Attach EKS Worker Node Policy to Node Group
resource "aws_iam_role_policy_attachment" "nodegroup-AmazonEKSWorkerNodePolicy" {
  count = var.create_eks_nodegroup_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eksnodegrouprole[0].name
}

# Attach EKS CNI Policy to Node Group
resource "aws_iam_role_policy_attachment" "nodegroup-AmazonEKS_CNI_Policy" {
  count = var.create_eks_nodegroup_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eksnodegrouprole[0].name
}

# Attach Container Registry Read only permission to Node Group
resource "aws_iam_role_policy_attachment" "nodegroup-AmazonEC2ContainerRegistryReadOnly" {
  count = var.create_eks_nodegroup_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eksnodegrouprole[0].name
}

# Attach additional policy to Node Group
resource "aws_iam_role_policy_attachment" "additional_one_nodegroup" {
  count = var.create_eks_nodegroup_role && var.attach_policy ? 1 : 0

  role       = aws_iam_role.eksnodegrouprole[0].name
  policy_arn = var.nodepolicy
}

# Attach more than one policy to Node Group
resource "aws_iam_role_policy_attachment" "additional_many_nodegroup" {
  count = var.create_eks_nodegroup_role && var.attach_policies ? var.number_of_policies : 0

  role       = aws_iam_role.eksnodegrouprole[0].name
  policy_arn = var.nodepolicies[count.index]
}
