
data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.application_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGFvK1ddxZvCM3JwpV95ya9ByQzO7iuPZBsWe/uACjWQVcpB42e+NWgtHNawRJF9pfjVu/A5I7rVgU+1rGRprfbJw/YEG1aZO2ty/bo+DunsVC/aG80Unnf6m1xEBttMphey+aTZPYG2hJvPNbAcVPtSM7VK+Lm/hAL+LF3GwyGmtTgt4xcdXoZYe+xd3V8xy4HOorODIpzX/RTAlkQVjktqqRT3cBfw4bNypLkIooeGIwVFRVKd7MihkwXTFwKs5bxCJbeqSUWPOd+YH3LgM6SPZBjGOltjHGcvxR3VSAHp+PdZkmGbS8QqK18ThTu2PLAhGzRhBE92dr4cRvDnrqIRn6cytPgMx1afhRfu2gRHMrX083eDMc2jIwdUbOrQjQTHz7dju/7VAlwRSL6KL/krqz/uU68j/9cTfohk3H92rt3gT+TERozltwHTvO8u0JPIcluMFUNEI2gIx7S3VL7g2/dpXVwZYXnjH0dUWciIZWtMtjMHqvsG+qfEckxPKYmwd4E9LfbJXkkB0MxdsBDMezBZrLdLXSMRV/nHLWi7wzS53tYkPnSbEH/ftsc4iWjOFlNDOUVMAFID+AuV4KmZ/oaGriy83pEzr4bDnHTrgl9yC99KohX0pTZtQJ2zAcVZizqGFvOb6DVm+5e+92qve2TJ2kfhkyBzr13fmsvw== wale141@yahoo.com"
}

resource "aws_instance" "backstage_vm" {
  ami           = data.aws_ami.latest-ubuntu.id
  instance_type = var.instancetype
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.vpnsecuritygroup.id]
  subnet_id                   = module.vpc.application_public_subnets[0]
  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
  }

  tags = {
    Name = var.application_name
  }
}

// Instance Pupblic IPv4
output "ssh_login" {
  value = "ssh ubuntu@${aws_instance.backstage_vm.public_ip}"
}