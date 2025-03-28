resource "aws_ecr_repository" "frontend" {
  name = "devops-challenge-frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "devops-challenge-backend"
}