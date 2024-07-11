variable "lb_name" {
  type = string
  description = "Load Balancer Name"
}

variable "load_balancer_type" {
    type = string
    description = "Load Balancer Type"
}

variable "public_subnets" {
  type = list(string)
  description = "Public subnets for ALB"
  
}

variable "env" {
    type = string
    description = "Declaration of a tag value "
}

variable "aws_acm_certificate_arn" {
  type = string
  description = "The value is of ssl certificate using for protocol 433 towards ALB"
}

variable "aws_lb_listener_port" {
  type = number
}

variable "aws_lb_listener_protocol" {
  type = string
  description = "Protocol to be used"
}

variable "aws_lb_listener_ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
  type = string
  description = "using the default Security Policy for LB"
}

variable "aws_lb_target_group_name" {
    type = string
    description = "Target group name"
}

variable "aws_lb_target_group_port" {
    type = number
    description = "target port to listen"
}

variable "aws_lb_target_group_protocol" {
    type = string
    description = "Protocl to be used for TG "
}

variable "vpc_id" {
  type = string
  description = "VPC need to be used for the TG"
}