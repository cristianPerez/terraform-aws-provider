output "instance_ip" {
  value = aws_instance.terraform-instance.*.public_ip
}