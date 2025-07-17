output "cluster_name" {
  	description = "EKS cluster name"
  	value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  	description = "EKS cluster endpoint"
  	value       = module.eks.cluster_endpoint
}

output "update_kubeconfig_command" {
  	description = "Command to update your kubeconfig for kubectl access"
  	value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ap-south-1"
}

