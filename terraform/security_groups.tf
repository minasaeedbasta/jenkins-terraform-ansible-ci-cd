resource "aws_security_group" "sg_allow_ssh" {
  vpc_id = module.network.vpc_id
  name   = "sg_allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_allow_ssh"
  }
}

resource "aws_security_group" "sg_allow_ssh_and_3000" {
  vpc_id = module.network.vpc_id
  name   = "sg_allow_ssh_and_3000"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr_block]
  }

    ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [ aws_security_group.lb_sg.id ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_allow_ssh_and_3000"
  }
}



resource "aws_security_group" "sg_private_rds" {
  vpc_id = module.network.vpc_id
  name   = "sg_private_rds"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_cidr_block]
  }

  tags = {
    Name = "sg_private_rds"
  }
}


resource "aws_security_group" "lb_sg" {
  vpc_id = module.network.vpc_id
  name   = "lb_sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb_sg"
  }
}
