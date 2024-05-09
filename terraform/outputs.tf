output "private_key_pem" {
  value     = tls_private_key.tls_pk.private_key_pem
  sensitive = true
}

output "bastion_elastic_public_dns" {
  value = aws_eip.bastion_eip.public_dns
}

output "application_private_dns" {
  value = aws_instance.application.private_dns
}
