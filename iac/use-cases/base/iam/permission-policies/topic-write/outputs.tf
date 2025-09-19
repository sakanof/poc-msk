output "policy_id" {
  description = "Policy ID (ARN)."
  value       = module.write.policy_id
}

output "policy_arn" {
  description = "Policy ARN."
  value       = module.write.policy_arn
}

output "topic_name" {
  description = "Topic Name."
  value       = var.topic_name
}
