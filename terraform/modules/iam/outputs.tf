output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "jenkins_role_arn" {
  value = aws_iam_role.jenkins_role.arn
}
