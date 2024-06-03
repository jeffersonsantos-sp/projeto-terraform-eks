/* Internet Gateway */
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-igw"
    }

  )
}

/* Route Table - Public */

resource "aws_route_table" "eks_rt_public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-public-route-table"
    }
  )
}

/* Route Table - Private */