
assume_role_arn = "arn:aws:iam::211125304367:role/gh-actions-admin-role"
app_name        = "automationlabcloud"
environment     = "prod"
aws_region      = "us-east-1"

vpc_cidr            = "10.2.0.0/16"
public_subnet_cidrs = ["10.2.0.0/24", "10.2.1.0/24"]
app_subnet_cidrs    = ["10.2.10.0/24", "10.2.11.0/24"]
data_subnet_cidrs   = ["10.2.20.0/24", "10.2.21.0/24"]
single_nat_gateway  = false

key_name          = ""
ssh_ingress_cidrs = []
alb_ingress_cidrs = ["0.0.0.0/0"]

frontend_instance_type    = "t3.medium"
backend_instance_type     = "t3.medium"
frontend_min_size         = 2
frontend_max_size         = 6
frontend_desired_capacity = 3
backend_instance_count    = 4
backend_port              = 8080

log_expiration_days = 180

tags = {
  CostCenter = "prod"
}
