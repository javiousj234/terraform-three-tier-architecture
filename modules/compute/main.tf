# ============================================================
# AMAZON LINUX AMI
# ============================================================

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# ============================================================
# LAUNCH TEMPLATE
# ============================================================

resource "aws_launch_template" "app" {
  name_prefix   = "terraform-app-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  lifecycle {
    create_before_destroy = true
  }
  vpc_security_group_ids = [var.app_security_group_id]

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }


  user_data = base64encode(
    templatefile("${path.module}/templates/user-data.sh.tftpl", {
      secret_arn = var.secret_arn
      aws_region = var.aws_region
    })
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform-asg-app"
    }
  }
}


# ============================================================
# AUTO SCALING GROUP
# ============================================================

resource "aws_autoscaling_group" "app" {
  name = "terraform-app-asg"

  min_size = var.asg_min_size
  max_size = var.asg_max_size

  desired_capacity = var.asg_desired_capacity

  health_check_type         = "ELB"
  health_check_grace_period = 300

  vpc_zone_identifier = var.private_subnet_ids

  lifecycle {
    ignore_changes = [
      desired_capacity
    ]
  }

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.app.id
    version = aws_launch_template.app.latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }
}


# ============================================================
# CPU TARGET TRACKING
# ============================================================

resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "terraform-app-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.cpu_target_value
  }
}