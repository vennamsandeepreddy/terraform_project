terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name
 lifecycle {
   prevent_destroy = true
 }
}

resource "aws_s3_bucket_versioning" "terraform_state_file_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
  depends_on = [ aws_s3_bucket.terraform_state ]
}

resource "aws_dynamodb_table" "terraform_state_dynamodb" {
  name         = var.dynamodb_table_name
  hash_key     = var.dynamodb_hask_key
  billing_mode = var.dynamodb_billing_mode
  attribute {
    name = var.dynamodb_hask_key
    type = var.dynamodb_hask_key_type
  }
}

module "acm" {
    source = "./modules/acm"
    aws_acm_certificate_domain_name = var.aws_acm_certificate_domain_name
    aws_acm_certificate_validation_method = var.aws_acm_certificate_validation_method
}

module "alb" {
    source = "./modules/alb"
    lb_name = var.lb_name
    load_balancer_type = var.load_balancer_type
    public_subnets = (module.vpc.public_subnets)
    aws_lb_listener_port = var.aws_lb_listener_port
    aws_lb_listener_protocol = var.aws_lb_listener_protocol
    aws_acm_certificate_arn = module.acm.acm_certificate_arn
    aws_lb_target_group_name = var.aws_lb_target_group_name
    aws_lb_target_group_port = var.aws_lb_target_group_port
    aws_lb_target_group_protocol = var.aws_lb_target_group_protocol
    vpc_id = module.vpc.vpc_id
    env = var.env
    depends_on = [ module.acm, module.vpc ]
}

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    aws_subnet_public_subnet1_cidr_block = var.aws_subnet_public_subnet1_cidr_block
    aws_subnet_public_subnet2_cidr_block = var.aws_subnet_public_subnet2_cidr_block
    aws_subnet_private_subnet1_cidr_block = var.aws_subnet_private_subnet1_cidr_block
    aws_subnet_private_subnet2_cidr_block = var.aws_subnet_private_subnet2_cidr_block
    availability_zone1 = var.availability_zone1
    availability_zone2 = var.availability_zone2
}


module "rds" {
    source = "./modules/rds"
    aws_rds_cluster_identifier = var.aws_rds_cluster_identifier
    aws_rds_cluster_engine = var.aws_rds_cluster_engine
    aws_rds_cluster_engine_version = var.aws_rds_cluster_engine_version
    private_zones = (module.vpc.private_subnets)
    aws_rds_cluster_database_name = var.aws_rds_cluster_database_name
    aws_rds_cluster_port = var.aws_rds_cluster_port
    vpc_id = module.vpc.vpc_id
    security_group_ecs = [module.ecs.security_group_ecs]
    rds_credentials_username = var.rds_credentials_username
    aws_rds_cluster_instance_identifier_name = var.aws_rds_cluster_instance_identifier_name
    aws_rds_cluster_instance_instane_class = var.aws_rds_cluster_instance_instane_class
    aws_rds_cluster_env_tag = var.aws_rds_cluster_env_tag
    depends_on = [ module.vpc , module.ecs ]
}

module "ecs" {
    source = "./modules/ecs"
    aws_ecs_cluster_name = var.aws_ecs_cluster_name
    capacity_providers_type = var.capacity_providers_type
    capacity_provider_strategy_base_value = var.capacity_provider_strategy_base_value
    capacity_provider_strategy_weight_value = var.capacity_provider_strategy_weight_value
    aws_ecs_service_service_name = var.aws_ecs_service_service_name
    aws_ecs_service_task_desired_count = var.aws_ecs_service_task_desired_count
    deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
    deployment_maximum_percent = var.deployment_maximum_percent
    vpc_id = module.vpc.vpc_id
    private_subnets = (module.vpc.private_subnets)
    ecs_service_port = var.ecs_service_port
    ecs_service_protocol = var.ecs_service_protocol
    alb_sg = [module.alb.security_groups_alb]
    lb_target_group_id = module.alb.lb_target_group_arn
    aws_ecs_container_name = var.aws_ecs_container_name
    aws_ecs_container_port = var.aws_ecs_container_port
    aws_ecs_task_definition_name = var.aws_ecs_task_definition_name
    aws_ecs_task_definition_cpu_limit = var.aws_ecs_task_definition_cpu_limit
    aws_ecs_task_definition_memory_limit = var.aws_ecs_task_definition_memory_limit
    aws_ecs_task_definition_container_image = var.aws_ecs_task_definition_container_image
    depends_on = [ module.vpc, module.alb ]
}