variable "region" {
  type        = string
  description = "aws region"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
}

variable "subnets" {
  type = list(object({
    name       = string
    is_public  = bool
    az_suffix  = string
    cidr_block = string
  }))
  description = "subnets list"
}


variable "instances" {
  type = list(object({
    name      = string
    type      = string
    is_public = bool
  }))
}

variable "rds" {
  type = object({
    db_name           = string
    engine            = string
    engine_version    = string
    class             = string
    storage_type      = string
    allocated_storage = number
    username          = string
    password          = string
  })
}
