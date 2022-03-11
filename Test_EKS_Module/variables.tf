variable "tags" {
  description = "A map of tags to add to EKS Cluster resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = ""
}

variable "eks_cluster_create" {
  description = "Create EKS Cluster"
  type        = bool
  default     = false
}

variable "create_cluster_role" {
  description = "Create Cluster Role"
  type        = bool
  default     = false
}

variable "cluster_role_name" {
  description = "Cluster Role Name"
  type        = string
  default     = "EKS-Cluster-Role"
}

variable "clusterpolicy" {
  description = "An additional policy document ARN to attach IAM role"
  type        = string
  default     = null
}

variable "clusterpolicies" {
  description = "List of policy statements ARN to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
  default     = ""
}

variable "cluster_sg_name" {
  description = "Name of the EKS cluster Security Group"
  type        = string
  default     = ""
}

variable "service_ipv4_cidr" {
  type    = string
  default = ""
}

variable "vpc_name" {
  type    = list(string)
  default = []
}

variable "subnet_names" {
  type    = list(string)
  default = []
}

variable "eks_cluster_role" {
  type    = string
  default = ""
}

variable "iam_role_service_account" {
  type    = string
  default = ""
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster."
  type = list(object({
    provider_key_arn = string
    resources        = list(string)
  }))
  default = []
}


variable "endpoint_private_access" {
  type        = bool
  default     = false
  description = "Whether the Amazon EKS private API server endpoint is enabled"
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "Whether the Amazon EKS public API server endpoint is enabled"
}

variable "public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group IDs for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane"
}




variable "eks_nodegroup_create" {
  description = "Create EKS Node Group"
  type        = bool
  default     = false
}

variable "node_group_name" {
  description = "Name of the dev Node Group"
  type        = map(any)
  default = {
    "node" = "nodegroup"
  }
}


variable "ec2_ssh_key" {
  description = "ssh key pair for worker nodes"
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = number
  default     = 20
}

variable "instance_types" {
  type        = list(string)
  default     = ["t2.small", "t2.micro"]
  description = "Set of instance types associated with the EKS Node Group."
}

variable "launch_template_instance_type" {
  type        = string
  default     = "t3a.medium"
  description = "Set of instance types associated with launch template."
}

variable "ami_type" {
  type        = string
  description = "AMI type for the EKS Node Group instance."
  default     = "AL2_x86_64"
}

variable "desired_size" {
  description = "Desired number of worker nodes in dev group"
  default     = 3
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes in dev group."
  default     = 5
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes in dev group."
  default     = 2
  type        = number
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the EKS Node Group."
  default     = "ON_DEMAND"
}


variable "launch_template_name" {
  type        = string
  description = "Name of the EC2 Launch Template."
  default     = ""
}

variable "launch_template_version" {
  type        = string
  description = "EC2 Launch Template version number."
  default     = ""
}

variable "launch_template_id" {
  type        = string
  description = "Identifier of the EC2 Launch Template."
  default     = ""
}

variable "source_security_group_ids" {
  type        = list(string)
  default     = []
  description = "Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes."
}


variable "max_unavailable" {
  description = "Desired max number of unavailable worker nodes during node group update"
  type        = number
  default     = 2
}

variable "labels" {
  description = "Key-value map of Kubernetes labels."
  type        = map(string)
  default     = {}
}


variable "role_description" {
  description = "Description of IAM role to use for Service Account"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role to use for Service Account"
  type        = string
  default     = null
}

variable "role_force_detach_policies" {
  description = "Specifies to force detaching any policies the IAM role has before destroying it."
  type        = bool
  default     = false
}

variable "role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the IAM role used by Service Account"
  type        = string
  default     = null
}

variable "role_tags" {
  description = "A map of tags to assign to IAM role"
  type        = map(string)
  default     = {}
}

variable "attach_policy" {
  description = "Controls whether policy should be added to IAM role for Service Account"
  type        = bool
  default     = false
}

