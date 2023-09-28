resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role_arn
  dynamic "vpc_config" {
    for_each = length(var.vpc_config) == 0 ? [] : var.vpc_config
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }
  timeout     = var.timeout
  memory_size = var.memory_size
  filename    = var.filename
  description = var.description
  #source_code_hash = data.archive_file.lambda-exec.output_base64sha256
  source_code_hash = var.source_code_hash
  s3_bucket        = var.s3_bucket
  s3_key           = var.s3_key

  dynamic "tracing_config" {
    for_each = var.tracing_config == null ? [] : [1]
    content {
      mode = var.tracing_config
    }

  }
  dynamic "environment" {
    for_each = length(var.environment) == 0 ? [] : var.environment
    content {
      variables = environment.value.variables
    }
  }
  tags = var.tags
}

resource "aws_lambda_permission" "this" {
  depends_on    = [aws_lambda_function.this]
  for_each      = { for idx, value in var.invoke_function : idx => value }
  action        = each.value.action
  principal     = each.value.principal
  source_arn    = each.value.principal_source_arn
  function_name = aws_lambda_function.this.function_name
}
