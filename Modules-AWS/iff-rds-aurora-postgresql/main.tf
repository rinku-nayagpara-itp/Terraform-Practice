data "aws_vpc" "vpc" {
  id = var.vpc_id
}

variable "tags" {
  type = map(string)
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier              = "${var.name}-${var.engine}-${var.environment}-cluster"
  availability_zones              = var.azs
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  engine                          = var.engine
  engine_version                  = var.engine_version
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  vpc_security_group_ids          = [aws_security_group.aurora_security_group.id]
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = aws_kms_key.aurora.arn
  apply_immediately               = var.apply_immediately
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_parameter_group.id
  final_snapshot_identifier       = "final-snapshot-${var.name}-${var.engine}-${var.environment}"

  tags = merge(
    var.tags,
    {
      "Name"  = "${var.name}-${var.engine}-${var.environment}-cluster"
      "T4res" = "rds-cluster"
      "T11ap" = "db"
    },
  )

  skip_final_snapshot                 = true
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  lifecycle {
    prevent_destroy = "false"
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count                   = var.cluster_size
  identifier              = "${var.name}-${var.environment}-${count.index}"
  engine                  = var.engine
  engine_version          = var.engine_version
  cluster_identifier      = aws_rds_cluster.aurora.id
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.id
  db_parameter_group_name = aws_db_parameter_group.aurora_parameter_group.id
  apply_immediately       = var.apply_immediately
  monitoring_role_arn     = aws_iam_role.aurora_instance_role.arn
  monitoring_interval     = "5"

  tags = merge(
    var.tags,
    {
      "Name"  = "${var.name}-${var.environment}-${count.index}"
      "T4res" = "rds-instance"
      "T11ap" = "db"
    },
  )
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "rds-${var.name}-${var.engine}-${var.environment}-subnet-groups"
  subnet_ids = var.subnets

  tags = merge(
    var.tags,
    {
      "Name"  = "${var.name}-${var.engine}-${var.environment}-rds-subnet-groups"
      "T4res" = "subnet-groups"
      "T11ap" = "db"
    },
  )
}

resource "aws_db_parameter_group" "aurora_parameter_group" {
  name        = "rds-${var.name}-${var.engine}-${var.environment}-db-param-groups"
  family      = var.family
  description = "Managed parameter group for ${var.name}-${var.engine}-${var.environment}-db-param-groups"

  dynamic "parameter" {
    for_each = [var.db_parameters]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = merge(
    var.tags,
    {
      "Name"  = "${var.name}-${var.engine}-${var.environment}-db-param-groups"
      "T4res" = "db-parameter-groups"
      "T11ap" = "db"
    },
  )
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name        = "rds-${var.name}-${var.engine}-${var.environment}-cluster-param-groups"
  family      = var.family
  description = "Managed cluster parameter group for ${var.name}-${var.engine}-${var.environment}-cluster-param-groups"

  dynamic "parameter" {
    for_each = [var.cluster_parameters]
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = merge(
    var.tags,
    {
      "Name"  = "${var.name}-${var.engine}-${var.environment}-cluster-param-groups"
      "T4res" = "cluster-parameter-groups"
      "T11ap" = "db"
    },
  )
}

/*
resource "aws_db_option_group" "aurora_option_group" {
  name                     = "rds-${var.name}-${var.environment}-db-option-groups"
  option_group_description = "Managed option group for ${var.name}-${var.engine}-${var.environment}-db-option-groups"
  engine_name              = "${var.engine}"
  major_engine_version     = "${var.major_engine_version}"
}
*/

resource "aws_iam_role" "aurora_instance_role" {
  name               = "role-rds-${var.name}-${var.engine}-${var.environment}"
  assume_role_policy = file("${path.module}/files/iam/assume_role_rds_monitoring.json")
  path               = "/tf/${var.environment}/${var.name}-${var.engine}-${var.environment}/"
}

resource "aws_iam_role_policy_attachment" "aurora_policy_rds_monitoring" {
  role       = aws_iam_role.aurora_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_route53_record" "rds-endpoint-route53" {
  zone_id = var.zone_id
  name    = "${var.name}.rds.iff${var.environment}.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster.aurora.endpoint]
}

resource "aws_route53_record" "rds-reader-route53" {
  zone_id = var.zone_id
  name    = "${var.name}.reader.rds.iff${var.environment}.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_rds_cluster.aurora.reader_endpoint]
}

