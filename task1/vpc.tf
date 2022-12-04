data "aws_availability_zones" "available_zones" {
  state = "available"
}

# VPC creation block

resource "aws_vpc" "assessment-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "assessment-vpc-sg"
  }
}

# Public subnet block Creation 2
resource "aws_subnet" "public" {
  count                   = var.num_count
  vpc_id                  = aws_vpc.assessment-vpc.id
  cidr_block              = cidrsubnet(aws_vpc.assessment-vpc.cidr_block, 8, 3 + count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Private subnet Block Creation
resource "aws_subnet" "private" {
  count             = var.num_count
  vpc_id            = aws_vpc.assessment-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.assessment-vpc.cidr_block, 8, 6 + count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = {
    Name = "private-subnet"
  }

}
