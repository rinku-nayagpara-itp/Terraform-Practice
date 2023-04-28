variable "repo" {
  default = "rinku-nayagpara-wildrydes"
}

output "clone_url_http" {
  value = aws_codecommit_repository.codecommit-repo.clone_url_http
}

output "arn" {
  value = aws_codecommit_repository.codecommit-repo.arn
}
