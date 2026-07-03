resource "aws_instance" "backend" {
  count                  = var.backend_instance_count
  ami                    = data.aws_ami.rhel.id
  instance_type          = var.backend_instance_type
  subnet_id              = aws_subnet.data[count.index % length(aws_subnet.data)].id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = var.key_name != "" ? var.key_name : null
  iam_instance_profile   = aws_iam_instance_profile.ec2_alc_logs.name

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx
    sed -i -E 's/(listen +)80( +default_server;)/\1${var.backend_port}\2/' /etc/nginx/nginx.conf
    sed -i -E 's/(listen +\[::\]:)80( +default_server;)/\1${var.backend_port}\2/' /etc/nginx/nginx.conf
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Welcome to the ${var.app_name} Backend Server</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-backend-${count.index + 1}" })
}
