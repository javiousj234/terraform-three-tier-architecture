output "instance_profile_name" {
  description = "IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.app.name
}