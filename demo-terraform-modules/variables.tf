variable "ami_id" {
  default=""
  description="Ami id"
}

variable "instance_type" {
  default=""
  description="Instance type in variables"
}

variable "tags" {
  default=""
  description="Map with tags for the instance"
}

variable "sg_name" {
  default=""
  description="Security group name"
}

variable "ingress_rules" {
  default=""
  description="Ingress rules for security group name"
}