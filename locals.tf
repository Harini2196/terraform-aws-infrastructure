locals {
  name_prefix = "${var.app_name}-${var.environment}"

  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    length(var.public_subnet_cidrs)
  )

  common_tags = merge(
    {
      Application = var.app_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}
