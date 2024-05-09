resource "aws_subnet" "subnets" {
  for_each          = { for subnet in var.subnets : subnet.name => subnet }
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.region}${each.value.az_suffix}"

  tags = {
    Name = "${each.value.name}_subnet"
  }
}
