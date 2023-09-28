resource "aws_iam_role" "ec2_instance_role" {
  name                = var.role_name
  path                = var.path
  assume_role_policy  = var.assume_role_policy
  managed_policy_arns = var.managed_policy_arns
  tags                = var.tags
}
