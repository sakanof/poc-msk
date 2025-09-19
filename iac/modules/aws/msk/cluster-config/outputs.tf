output "arn" {
  value = aws_msk_configuration.this.arn
}

output "latest_revision" {
  value = aws_msk_configuration.this.latest_revision
}
