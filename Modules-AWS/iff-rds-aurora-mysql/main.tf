resource "aws_rds_cluster" "aurora-mysql" {
  database_name                   = var.database_name
  backup_retention_period         = var.backup_retention_period
  cluster_identifier              = var.cluster_identifier
  engine                          = var.engine
  master_username                 = var.master_username
  master_password                 = var.master_password
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  storage_encrypted               = var.storage_encrypted
  vpc_security_group_ids          = var.vpc_security_group_ids
  skip_final_snapshot             = true
  tags                            = var.tags_rds_cluster
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = var.subnet_group_name
  description = var.description
  subnet_ids  = var.subnet_ids
  tags        = var.tags_db_subnet_group
}

resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  instance_class       = var.instance_class
  identifier           = var.identifier
  cluster_identifier   = aws_rds_cluster.aurora-mysql.id
  db_subnet_group_name = aws_db_subnet_group.subnet_group.id
  engine               = var.engine
  tags                 = var.tags_rds_cluster_instance
}
