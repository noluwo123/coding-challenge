variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "List of public subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID in which ALB resides"
  type        = string
}

variable "frontend_port" {
  description = "Port on which frontend service listens behind ALB"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Port on which backend service listens behind ALB"
  type        = number
  default     = 3000
}

variable "frontend_health_check_path" {
  description = "Health check path for the frontend target group"
  type        = string
  default     = "/"
}

variable "backend_health_check_path" {
  description = "Health check path for the backend target group"
  type        = string
  default     = "/api/health"
}

# Optional: if you want to route based on host header for backend
variable "backend_host_header" {
  description = "Host header value for backend routing (optional)"
  type        = string
  default     = ""
}

variable "backend_path_pattern" {
  description = "Path pattern for routing to backend target group"
  type        = string
  default     = "/api/*"
}
