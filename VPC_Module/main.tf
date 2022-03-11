resource "aws_vpc" "eks_vpc" {

  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block


  tags = var.vpc_tags
}


resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.cidr_block_public_subnet_1

  availability_zone       = var.availability_zone_public_subnet_1
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = var.tags_for_public_subnet_1
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.cidr_block_public_subnet_2

  availability_zone       = var.availability_zone_public_subnet_2
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = var.tags_for_public_subnet_2
}




resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.cidr_block_private_subnet_1

  availability_zone       = var.availability_zone_private_subnet_1
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = var.tags_for_private_subnet_1
}


resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = var.cidr_block_private_subnet_2

  availability_zone       = var.availability_zone_private_subnet_2
  map_public_ip_on_launch = var.map_public_ip_on_launch


  tags = var.tags_for_private_subnet_2
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public"
  }
}



resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw1.id
  }


  tags = {
    Name = "private1"
  }
}


resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw2.id
  }


  tags = {
    Name = "private2"
  }
}

# route table association

resource "aws_route_table_association" "public_1" {
  subnet_id = aws_subnet.public_subnet_1.id

  route_table_id = aws_route_table.public.id

}



resource "aws_route_table_association" "public_2" {
  subnet_id = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.public.id

}


resource "aws_route_table_association" "private_1" {
  subnet_id = aws_subnet.private_subnet_1.id

  route_table_id = aws_route_table.private_1.id

}


resource "aws_route_table_association" "private_2" {
  subnet_id = aws_subnet.private_subnet_2.id

  route_table_id = aws_route_table.private_2.id

}


resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "ngw1"
  }
}


resource "aws_nat_gateway" "ngw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "ngw2"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "nat1" {

  depends_on = [aws_internet_gateway.igw]

}


resource "aws_eip" "nat2" {

  depends_on = [aws_internet_gateway.igw]

}
