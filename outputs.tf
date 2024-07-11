output "VPC_ID" {
    description = "VPC ID"
    value = module.vpc.vpc_id
}

output "Public_Subnets_IDs" {
    description = "Public Subnets ID in VPC"
    value = module.vpc.public_subnets
}

output "Private_Subnets_IDs" {
    description = "Private Subnets ID in VPC"
    value = module.vpc.private_subnets
}


output "RDS_Cluster_Endpoint" {
  description = "RDS Cluster Endpoint"
  value = module.rds.rds_endpoint
}

output "ALB_DNS_Name" {
    description = "the DNS Name of ALB"
    value = module.alb.load_balancer_dns
}