variable "assume_role_arn" {
  description = "ARN of the IAM role to assume for AWS provider"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "Application name used as a prefix for resource names and tags"
  type        = string
  default     = "automationlabcloud"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (ALB, NAT gateway)"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for private application-tier subnets (frontend ASG)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "data_subnet_cidrs" {
  description = "CIDR blocks for private data/back-end-tier subnets (backend EC2)"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway for all private subnets instead of one per AZ (lower cost, single point of failure)"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access. Leave empty to disable key-based SSH."
  type        = string
  default     = ""
}

variable "ssh_ingress_cidrs" {
  description = "CIDR blocks allowed to SSH into frontend instances. Leave empty to disable SSH ingress."
  type        = list(string)
  default     = []
}

variable "alb_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the application load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "frontend_instance_type" {
  description = "Instance type for frontend EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "backend_instance_type" {
  description = "Instance type for backend EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "frontend_min_size" {
  description = "Minimum number of frontend instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "frontend_max_size" {
  description = "Maximum number of frontend instances in the autoscaling group"
  type        = number
  default     = 4
}

variable "frontend_desired_capacity" {
  description = "Desired number of frontend instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "backend_instance_count" {
  description = "Number of backend EC2 instances to create"
  type        = number
  default     = 2
}

variable "backend_port" {
  description = "Port the backend service listens on"
  type        = number
  default     = 8080
}

variable "log_expiration_days" {
  description = "Number of days to retain logs in S3 before expiration"
  type        = number
  default     = 90
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
