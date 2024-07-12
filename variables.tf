############  Variables for ACM Module ############
variable "aws_acm_certificate_domain_name" {}
variable "aws_acm_certificate_validation_method" {}


############ Variables for ALB Module ############
variable "lb_name" {}
variable "load_balancer_type" {}
variable "aws_lb_listener_port" {}
variable "aws_lb_listener_protocol" {}
variable "aws_lb_target_group_name" {}
variable "env" {}
variable "aws_lb_target_group_port" {}
variable "aws_lb_target_group_protocol" {}

############ Variables for VPC Module ############
variable "vpc_cidr_block" {}
variable "aws_subnet_public_subnet1_cidr_block" {}
variable "aws_subnet_public_subnet2_cidr_block" {}
variable "aws_subnet_private_subnet1_cidr_block" {}
variable "aws_subnet_private_subnet2_cidr_block" {}
variable "availability_zone1" {}
variable "availability_zone2" {}


############ Variables for RDS Module ############


variable "aws_rds_cluster_identifier" {}
variable "aws_rds_cluster_engine" {}
variable "aws_rds_cluster_engine_version" {}
variable "aws_rds_cluster_database_name" {}
variable "aws_rds_cluster_port" {}
variable "aws_rds_cluster_instance_identifier_name" {}
variable "aws_rds_cluster_instance_instane_class" {}
variable "aws_rds_cluster_env_tag" {}
variable "rds_credentials_username" {}
variable "replica_count" {}


############ Variables for ECS Module ############

variable "aws_ecs_cluster_name" {}
variable "capacity_providers_type" {}
variable "capacity_provider_strategy_base_value" {}
variable "capacity_provider_strategy_weight_value" {}
variable "aws_ecs_service_service_name" {}
variable "aws_ecs_service_task_desired_count" {}
variable "deployment_minimum_healthy_percent" {}
variable "deployment_maximum_percent" {}
variable "ecs_service_port" {}
variable "ecs_service_protocol" {}
variable "aws_ecs_container_name" {}
variable "aws_ecs_container_port" {}
variable "aws_ecs_task_definition_name" {}
variable "aws_ecs_task_definition_cpu_limit" {}
variable "aws_ecs_task_definition_memory_limit" {}
variable "aws_ecs_task_definition_container_image" {}


############ Variables for S3 backend and DynamoDB state file Locking ############


variable "s3_bucket_name" {
    default = "terraform-state-file-backend"
}
variable "s3_bucket_region" {
    default = "eu-west-1"
}
variable "dynamodb_table_name" {
    default = "terraform_state_prd"
}
variable "dynamodb_hask_key" {
    default = "LockID"
}
variable "dynamodb_billing_mode" {
    default = "PAY_PER_REQUEST"
}
variable "dynamodb_hask_key_type" {
    default = "S"
}