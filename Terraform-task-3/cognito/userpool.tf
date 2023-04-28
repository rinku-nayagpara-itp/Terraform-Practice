resource "aws_cognito_user_pool" "user-pool" {
  name = var.userpool
  deletion_protection = "INACTIVE"
  mfa_configuration = "OFF"
  email_configuration {
    email_sending_account = var.email_sending_account
    from_email_address = var.from-email
    source_arn = aws_ses_email_identity.mail-identity.arn
  }
  depends_on = [
    aws_ses_email_identity.mail-identity
  ]
}

data "aws_iam_policy" "send-email-policy" {
  name = var.policy-name
}

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["cognito-idp.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "assumed-role-send-email" {
#   name = var.role-name
#   assume_role_policy =join("", data.aws_iam_policy_document.assume_role.*.json)
#   managed_policy_arns = [data.aws_iam_policy.send-email-policy.arn]
# }
