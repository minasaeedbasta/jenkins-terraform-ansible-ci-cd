data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu22.id
  instance_type               = var.instances[0].type
  subnet_id                   = module.network.public1_subnet_id
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_and_3000.id]
  associate_public_ip_address = var.instances[0].is_public
  key_name                    = aws_key_pair.ssh_key.key_name

  provisioner "file" {
    content     = tls_private_key.tls_pk.private_key_pem
    destination = "/home/ubuntu/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = tls_private_key.tls_pk.private_key_openssh
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/.ssh/id_rsa"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = tls_private_key.tls_pk.private_key_openssh
    }
  }

  tags = {
    Name = "${var.instances[0].name}"
  }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}

resource "aws_instance" "application" {
  ami                    = data.aws_ami.ubuntu22.id
  instance_type          = var.instances[1].type
  subnet_id              = module.network.private1_subnet_id
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh_from_vpc.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "${var.instances[1].name}"
  }
}
