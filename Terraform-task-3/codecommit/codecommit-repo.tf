resource "aws_codecommit_repository" "codecommit-repo" {
  repository_name = var.repo
  tags = {
    "Name" = "rinku-repo"
  }
}