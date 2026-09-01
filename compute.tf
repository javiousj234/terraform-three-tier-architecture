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

  vpc_security_group_ids = [aws_security_group.app.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.app.name
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
set -e

dnf update -y
dnf install -y nginx python3 python3-pip

pip3 install flask boto3 psycopg2-binary

mkdir -p /opt/app

cat > /opt/app/app.py <<'PYEOF'
import json
import os

import boto3
import psycopg2
from flask import Flask

app = Flask(__name__)

SECRET_ARN = os.environ["SECRET_ARN"]
AWS_REGION = os.environ.get("AWS_REGION", "us-east-1")


def get_db_secret():
    client = boto3.client(
        "secretsmanager",
        region_name=AWS_REGION
    )

    response = client.get_secret_value(
        SecretId=SECRET_ARN
    )

    return json.loads(response["SecretString"])


@app.route("/")
def index():
    secret = get_db_secret()

    connection = psycopg2.connect(
        host=secret["host"],
        port=secret["port"],
        dbname=secret["dbname"],
        user=secret["username"],
        password=secret["password"]
    )

    cursor = connection.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(255)
        );
    """)

    cursor.execute("""
        INSERT INTO users (name, email)
        SELECT 'Test User', 'test@example.com'
        WHERE NOT EXISTS (
            SELECT 1 FROM users
            WHERE email = 'test@example.com'
        );
    """)

    connection.commit()

    cursor.execute(
        "SELECT id, name, email FROM users ORDER BY id;"
    )

    rows = cursor.fetchall()

    cursor.close()
    connection.close()

    html = """
    <html>
      <head>
        <title>Terraform AWS App</title>
      </head>
      <body>
        <h1>Terraform Three-Tier Application</h1>
        <h2>Users from PostgreSQL</h2>
        <ul>
    """

    for row in rows:
        html += f"<li>{row[0]} - {row[1]} - {row[2]}</li>"

    html += """
        </ul>
      </body>
    </html>
    """

    return html


@app.route("/health")
def health():
    return "OK", 200


if __name__ == "__main__":
    app.run(
        host="127.0.0.1",
        port=8080
    )
PYEOF

cat > /etc/app.env <<EOF2
SECRET_ARN=${aws_secretsmanager_secret.db.arn}
AWS_REGION=us-east-1
EOF2

chmod 600 /etc/app.env

cat > /etc/systemd/system/flask-app.service <<'SERVICEEOF'
[Unit]
Description=Terraform Flask Application
After=network.target

[Service]
User=root
WorkingDirectory=/opt/app
EnvironmentFile=/etc/app.env
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always

[Install]
WantedBy=multi-user.target
SERVICEEOF

cat > /etc/nginx/conf.d/app.conf <<'NGINXEOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINXEOF

rm -f /etc/nginx/conf.d/default.conf

systemctl daemon-reload

systemctl enable flask-app
systemctl start flask-app

systemctl enable nginx
systemctl restart nginx
EOF
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

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  vpc_zone_identifier = module.network.private_subnet_ids

  target_group_arns = [
    aws_lb_target_group.app.arn
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