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

output "rds_hostname" {
  value = aws_db_instance.default.endpoint
}

output "rds_port" {
  value = aws_db_instance.default.port
}

output "redis_hostname" {
  value = aws_elasticache_cluster.redis.cluster_address
}

output "redis_port" {
  value = aws_elasticache_cluster.redis.port
}

output "alb_dns" {
  value = aws_lb.app_alb.dns_name
}