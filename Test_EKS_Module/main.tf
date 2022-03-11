data "aws_availability_zones" "available" {
  state = "available"
}

module "EKS_VPC" {
  source = "../VPC_Module"

  cidr_block                        = var.cidr_block
  cidr_block_public_subnet_1        = var.cidr_block_public_subnet_1
  availability_zone_public_subnet_1 = data.aws_availability_zones.available.names[0]

  cidr_block_public_subnet_2        = var.cidr_block_public_subnet_2
  availability_zone_public_subnet_2 = data.aws_availability_zones.available.names[1]

  cidr_block_private_subnet_1        = var.cidr_block_private_subnet_1
  availability_zone_private_subnet_1 = data.aws_availability_zones.available.names[0]

  cidr_block_private_subnet_2        = var.cidr_block_private_subnet_2
  availability_zone_private_subnet_2 = data.aws_availability_zones.available.names[1]
}


module "EKS_MODULE" {
  depends_on = [
    module.EKS_VPC
  ]
  source = "../EKS_IAM_Module"

  eks_cluster_create  = true
  cluster_name        = "eks"
  create_cluster_role = true
  subnet_ids = [
    module.EKS_VPC.public_subnet_1,
    module.EKS_VPC.public_subnet_2,
    module.EKS_VPC.private_subnet_1,
    module.EKS_VPC.private_subnet_2
  ]
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs
  node_group_name         = var.node_group_name

  instance_types            = var.instance_types
  ami_type                  = var.ami_type
  create_eks_nodegroup_role = var.create_eks_nodegroup_role
  disk_size                 = var.disk_size
  desired_size              = var.desired_size
  max_size                  = var.max_size
  min_size                  = var.min_size
  max_unavailable           = var.max_unavailable

}
