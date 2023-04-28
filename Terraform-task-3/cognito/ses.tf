resource "aws_ses_email_identity" "mail-identity" {
  email = var.from-email
  
}