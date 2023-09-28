resource "aws_dynamodb_table" "this" {
  name = var.name
  dynamic "attribute" {
    for_each = var.attribute
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  hash_key       = var.hash_key
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
}
