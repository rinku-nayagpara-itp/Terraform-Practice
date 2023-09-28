# Gathers information about the VPC
data "aws_vpc" "main" {
  id = var.vpc_id
}

# Creates a new empty file system in EFS.
resource "aws_efs_file_system" "main" {
  encrypted = true
  tags = merge(
    {
      "Name" = "${var.default_name_prefix}-efs"
    },
    {
      "T4res" = "efs"
    },
    var.tags,
  )
}

# Creates a mount target of EFS in a specified subnet
resource "aws_efs_mount_target" "main" {
  count = length(var.subnets)

  file_system_id = aws_efs_file_system.main.id
  subnet_id      = element(var.subnets, count.index)

  security_groups = [
    aws_security_group.efs.id,
  ]
}

# Allow both ingress and egress for port 2049 (NFS)
resource "aws_security_group" "efs" {
  name        = "${var.default_name_prefix}-efs-mnt"
  description = "Allows NFS traffic from instances within the VPC."
  vpc_id      = var.vpc_id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }

  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }

  tags = merge(
    {
      "Name" = "${var.default_name_prefix}-sg"
    },
    {
      "T4res" = "sg"
    },
    var.tags,
  )
}

