resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private_rtbl"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rtbl"
  }
}

resource "aws_route_table_association" "public_rt_associations" {
  count          = 3
  subnet_id      = aws_subnet.subnets["public${count.index + 1}"].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_associations" {
  count          = 3
  subnet_id      = aws_subnet.subnets["private${count.index + 1}"].id
  route_table_id = aws_route_table.private_route_table.id
}