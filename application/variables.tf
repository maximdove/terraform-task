variable "service_name" {
  type        = string
  description = "The name of the service, used as a prefix for resources."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources will be deployed."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the load balancer."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the Auto Scaling group."
}

variable "allowed_cidr_for_http" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR block to allow HTTP traffic."
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type for the Auto Scaling group."
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instances."
}

