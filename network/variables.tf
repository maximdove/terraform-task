variable "service_name" {
  type        = string
  description = "The name of the service, used as a prefix for resources."
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets."
}
