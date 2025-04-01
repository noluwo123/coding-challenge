output "vpc_id" {
  value = module.vpc.aws_vpc_id
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.id
}

output "frontend_ecr_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "backend_ecr_repository_url" {
  value = module.ecr.backend_repository_url
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = module.alb.frontend_target_group_arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = module.alb.backend_target_group_arn
}
