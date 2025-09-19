output "policy_id" {
  description = "Policy ID (ARN)."
  value       = module.read.policy_id
}

output "policy_arn" {
  description = "Policy ARN."
  value       = module.read.policy_arn
}

output "topic_name" {
  description = "Topic Name."
  value       = var.topic_name
}
