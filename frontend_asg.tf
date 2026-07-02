resource "aws_launch_template" "frontend" {
  name_prefix   = "${local.name_prefix}-frontend-"
  image_id      = data.aws_ami.rhel.id
  instance_type = var.frontend_instance_type
  key_name      = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = [aws_security_group.frontend.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_alc_logs.name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Welcome to the ${var.app_name} Frontend Server</h1>" > /usr/share/nginx/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = "${local.name_prefix}-frontend" })
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name                      = "${local.name_prefix}-frontend-asg"
  vpc_zone_identifier       = aws_subnet.app[*].id
  min_size                  = var.frontend_min_size
  max_size                  = var.frontend_max_size
  desired_capacity          = var.frontend_desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.frontend.arn]

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = merge(local.common_tags, { Name = "${local.name_prefix}-frontend" })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_policy" "frontend_cpu_tracking" {
  name                   = "${local.name_prefix}-frontend-cpu-tracking"
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}
