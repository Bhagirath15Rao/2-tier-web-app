#variable 


variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "prefix" {
  default = "reflective_kangaroo"
  type    = string
}

variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "staging" = "t3.small"
  }
  type = map(string)
}

#Network 
#Project


variable "env" {
  default = "prod"
  type    = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}

variable "vpc" {
  default = {
    "prod"    = "10.250.0.0/16"
    "staging" = "10.200.0.0/16"
  }
  type = map(string)
}


variable "enable_dns_support" {
  default = true
  type    = bool

}

variable "enable_dns_hostnames" {
  default = true
  type    = bool

}

variable "public_cidr" {
  default = {
    "prod"    = ["10.250.1.0/24", "10.250.2.0/24", "10.250.3.0/24"]
    "staging" = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
  }
  type = map(list(string))
}

variable "private_cidr" {
  default = {
    "prod"    = ["10.250.4.0/24", "10.250.5.0/24", "10.250.6.0/24"]
    "staging" = ["10.200.4.0/24", "10.200.5.0/24", "10.200.6.0/24"]
  }
  type = map(list(string))
}



variable "create_nat_gateway" {
  default = "true"
  type    = bool
}

#SG

variable "vpc_id" {
  default = null
  type    = string

}

#ALB
variable "security_group_id" {
  type    = list(string)
  default = null

}


variable "public_subnet" {
  default = null
  type    = list(string)
}

variable "key_name_webservers" {
  default = null
  type    = string
}

variable "launch_configuration_name" {
  default = null
  type    = string
}



variable "max_size" {
  default = "4"
  type    = number
}

variable "min_size" {
  default = "3"
  type    = number
}

variable "target_group_arns" {
  default = null
  type    = string
}

variable "desired_capacity" {
  default = "3"
  type    = number
}




#database

variable "dynamodb_table_name" {
  default = "sudeep-finalproject"
  type    = string
}

variable "read_capacity" {
  default = "20"
  type    = string
}

variable "write_capacity" {
  default = "20"
  type    = string
}


variable "bucket_name" {
  default = "sudeep-finalproject-acs730"
  type    = string
}

variable "path_terraform_state" {
  type    = string
  default = "main/terraform.tfstate"
}



variable "iam_policy" {
  default = null
  type    = string
}


variable "ssh_webservers" {
  type    = list(string)
  default = null
}
