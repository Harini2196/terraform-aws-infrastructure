
# assume_role_arn = "arn:aws:iam::211125304367:role/gh-actions-admin-role"
app_name    = "automationlabcloud"
environment = "staging"
aws_region  = "us-east-1"

vpc_cidr            = "10.1.0.0/16"
public_subnet_cidrs = ["10.1.0.0/24", "10.1.1.0/24"]
app_subnet_cidrs    = ["10.1.10.0/24", "10.1.11.0/24"]
data_subnet_cidrs   = ["10.1.20.0/24", "10.1.21.0/24"]
single_nat_gateway  = true

key_name          = ""
ssh_ingress_cidrs = []
alb_ingress_cidrs = ["0.0.0.0/0"]

frontend_instance_type    = "t3.small"
backend_instance_type     = "t3.small"
frontend_min_size         = 2
frontend_max_size         = 4
frontend_desired_capacity = 2
backend_instance_count    = 2
backend_port              = 8080

log_expiration_days = 60

tags = {
  CostCenter = "staging"
}
