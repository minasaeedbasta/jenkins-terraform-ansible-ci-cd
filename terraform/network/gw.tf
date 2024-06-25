resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main vpc gw"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnets["public1"].id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}