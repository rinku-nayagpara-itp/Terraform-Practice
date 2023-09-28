output "role_name" {
  value = aws_iam_role.ec2_instance_role.name
}

output "role_arn" {
  value = aws_iam_role.ec2_instance_role.arn
}
