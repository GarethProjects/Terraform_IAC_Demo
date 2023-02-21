#Input Variables
variable "aws_region" {
  description = "Region in which AWS resource to be created"
  type = string
  default = "us-east-1"
}

variable "cidr_addr_range" {
    type = string  
}

variable "input_vpc_name" {
  type = string
  description = "Set the name of the VPC"
}
