resource "aws_cognito_user_pool_client" "app-client" {
    name = var.app-client-name
    user_pool_id = aws_cognito_user_pool.user-pool.id
    explicit_auth_flows = [ "ALLOW_USER_SRP_AUTH","ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH" ]
}