# module "lambda_function_existing_package_local" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = var.lambda-name
#   create_function = true
#   description   = "My awesome lambda function"
#   architectures = ["x86_64"]
#   runtime       = "nodejs16.x"
#   attach_cloudwatch_logs_policy = false
# #   create_package = true
#   create_role     = false

# #   handler       = "index.handler"

# #   local_existing_package = "index.zip"

#   lambda_role = "arn:aws:iam::587172484624:role/wildRydesRole-rinku"
#   tags = {
#     Name = "rinku-lambda-function"
#   }
# }

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.js"
  output_path = "index.zip"
}


resource "aws_lambda_function" "lambda" {
  function_name = var.lambda-name
  architectures = ["x86_64"]
  filename      = data.archive_file.lambda.output_path
  runtime       = "nodejs16.x"
  role          = "arn:aws:iam::587172484624:role/wildRydesRole-rinku"
  # role = "arn:aws:iam::587172484624:role/Priyanshu-Gohil-WildRydesLambda-role"
  handler = "index.handler"
}

output "lambda_name" {
  value = aws_lambda_function.lambda.arn

}
