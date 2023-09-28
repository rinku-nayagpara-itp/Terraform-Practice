resource "random_string" "number" {
  length  = 16
  upper   = false
  lower   = false
  number  = true
  special = false
}

resource "aws_kms_key" "aurora" {
  description             = "RDS master key for ${var.name}-${var.engine}-${var.environment}"
  deletion_window_in_days = 30
  enable_key_rotation     = "true"
}

resource "aws_kms_alias" "aurora" {
  name          = "alias/${var.name}-${var.engine}-${var.environment}-rds-key-${random_string.number.result}"
  target_key_id = aws_kms_key.aurora.key_id
}

