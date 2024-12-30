#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
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


variable "launch_configuration_name" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "target_group_arns" {
  type = list(string)
}

variable "desired_capacity" {
  type = number
}