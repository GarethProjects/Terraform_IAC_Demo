#Input Variables
# variable "aws_region" {
#   description = "Region in which AWS resource to be created"
#   type = string
#   default = "us-east-1"
# }

variable "cidr_addr_range" {
    type = string  
}

variable "input_vpc_name" {
  type = string
  description = "Set the name of the VPC"
}

# variable "ec2_ami_id" {
#   description = "AMI ID"
#   type = string
#   default = "ami-......" # Amazon linux 2 AMI ID
# }

# variable "ec2_instance_count" {
#     type = number
#     default = 1
# }


# variable "vpcname" {
#   type = string
#   default = "myvpc"
# }

# variable "sshport" {
#   type = number
#   default = 22
# }

# # variable = "enabled" {
# #     default = true
# # }
# variable "mylist" {
#   type = list(string)
#   default = ["value1", "value2"]
# }
