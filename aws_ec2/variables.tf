variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "application_name" {
  default = "backstage"
}

variable "instancetype" {
  description = "EC2 instance type"
  default     = "t2.medium" #"t2.micro"
}

variable "application_vpc_block" {
  default = "10.45.0.0/17"
}

variable "application_public_subnets_ip_lists" {
  default = ["10.45.0.0/20", "10.45.16.0/20", "10.45.32.0/20"]
}

variable "application_private_subnets_ip_lists" {
  default = ["10.45.64.0/20", "10.45.80.0/20", "10.45.96.0/20"]
}

variable "instance_count" {
  default = 1
}