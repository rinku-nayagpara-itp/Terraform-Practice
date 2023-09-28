output "record_fqdn" {
  value = var.records== null? aws_route53_record.record[0].fqdn : aws_route53_record.this[0].fqdn
}