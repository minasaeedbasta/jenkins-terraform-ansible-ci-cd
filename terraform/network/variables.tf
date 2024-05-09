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
