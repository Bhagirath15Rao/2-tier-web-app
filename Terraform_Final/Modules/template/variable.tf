variable "default_tags" {
  type = map(string)
}

variable "env" {
  type = string
}

variable "prefix" {
  type = string
}

variable "instance_type" {
  type = map(string)
}

variable "key_name_webservers" {
  type = string
}

variable "security_group_id" {
  type = list(string)
}

