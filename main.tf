terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # Configure your AWS provider as necessary
}

module "network" {
  source = "./network"
  service_name        = var.service_name
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.0.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
}

module "application" {
  source              = "./application"
  service_name        = var.service_name
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
  allowed_cidr_for_http = "0.0.0.0/0"
  instance_type       = "t2.micro"
  ami_id              = "ami-0dbc3d7bc646e8516"
}
