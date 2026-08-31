# ============================================================
# EC2 ASSUME ROLE POLICY
# ============================================================

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


# ============================================================
# EC2 IAM ROLE
# ============================================================

resource "aws_iam_role" "app" {
  name               = "terraform-app-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}


# ============================================================
# SECRETS MANAGER ACCESS POLICY
# ============================================================

data "aws_iam_policy_document" "app_secret_access" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]

    resources = [
      aws_secretsmanager_secret.db.arn
    ]
  }
}

resource "aws_iam_role_policy" "app_secret_access" {
  name   = "terraform-app-secret-access"
  role   = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.app_secret_access.json
}


# ============================================================
# EC2 INSTANCE PROFILE
# ============================================================

resource "aws_iam_instance_profile" "app" {
  name = "terraform-app-instance-profile"
  role = aws_iam_role.app.name
}