region = "us-east-1"

vpc_cidr_block = "10.0.0.0/16"

subnets = [
  {
    "name" : "public1",
    "is_public" : true,
    "az_suffix" : "a",
    "cidr_block" : "10.0.1.0/24"
  },
  {
    "name" : "private1",
    "is_public" : false,
    "az_suffix" : "a",
    "cidr_block" : "10.0.2.0/24"
  },
  {
    "name" : "public2",
    "is_public" : true,
    "az_suffix" : "b",
    "cidr_block" : "10.0.3.0/24"
  },
  {
    "name" : "private2",
    "is_public" : false,
    "az_suffix" : "b",
    "cidr_block" : "10.0.4.0/24"
  },
  {
    "name" : "public3",
    "is_public" : true,
    "az_suffix" : "c",
    "cidr_block" : "10.0.5.0/24"
  },
  {
    "name" : "private3",
    "is_public" : false,
    "az_suffix" : "c",
    "cidr_block" : "10.0.6.0/24"
  }
]

instances = [{
  name      = "bastion",
  type      = "t2.micro",
  is_public = true
  },
  {
    name      = "application",
    type      = "t2.micro",
    is_public = false
}]

rds = {
  db_name           = "myrds"
  engine            = "mysql"
  engine_version    = "5.7"
  class             = "db.t3.micro"
  storage_type      = "gp2"
  allocated_storage = 20
}
