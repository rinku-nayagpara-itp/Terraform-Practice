resource "aws_ssm_document" "this" {
  name          = var.document_name
  document_type = var.document_type
  tags          = var.ssm_document_tags
  content       = var.content
}