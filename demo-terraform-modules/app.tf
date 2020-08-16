provider "aws" {
  region="us-east-1"
}

module "app-tegger" {
  # Here you can send the remote modules with github.
  source = "./modules/instance"
  ami_id = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
  sg_name  = var.sg_name
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules
}
