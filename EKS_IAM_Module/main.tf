# Create EKS Cluster
# This resource will deploy EKS(Elastic Kubernetes Service) Cluster. 
# Here we deploying EKS in the specified VPC and Subnets and is enabling cluster logging
resource "aws_eks_cluster" "cluster" {
  count = var.eks_cluster_create ? 1 : 0

  name     = var.cluster_name
  role_arn = var.create_cluster_role ? aws_iam_role.clusterrole[0].arn : var.eks_cluster_role
  version  = var.cluster_version

  #For Encryption Enable
  dynamic "encryption_config" {
    for_each = toset(var.cluster_encryption_config)

    content {
      provider {
        key_arn = encryption_config.value["provider_key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  tags = var.tags
}

# Create EKS Node Group
# Node group is an autoscaling group and associated EC2 instances that are managed by AWS 
# for an Amazon EKS cluster
resource "aws_eks_node_group" "node_group" {
  depends_on = [
    aws_eks_cluster.cluster
  ]

  for_each        = var.node_group_name
  cluster_name    = var.cluster_name
  node_group_name = each.key
  node_role_arn   = var.create_eks_nodegroup_role ? aws_iam_role.eksnodegrouprole[0].arn : var.eks_nodegroup_role
  subnet_ids      = var.subnet_ids
  capacity_type   = var.capacity_type
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  disk_size       = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # launch_template {
  #   name    = var.launch_template_name
  #   version = var.launch_template_version
  #   id      = var.launch_template_id
  # }


  remote_access {
    ec2_ssh_key               = var.ec2_ssh_key
    source_security_group_ids = var.source_security_group_ids
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = var.tags

  labels = var.labels

}

