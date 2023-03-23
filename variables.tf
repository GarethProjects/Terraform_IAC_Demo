#Input Variables
variable "aws_region" {
  description = "Region in which AWS resource to be created"
  type = string
  default = "us-east-1"
}

variable "cidr_addr_range" {
    type = string
    default = "172.16.0.0/16"
}

variable "input_vpc_name" {
  type = string
  default = "myDemoVPC"
  description = "Set the name of the VPC"
}

variable "state_file" {
  description = "Path to the statefile"
}
