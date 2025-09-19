output "policy_id" {
  description = "Policy ID (ARN)."
  value       = aws_iam_policy.write.id
}

output "policy_arn" {
  description = "Policy ARN."
  value       = aws_iam_policy.write.arn
}

output "topic_name" {
  description = "Topic Name."
  value       = var.topic_name
}
