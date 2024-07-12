variable "aws_rds_cluster_identifier" {
    type = string
    description = "cluster name"
}

variable "aws_rds_cluster_engine" {
    type = string
    description = "declaration of data base type" 
}

variable "aws_rds_cluster_engine_version" {
    type = string
    description = "The value represent the specific version of the database"
}

variable "private_zones" {
    type = list(string)
    description = "Private subnets for RDS"
  
}

variable "vpc_id" {
    type = string
    description = "VPC for RDS"
  
}

variable "security_group_ecs" {
    type = list(string)
    description = "accept traffic from ecs SG"
  
}

variable "replica_count" {
    type = number
    description = "The number represent how many DB instances to provision on DB cluster"
}

variable "aws_rds_cluster_database_name" {
    type = string
    description = "declaration of database name"
}

variable "aws_rds_cluster_port" {
    type = number
    description = "The port database will listen/open"
}

variable "rds_credentials_username" {
    type = string
    description = "username to connect DB"
}

variable "aws_rds_cluster_env_tag" {
    type = string
    description = "declaration of enviroment tag"
}

variable "aws_rds_cluster_instance_identifier_name" {
    type = string
    description = "declaration of cluster instance name"
}

variable "aws_rds_cluster_instance_instane_class" {
    type = string
    description = "It represents the compute type of the DB"
}