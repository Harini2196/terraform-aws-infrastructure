output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "IDs of the frontend (application-tier) private subnets"
  value       = aws_subnet.app[*].id
}

output "data_subnet_ids" {
  description = "IDs of the backend (data-tier) private subnets"
  value       = aws_subnet.data[*].id
}

output "alb_dns_name" {
  description = "Public DNS name of the application load balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Route53 hosted zone ID of the ALB, for alias records"
  value       = aws_lb.main.zone_id
}

output "frontend_asg_name" {
  description = "Name of the frontend autoscaling group"
  value       = aws_autoscaling_group.frontend.name
}

output "backend_instance_ids" {
  description = "IDs of the backend EC2 instances"
  value       = aws_instance.backend[*].id
}

output "backend_private_ips" {
  description = "Private IP addresses of the backend EC2 instances"
  value       = aws_instance.backend[*].private_ip
}

output "log_bucket_name" {
  description = "Name of the S3 bucket used for ALB access logs and application logs"
  value       = aws_s3_bucket.alc_logs.bucket
}
