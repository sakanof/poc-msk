output "id" {
  description = "Role ID."
  value       = module.eks_cluster_role.role_id
}

output "arn" {
  description = "Role ARN."
  value       = module.eks_cluster_role.arn
}

output "name" {
  description = "Role Name."
  value       = module.eks_cluster_role.name
}

