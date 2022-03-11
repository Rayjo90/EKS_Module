###### variables for vpc

variable "cidr_block" {
  default = null
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
  default = null
  type    = string
}

variable "availability_zone_public_subnet_1" {
  default = null
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
  default = null
  type    = string
}

variable "availability_zone_public_subnet_2" {
  default = null
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
  default = null
  type    = string
}

variable "availability_zone_private_subnet_1" {
  default = null
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
  default = null
  type    = string
}

variable "availability_zone_private_subnet_2" {
  default = null
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
 
