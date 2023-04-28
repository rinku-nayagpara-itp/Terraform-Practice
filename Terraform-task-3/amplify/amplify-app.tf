resource "aws_amplify_app" "amplify-app" {
  name = var.app-name
  repository = var.codecommit-arn
  iam_service_role_arn = aws_iam_role.codecommit-read-role.arn
  enable_branch_auto_build = true
}
