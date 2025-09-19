output "policy_id" {
  description = "Policy ID (ARN)."
  value       = aws_iam_policy.policy.id
}

output "policy_arn" {
  description = "Policy ARN."
  value       = aws_iam_policy.policy.arn
}

output "topic_name" {
  description = "Topic Name."
  value       = var.topic_name
}
