provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "legendary-org"

    workspaces {
      name = "backstage-ec2"
    }
  }
}