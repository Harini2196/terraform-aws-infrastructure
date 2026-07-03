# assume_role_arn = "arn:aws:iam::211125304367:role/gh-actions-admin-role" # Replace with your actual role ARN
app_name    = "automationlabcloud"
environment = "dev"
aws_region  = "us-east-1"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
app_subnet_cidrs    = ["10.0.10.0/24", "10.0.11.0/24"]
data_subnet_cidrs   = ["10.0.20.0/24", "10.0.21.0/24"]
single_nat_gateway  = true

key_name          = ""
ssh_ingress_cidrs = []
alb_ingress_cidrs = ["0.0.0.0/0"]

frontend_instance_type    = "t3.micro"
backend_instance_type     = "t3.micro"
frontend_min_size         = 1
frontend_max_size         = 2
frontend_desired_capacity = 1
backend_instance_count    = 1
backend_port              = 8080

log_expiration_days = 30

tags = {
  CostCenter = "dev"
}
