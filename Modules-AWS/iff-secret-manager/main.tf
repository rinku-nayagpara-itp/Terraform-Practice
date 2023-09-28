resource "aws_secretsmanager_secret" "this" {
  name = var.name
  description = var.description
  kms_key_id = var.kms_key_id
    lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_string)
}

resource "aws_secretsmanager_secret_policy" "this" {
  count = var.policy == null ? 0:1
  secret_arn = aws_secretsmanager_secret.this.arn
  policy     = var.policy
}