resource "aws_ebs_volume" "ebs" {
  availability_zone = var.availability_zone
  encrypted         = var.encrypted
  size              = var.size
  snapshot_id       = var.snapshot_id
  type              = var.type
  tags              = var.tags
  iops              = var.iops
  multi_attach_enabled = var.multi_attach_enabled
}
