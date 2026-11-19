variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The IP address range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}