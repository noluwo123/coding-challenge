variable "execution_role_name" {
  description = "Name for the ECS task execution role"
  type        = string
}

variable "jenkins_role_name" {
  description = "Name for the Jenkins server IAM role"
  type        = string
}

variable "state_bucket_arn" {
  description = "The ARN of the S3 bucket that holds the Terraform state"
  type        = string
}
