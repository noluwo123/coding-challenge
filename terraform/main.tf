provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  vpc_name        = var.vpc_name
}

resource "aws_s3_bucket" "backend_state" {
  bucket = "my-terraform-state-bucket"  # Replace with your bucket name
}

resource "aws_s3_bucket_acl" "backend_state_acl" {
  bucket = aws_s3_bucket.backend_state.id
  acl    = "private"
}

module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = var.cluster_name
}

module "iam" {
  source              = "./modules/iam"
  execution_role_name = var.execution_role_name
  jenkins_role_name   = var.jenkins_role_name
  state_bucket_arn    = aws_s3_bucket.backend_state.arn
}

module "ecr" {
  source             = "./modules/ecr"
  frontend_repo_name = var.frontend_repo_name
  backend_repo_name  = var.backend_repo_name
}

module "alb" {
  source                      = "./modules/alb"
  alb_name                    = var.alb_name
  security_groups             = var.alb_security_groups
  subnets                     = module.vpc.public_subnets_ids
  vpc_id                      = module.vpc.aws_vpc_id
  frontend_port               = var.alb_frontend_port
  backend_port                = var.alb_backend_port
  frontend_health_check_path  = var.alb_frontend_health_check_path
  backend_health_check_path   = var.alb_backend_health_check_path
  backend_host_header         = var.alb_backend_host_header
  backend_path_pattern        = var.alb_backend_path_pattern
}

module "frontend_service" {
  source             = "./modules/ecs_service"
  service_name       = var.frontend_service_name
  task_family        = "frontend-task"
  container_name     = "frontend"
  container_port     = var.frontend_container_port
  image              = var.frontend_image  # To be dynamically updated by your Jenkins pipeline
  cpu                = var.frontend_cpu
  memory             = var.frontend_memory
  desired_count      = var.frontend_desired_count
  cluster_id         = module.ecs_cluster.id
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  subnets            = module.vpc.private_subnets_ids
  security_groups    = var.ecs_security_group_ids
  target_group_arn   = module.alb.frontend_target_group_arn
  region             = var.aws_region
}

module "backend_service" {
  source             = "./modules/ecs_service"
  service_name       = var.backend_service_name
  task_family        = "backend-task"
  container_name     = "backend"
  container_port     = var.backend_container_port
  image              = var.backend_image  # To be dynamically updated by your Jenkins pipeline
  cpu                = var.backend_cpu
  memory             = var.backend_memory
  desired_count      = var.backend_desired_count
  cluster_id         = module.ecs_cluster.id
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  subnets            = module.vpc.private_subnets_ids
  security_groups    = var.ecs_security_group_ids
  target_group_arn   = module.alb.backend_target_group_arn
  region             = var.aws_region
}
