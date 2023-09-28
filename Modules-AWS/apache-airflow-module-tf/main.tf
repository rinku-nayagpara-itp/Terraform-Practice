resource "aws_mwaa_environment" "mwaa" {
  name                            = var.mwaa_name
  airflow_version                 = var.airflow_version
  weekly_maintenance_window_start = var.window

  source_bucket_arn = var.bucket_arn
  dag_s3_path       = var.dag_s3_path

  network_configuration {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  environment_class = var.environment_class
  schedulers        = var.schedulers
  max_workers       = var.max_workers
  min_workers       = var.min_workers

  execution_role_arn = var.role_arn

  kms_key = var.key

  logging_configuration {
    task_logs {
      enabled   = true
      log_level = "INFO"
    }

    worker_logs {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs {
      enabled   = true
      log_level = "INFO"
    }

    dag_processing_logs {
      enabled   = true
      log_level = "INFO"
    }

    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }
  }

  airflow_configuration_options = {
    "core.dag_concurrency" = var.airflow_configuration_options.dag_concurrency
    "core.parallelism"     = var.airflow_configuration_options.parallelism
    "email.email_backend"  = var.airflow_configuration_options.email_backend
    "smtp.smtp_mail_from"  = var.airflow_configuration_options.smtp_mail_from
    "smtp.smtp_host"       = var.airflow_configuration_options.smtp_host
    "smtp.smtp_port"       = var.airflow_configuration_options.smtp_port
    "smtp.smtp_ssl"        = var.airflow_configuration_options.smtp_ssl
    "smtp.smtp_starttls"   = var.airflow_configuration_options.smtp_starttls
  }

  tags = var.tags
}
