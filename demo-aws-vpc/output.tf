output "aws_vpc_id" {
  value = aws_vpc.dev_main_vpc.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.dev_main_internet_gateway.id
}