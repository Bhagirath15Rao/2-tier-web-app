# Default tags
variable "default_tags" {
  default = {}
  type    = map(any)

}


# Name prefix
variable "prefix" {
  type = string
}


variable "env" {
  type = string
}


variable "region" {
  type = string
}

variable "vpc" {
  type = map(string)
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "public_cidr" {
  type = map(list(string))
}

variable "private_cidr" {
  type = map(list(string))
}

variable "create_nat_gateway" {
  type = bool
}


/*
variable "create_s3_endpoint" {
  type        = bool
}

variable "create_cloudwatch_logs_endpoint" {
  type        = bool
}
*/