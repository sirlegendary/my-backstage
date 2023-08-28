module "vpc" {
  source  = "app.terraform.io/legendary-org/module-vpc/aws"
  version = "0.0.1"

  application_name                     = var.application_name
  application_vpc_block                = var.application_vpc_block
  application_public_subnets_ip_lists  = var.application_public_subnets_ip_lists
  application_private_subnets_ip_lists = var.application_private_subnets_ip_lists
}

resource "aws_security_group" "vpnsecuritygroup" {
  name        = "Backstage Security Group"
  description = "Allow http and https"
  vpc_id      = module.vpc.application_vpc

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}