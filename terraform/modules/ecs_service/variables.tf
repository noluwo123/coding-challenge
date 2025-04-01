variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "task_family" {
  description = "Family name for the task definition"
  type        = string
}

variable "container_name" {
  description = "Name of the container within the task"
  type        = string
}

variable "container_port" {
  description = "Container port to expose"
  type        = number
}

variable "image" {
  description = "Docker image URI (including tag)"
  type        = string
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
}

variable "memory" {
  description = "Memory (in MiB) for the task"
  type        = number
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for tasks (typically private subnets)"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the ALB target group to attach to"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
