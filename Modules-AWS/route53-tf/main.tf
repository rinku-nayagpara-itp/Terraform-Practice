resource "aws_route53_record" "record" {
  count = var.records == null ? 1 : 0
  zone_id         = var.zone_id
  name            = var.name
  type            = var.type
  allow_overwrite = var.allow_overwrite

  dynamic "alias" {
    for_each = var.alias == null ? [] : [1]
    content {
      name                   = var.alias.name
      zone_id                = var.alias.zone_id
      evaluate_target_health = true
    }
  }
}

resource "aws_route53_record" "this" {
  count = var.records == null ? 0 : 1
  zone_id         = var.zone_id
  name            = var.name
  type            = var.type
  records         = var.records
  ttl             = var.ttl
  allow_overwrite = var.allow_overwrite
}
