resource "aws_amplify_branch" "master" {
  app_id      = aws_amplify_app.amplify-app.id
  branch_name = "master"
  framework = "Web"
  stage     = "PRODUCTION"
}