output "policy_id" {
  description = "Policy ID (ARN)."
  value       = module.policy.policy_id
}

output "policy_arn" {
  description = "Policy ID (ARN)."
  value       = module.policy.policy_arn
}

output "topic_name" {
  description = "Topic Name."
  value       = var.topic_name
}
