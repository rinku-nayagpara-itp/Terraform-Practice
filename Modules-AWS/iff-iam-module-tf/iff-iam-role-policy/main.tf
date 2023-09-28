resource "aws_iam_role_policy" "name" {
  name = var.name
  role = var.role
  policy = var.policy
}