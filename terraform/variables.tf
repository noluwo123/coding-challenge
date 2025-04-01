variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  default     = "lightfeather-vpc"
}

variable "cluster_name" {
  description = "Name for the ECS cluster"
  default     = "lightfeather-cluster"
}

variable "execution_role_name" {
  description = "Name for the ECS task execution role"
  default     = "lightfeather-ecs-task-execution-role"
}

variable "frontend_repo_name" {
  description = "Name of the frontend ECR repository"
  default     = "lightfeather-frontend"
}

variable "backend_repo_name" {
  description = "Name of the backend ECR repository"
  default     = "lightfeather-backend"
}

variable "alb_name" {
  description = "Name of the ALB"
  default     = "lightfeather-alb"
}

variable "alb_security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

# The public subnet IDs for ALB come from the VPC module outputs
variable "public_subnets_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "alb_frontend_port" {
  description = "Port for frontend target group"
  default     = 80
}

variable "alb_backend_port" {
  description = "Port for backend target group"
  default     = 3000
}

variable "alb_frontend_health_check_path" {
  description = "Health check path for the frontend"
  default     = "/"
}

variable "alb_backend_health_check_path" {
  description = "Health check path for the backend"
  default     = "/api/health"
}

variable "alb_backend_host_header" {
  description = "Optional host header for backend routing"
  default     = ""
}

variable "alb_backend_path_pattern" {
  description = "Path pattern to forward to backend"
  default     = "/api/*"
}

variable "frontend_service_name" {
  description = "Name of the frontend ECS service"
  default     = "frontend-service"
}

variable "backend_service_name" {
  description = "Name of the backend ECS service"
  default     = "backend-service"
}

variable "frontend_container_port" {
  description = "Port on which the frontend container listens"
  default     = 80
}

variable "backend_container_port" {
  description = "Port on which the backend container listens"
  default     = 3000
}

variable "frontend_cpu" {
  description = "CPU units for the frontend task"
  default     = 256
}

variable "frontend_memory" {
  description = "Memory (in MiB) for the frontend task"
  default     = 512
}

variable "backend_cpu" {
  description = "CPU units for the backend task"
  default     = 256
}

variable "backend_memory" {
  description = "Memory (in MiB) for the backend task"
  default     = 512
}

variable "frontend_desired_count" {
  description = "Desired count for the frontend service"
  default     = 1
}

variable "backend_desired_count" {
  description = "Desired count for the backend service"
  default     = 1
}

variable "frontend_image" {
  description = "Docker image URI for the frontend service (set dynamically)"
  default     = "PLACEHOLDER_FRONTEND_IMAGE"
}

variable "backend_image" {
  description = "Docker image URI for the backend service (set dynamically)"
  default     = "PLACEHOLDER_BACKEND_IMAGE"
}

variable "ecs_security_group_ids" {
  description = "List of security group IDs for ECS tasks"
  type        = list(string)
}

variable "jenkins_role_arn" {
  description = "The ARN of the Jenkins server IAM role"
  type        = string
}

variable "jenkins_role_name" {
  description = "The Jenkins role name"
  default = "lightfeather-jenkins-role"
  type        = string
}