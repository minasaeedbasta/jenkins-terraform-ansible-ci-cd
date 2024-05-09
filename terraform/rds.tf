resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main"
  subnet_ids = [module.network.private1_subnet_id, module.network.private2_subnet_id, module.network.private3_subnet_id]
  #   subnet_ids = [module.network.subnets[1].id,module.network.subnets[3].id,module.network.subnets[5].id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = var.rds["allocated_storage"]
  db_name                = var.rds["db_name"]
  engine                 = var.rds["engine"]
  engine_version         = var.rds["engine_version"]
  instance_class         = var.rds["class"]
  username               = var.rds["username"]
  password               = var.rds["password"]
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name    
  vpc_security_group_ids = [aws_security_group.sg_private_rds.id]
  skip_final_snapshot    = true
}
