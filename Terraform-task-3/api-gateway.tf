resource "aws_api_gateway_rest_api" "rest-api-gateway" {
  name = var.api-gateway-name
  endpoint_configuration {
    types = ["EDGE"]
  }

}

resource "aws_api_gateway_resource" "ride" {
  parent_id   = aws_api_gateway_rest_api.rest-api-gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest-api-gateway.id
  path_part   = "ride"
}

resource "aws_api_gateway_authorizer" "authorizer" {
  name          = var.api-gateway-authorizer
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = aws_api_gateway_rest_api.rest-api-gateway.id
  provider_arns = [module.cognito.userpool-arn]
}

resource "aws_api_gateway_method" "put-method" {
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.ride.id
  rest_api_id   = aws_api_gateway_rest_api.rest-api-gateway.id
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.authorizer.id
}

resource "aws_api_gateway_method_response" "gateway-method-response" {
  rest_api_id = aws_api_gateway_rest_api.rest-api-gateway.id
  resource_id = aws_api_gateway_resource.ride.id
  http_method = aws_api_gateway_method.put-method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}


resource "aws_api_gateway_integration" "integration" {
  http_method             = aws_api_gateway_method.put-method.http_method
  resource_id             = aws_api_gateway_resource.ride.id
  rest_api_id             = aws_api_gateway_rest_api.rest-api-gateway.id
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
  integration_http_method = "POST"
}

resource "aws_api_gateway_integration_response" "api-integration-response" {
  rest_api_id = aws_api_gateway_rest_api.rest-api-gateway.id
  resource_id = aws_api_gateway_resource.ride.id
  http_method = aws_api_gateway_method.put-method.http_method
  status_code = aws_api_gateway_method_response.gateway-method-response.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'*'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = aws_api_gateway_rest_api.rest-api-gateway.arn
}



resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest-api-gateway.id
}

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest-api-gateway.id
  stage_name    = "prod"
}
