variable "aws_ecs_cluster_name" {
    type = string
    description = "declaration of ECS Cluster name"
}

variable "capacity_providers_type" {
    type = string
    description = "Capacity Provider type to be used for ECS tasks"  
}

variable "capacity_provider_strategy_base_value" {
    type = number
    description = "The base values refers - minimum guaranteed capacity reserved"
}

variable "capacity_provider_strategy_weight_value" {
    type = number
    description = "It determines the share of resources a Provider should receive when tasks are placed"
}

variable "private_subnets" {
    type = set(string)
    description = "Private subnets to launch ECS"
}

variable "ecs_service_port" {
    type = number
    description = "ECS service listening port from ALB"
}

variable "ecs_service_protocol" {
  type = string
  description = "ECS service accepting traffic protocl from ALB listener"
}

variable "alb_sg" {
    type = list(string)
    description = "ECS ingress rule to accept traffic from ALB" 
}

variable "lb_target_group_id" {
    type = string
    description = "Attaching ALB TG to ECS"
}

variable "aws_ecs_service_service_name" {
    type = string
    description = "ECS Service Name" 
}

variable "aws_ecs_service_task_desired_count" {
    type = number
    description = "It represents the minimum availability of task"
}    

variable "deployment_minimum_healthy_percent" {
    type = number
    description = "when desired task count is 1, it makes sure always 1 task is running" 
}

variable "deployment_maximum_percent" {
    type = number 
    description = "Until the newer deployment is available, it won't delete the previous version of task" 
}

variable "vpc_id" {
  type = string
  description = "VPC in which the SG is created"
}
variable "aws_ecs_container_name" {
  type = string
  description = "declaration of container name"
}

variable "aws_ecs_container_port" {
  type = number
  description = "the declared port which will be exposed on the container"
}

variable "aws_ecs_task_definition_name" {
    type = string
    description = "declaration of task definition family name"
}

variable "aws_ecs_task_definition_cpu_limit" {
    type = number
    description = "It represents the CPU reqiurment in bytes for the task"
}

variable "aws_ecs_task_definition_memory_limit" {
    type = number
    description = "It represents the memory reqiurment in bytes for the task"
}

variable "aws_ecs_task_definition_container_image" {
    type = string
    description = "Image to be used for the container"
}