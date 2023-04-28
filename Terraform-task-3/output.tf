output "user_name" {
  value = aws_iam_service_specific_credential.iam-git-credential.service_user_name
}
output "password" {
  sensitive = true
  value     = aws_iam_service_specific_credential.iam-git-credential.service_password
}
output "clone-url" {
  value = module.codecommit.clone_url_http
}
output "userpool-id" {
  value = module.cognito.userpool-id
}
output "app-client-id" {
  value = module.cognito.app-client-id
}
output "dynamodb-table-arn" {
  value = module.dynamodb_table.dynamodb_table_arn
}
# output "lambda-invoke-url" {
#   value = aws_api_gateway_deployment.deployment.invoke_url
# }
