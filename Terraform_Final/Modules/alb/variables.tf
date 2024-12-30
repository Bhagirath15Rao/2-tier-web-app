# Default tags
variable "default_tags" {
  default     = {}
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  description = "Name prefix"
}

# Variable to signal the current environment 
variable "env" {
  type        = string
  description = "Deployment Environment"
}


variable "region" {
  type = string
}


variable "security_group_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

