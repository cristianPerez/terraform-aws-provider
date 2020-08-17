variable "region" {
  default     = ""
  description = "Region in all vpc"
}

variable "vpc_cidr" {
  default     = ""
  description = "Vpc cidr"
}

variable "public_cidr_rt" {
  default     = ""
  description = "Public cidr, for public access in route table"
}

variable "public_cidrs_subnets" {
  default     = ""
  description = "Public cidr, for public access in route table"
}

variable "private_cidrs_subnets" {
  default     = ""
  description = "Private cidr, for public access in route table"
}

variable "ingress_rules" {
  default=""
  description="Ingress rules for security group name"
}

variable "egress_rules" {
  default=""
  description="Egress rules for security group name"
}