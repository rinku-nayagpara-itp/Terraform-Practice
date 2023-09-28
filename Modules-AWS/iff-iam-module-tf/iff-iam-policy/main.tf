resource "aws_iam_policy" "policy" {
  name   = var.name
  policy = var.policy
  tags = var.tags
}