variable "attach_policies" {
  description = "Controls whether list of policies should be added to IAM role"
  type        = bool
  default     = false
}

variable "number_of_policies" {
  description = "Number of policies to attach to IAM role"
  type        = number
  default     = 0
}

variable "sapolicy" {
  description = "An additional policy document ARN to attach IAM role"
  type        = string
  default     = null
}

variable "sapolicies" {
  description = "List of policy statements ARN to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "eks_nodegroup_role" {
  description = "IAM Role for EKS Node Group."
  type        = string
  default     = ""
}

variable "create_eks_nodegroup_role" {
  description = "Create IAM Role for EKS Node Group."
  type        = bool
  default     = true
}

variable "eks_nodegroup_role_name" {
  description = "EKS Node Group Role Name"
  type        = string
  default     = "EKS-Node-Group"
}

variable "nodegroup_role_description" {
  description = "Description of IAM role to use for Node Group"
  type        = string
  default     = null
}

variable "nodegroup_role_path" {
  description = "Path of IAM role to use for Node Group"
  type        = string
  default     = null
}

variable "nodegroup_role_force_detach_policies" {
  description = "Specifies to force detaching any policies the IAM role has before destroying it."
  type        = bool
  default     = false
}

variable "nodegroup_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the IAM role used by Node Group"
  type        = string
  default     = null
}

variable "nodegroup_role_tags" {
  description = "A map of tags to assign to IAM role"
  type        = map(string)
  default     = {}
}

variable "nodepolicy" {
  description = "An additional policy document ARN to attach IAM role"
  type        = string
  default     = null
}

variable "nodepolicies" {
  description = "List of policy statements ARN to attach to IAM role"
  type        = list(string)
  default     = []
}



###### variables for vpc

variable "cidr_block" {
  default = "192.168.0.0/16"
  type    = string
}

variable "instance_tenancy" {
  default = "default"
  type    = string
}

variable "enable_dns_support" {
  default = true
  type    = bool
}

variable "enable_dns_hostnames" {
  default = true
  type    = bool
}

variable "enable_classiclink" {
  default = false
  type    = bool
}

variable "enable_classiclink_dns_support" {
  default = false
  type    = bool
}

variable "assign_generated_ipv6_cidr_block" {
  default = false
  type    = bool
}

variable "vpc_tags" {
  default = {}
  type    = map(any)
}

## variable for public subnet 1

variable "cidr_block_public_subnet_1" {
  default = "192.168.0.0/18"
  type    = string
}

variable "availability_zone_public_subnet_1" {
  default = "us-east-1a"
  type    = string
}

variable "map_public_ip_on_launch" {
  default = true
  type    = bool
}


variable "tags_for_public_subnet_1" {
  default = {
    Name                        = "public_subnet_1"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
  type = map(any)
}

## variable for public subnet 2

variable "cidr_block_public_subnet_2" {
  default = "192.168.64.0/18"
  type    = string
}

variable "availability_zone_public_subnet_2" {
  default = "us-east-1b"
  type    = string
}


variable "tags_for_public_subnet_2" {
  default = {
    Name                        = "public_subnet_2"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
  type = map(any)
}


## variable for private subnet 1

variable "cidr_block_private_subnet_1" {
  default = "192.168.128.0/18"
  type    = string
}

variable "availability_zone_private_subnet_1" {
  default = "us-east-1a"
  type    = string
}

variable "tags_for_private_subnet_1" {
  default = {
    Name                              = "private_subnet_1"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
  type = map(any)
}

variable "cidr_block_private_subnet_2" {
  default = "192.168.192.0/18"
  type    = string
}

variable "availability_zone_private_subnet_2" {
  default = "us-east-1b"
  type    = string
}

variable "tags_for_private_subnet_2" {
  default = {
    Name                              = "private_subnet_2"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
  type = map(any)
}

