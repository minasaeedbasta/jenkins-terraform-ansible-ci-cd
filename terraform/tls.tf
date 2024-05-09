resource "tls_private_key" "tls_pk" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "mina_ssh_key"
  public_key = tls_private_key.tls_pk.public_key_openssh
}
