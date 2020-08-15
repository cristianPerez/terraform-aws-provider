provider "aws" {
  region="us-east-1"
}

resource "aws_security_group" "ssh_conection" {
  name        = var.sg_name

  # Ingress rule perse
  #ingress {
  #  from_port   = 443
  #  to_port     = 443
  #  protocol    = "tcp"
  #  Rango de direcciones ip de una subred en especifico
  #  cidr_blocks = [aws_vpc.main.cidr_block]
  #}

  # New version with foreach
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_conection and 80 port open"
  }
}

resource "aws_instance" "terraform-instance" {
  #ami = "ami-0bd8ec90b6f79d430"
  ami = var.ami_id
  instance_type = var.instance_type
  #tags = {
  #  Name = "practica1"
  #  Enviroment = "Dev"
  #}
  tags = var.tags
  security_groups = ["${aws_security_group.ssh_conection.name}"]
}