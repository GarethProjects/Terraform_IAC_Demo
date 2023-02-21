# Outputs
output "myoutput" {
  value = aws_vpc.vpc-dev.id
}

output "my_vpc_name_output" {
  value = aws_vpc.vpc-dev.tags
}

variable "mytuple" {
  type = tuple(["string", number, "string"])
  default = ["hello" , 1  , "world"]
}

variable "myobject" {
  type = object({name = string, port = list(number)})
  default = {
    name = "gl"
    port = [ 22, 25, 80 ]
  }
}
