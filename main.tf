# Create the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-main-vpc"
    Environment = var.environment
  }
}

# Create a Public Subnet inside the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = var.environment
  }
}
# Create an S3 Bucket to store Terraform state later
resource "aws_s3_bucket" "terraform_state" {
  # S3 bucket names must be globally unique across all of AWS. 
  # If this fails, change "muneeb" or the numbers to something else.
  bucket = "${var.environment}-muneeb-tf-state-bucket-778899" 
  
  tags = {
    Name        = "${var.environment}-tf-state"
    Environment = var.environment
  }
}

# Enable versioning to keep a history of our state file
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Automatically find the latest Ubuntu 22.04 image in AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Official Ubuntu AWS Account

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Create the EC2 Server
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small" # This is free-tier friendly
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name        = "${var.environment}-web-server"
    Environment = var.environment
  }
}