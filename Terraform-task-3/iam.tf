# IAM user for codecommit

data "aws_iam_policy" "codecommit" {
  name = "AWSCodeCommitFullAccess"
}

module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                    = var.codecommit-user-name
  force_destroy           = true
  create_iam_access_key   = false
  password_reset_required = false
  tags = {
    Name = "rinku-codecommit-user"
  }
}
resource "aws_iam_service_specific_credential" "iam-git-credential" {
  service_name = "codecommit.amazonaws.com"
  user_name    = module.iam_user.iam_user_name
}
resource "aws_iam_policy_attachment" "policy-attachment" {
  name       = "policy-attachment"
  policy_arn = data.aws_iam_policy.codecommit.arn
  users      = [module.iam_user.iam_user_name]
}


# IAM role for lambda

# data "aws_iam_policy_document" "instance_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#   }
# }

data "aws_iam_policy" "lambda-execution-policy" {
  name = "AWSLambdaBasicExecutionRole"
}

module "lambda-role" {
  source                  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version                 = "5.16.0"
  role_name               = var.lambda-role-name
  role_requires_mfa       = false
  trusted_role_services   = ["lambda.amazonaws.com"]
  create_role             = true
  custom_role_policy_arns = [data.aws_iam_policy.lambda-execution-policy.arn]
}

resource "aws_iam_role_policy" "dynamodb-write" {
  name = "dynamodb-write"
  role = module.lambda-role.iam_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}