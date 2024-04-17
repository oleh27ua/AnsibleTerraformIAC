# Define the AWS region
variable "aws_region" {
  description = "AWS region to create resources in"
  default     = "us-east-1"
}

# Define the VPC CIDR block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Define the public subnet CIDR block
variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define the private subnet CIDR block
variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Define the availability zones
variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Define the instance type for application servers
variable "app_instance_type" {
  description = "Instance type for the application servers"
  default     = "t2.micro"
}

# Define the instance type for the database server
variable "db_instance_type" {
  description = "Instance type for the database server"
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "AMI for EC2 instances"
  type        = string
  default     = "ami-0a699202e5027c10d" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
}