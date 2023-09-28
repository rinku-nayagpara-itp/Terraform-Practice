resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.cluster_identifier
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  engine                  = var.engine
  engine_mode             = var.engine_mode
  backup_retention_period = var.backup_retention_period
  vpc_security_group_ids  = var.vpc_security_group_ids
  storage_encrypted       = var.storage_encrypted
  db_subnet_group_name    = aws_db_subnet_group.this.name

  tags = var.tags

  dynamic "scaling_configuration" {
    for_each = var.scaling_configuration == null ? {} : {1=1}
    content {
      auto_pause               = var.scaling_configuration.auto_pause
      max_capacity             = var.scaling_configuration.max_capacity
      min_capacity             = var.scaling_configuration.min_capacity
      seconds_until_auto_pause = var.scaling_configuration.seconds_until_auto_pause
    }
  }
}

resource "aws_db_subnet_group" "this" {
  name        = var.db_subnet_group_name
  subnet_ids  = var.subnet_ids
  description = var.subnet_group_description
  tags        = var.subnet_tags
}
