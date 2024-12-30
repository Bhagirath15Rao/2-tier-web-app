variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "prefix" {
  default = "reflective_kangaroo"
  type    = string
}

variable "env" {
  default = "staging"
  type    = string
}

variable "dynamodb_table_name" {
  default = "reflective_kangaroo_db"
  type    = string
}