# Outputs
output "myoutput" {
  value = aws_vpc.vpc-dev.id
}

output "my_vpc_name_output" {
  value = aws_vpc.vpc-dev.tags
}
