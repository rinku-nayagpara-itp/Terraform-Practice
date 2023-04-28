variable "userpool" {
  default = "rinku-nayagpara-userpool"
}

variable "email_sending_account" {
  default = "DEVELOPER"
}
variable "from-email" {
  default = "rinkupatel9505@gmail.com"
}

variable "role-name" {
  default = "send-mail-role1"
}
variable "policy-name" {
  default = "AmazonCognitoIdpEmailServiceRolePolicy"
}

output "userpool-id" {
  value = aws_cognito_user_pool.user-pool.id
}

#app-client

variable "app-client-name" {
  default = "WebAppClient"
}
output "app-client-id" {
  value = aws_cognito_user_pool_client.app-client.id
}

output "userpool-arn" {
  value = aws_cognito_user_pool.user-pool.arn
}