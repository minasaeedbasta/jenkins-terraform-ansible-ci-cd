resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet"
  subnet_ids = [module.network.private1_subnet_id, module.network.private2_subnet_id,module.network.private3_subnet_id]
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [  aws_security_group.redis_sg.id ]
}