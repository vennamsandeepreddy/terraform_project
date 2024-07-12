# Example values with respect to Prod Env


############ variables for ACM Module ############

aws_acm_certificate_domain_name = "vennam.com"
aws_acm_certificate_validation_method = "DNS"


############ variables for ALB Module ############

lb_name = "api"
load_balancer_type = "application"
aws_lb_listener_port = 443
aws_lb_listener_protocol = "HTTPS"
aws_lb_target_group_name = "api-tg"
env = "prod"
aws_lb_target_group_port = 80
aws_lb_target_group_protocol = "TCP"


############ variables for VPC Module  ############


vpc_cidr_block = "10.0.0.0/16"
aws_subnet_public_subnet1_cidr_block = "10.0.1.0/24"
aws_subnet_public_subnet2_cidr_block = "10.0.2.0/24"
aws_subnet_private_subnet1_cidr_block = "10.0.3.0/24"
aws_subnet_private_subnet2_cidr_block = "10.0.4.0/24"
availability_zone1 = "eu-west-1a"
availability_zone2 = "eu-west-1b"


############ variables for RDS module ############

aws_rds_cluster_identifier = "production-database"
aws_rds_cluster_engine = "aurora-mysql"
aws_rds_cluster_engine_version = "8.0.mysql_aurora.3.05.2"
aws_rds_cluster_database_name = "prod"
rds_credentials_username = "username"
aws_rds_cluster_port = 3306
aws_rds_cluster_instance_identifier_name = "replica-a"
replica_count = 2
aws_rds_cluster_instance_instane_class = "db.t3.medium"
aws_rds_cluster_env_tag = "prod"

############ variables for s3 and dynamodb ############

s3_bucket_name = "terraform-state-file-backend"
s3_bucket_region = "eu-west-1"
dynamodb_table_name = "terraform_state_prd"
dynamodb_hask_key = "LockID"
dynamodb_billing_mode = "PAY_PER_REQUEST"
dynamodb_hask_key_type = "S"

############ variables for ecs module  ############

aws_ecs_cluster_name = "api"
capacity_providers_type = "FARGATE"
capacity_provider_strategy_base_value = 1
capacity_provider_strategy_weight_value = 100
aws_ecs_service_service_name = "helloworld"
aws_ecs_service_task_desired_count = 1
deployment_minimum_healthy_percent = 100
deployment_maximum_percent = 200
ecs_service_port = 80
ecs_service_protocol = "TCP"
aws_ecs_container_name = "nginx"
aws_ecs_container_port = 80
aws_ecs_task_definition_name = "helloworld"
aws_ecs_task_definition_cpu_limit = 512
aws_ecs_task_definition_memory_limit = 1024
aws_ecs_task_definition_container_image = "public.ecr.aws/nginx/nginx:stable-alpine3.19-slim"