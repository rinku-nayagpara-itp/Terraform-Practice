output "arn" {
  value = aws_instance.instance.arn
}
output "id" {
  value = aws_instance.instance.id
}
output "public_ip" {
 value = aws_instance.instance.public_ip 
}
output "private_ip" {
  value = aws_instance.instance.private_ip
}
output "public_dns" {
  value = aws_instance.instance.public_dns
}