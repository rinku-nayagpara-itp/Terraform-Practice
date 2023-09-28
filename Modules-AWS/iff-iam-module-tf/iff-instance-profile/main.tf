resource "aws_iam_instance_profile" "instance_profile" {
  role = var.role
  name = var.name
  tags = var.tags
  path = var.path
}
