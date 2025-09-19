output "id" {
  description = "Role ID."
  value       = module.eks_cluster_node_role.role_id
}

output "arn" {
  description = "Role ARN."
  value       = module.eks_cluster_node_role.arn
}

output "name" {
  description = "Role Name."
  value       = module.eks_cluster_node_role.name
}
