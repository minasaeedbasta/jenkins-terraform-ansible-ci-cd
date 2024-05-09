output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}

output "public1_subnet_id" {
  value = aws_subnet.subnets["public1"].id
}

output "private1_subnet_id" {
  value = aws_subnet.subnets["private1"].id
}

output "public1_subnet_cidr_block" {
  value = aws_subnet.subnets["public1"].cidr_block
}

output "private1_subnet_cidr_block" {
  value = aws_subnet.subnets["private1"].cidr_block
}

output "public2_subnet_id" {
  value = aws_subnet.subnets["public2"].id
}

output "private2_subnet_id" {
  value = aws_subnet.subnets["private2"].id
}

output "public2_subnet_cidr_block" {
  value = aws_subnet.subnets["public2"].cidr_block
}

output "private2_subnet_cidr_block" {
  value = aws_subnet.subnets["private2"].cidr_block
}

output "public3_subnet_id" {
  value = aws_subnet.subnets["public3"].id
}

output "private3_subnet_id" {
  value = aws_subnet.subnets["private3"].id
}

output "public3_subnet_cidr_block" {
  value = aws_subnet.subnets["public3"].cidr_block
}

output "private3_subnet_cidr_block" {
  value = aws_subnet.subnets["private3"].cidr_block
}