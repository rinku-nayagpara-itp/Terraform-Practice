output "bucket" {
  value = aws_s3_bucket.s3_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "name" {
  value = aws_s3_bucket.s3_bucket.bucket
}
