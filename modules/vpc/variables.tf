variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC."
    type = string
}
variable "aws_subnet_public_subnet1_cidr_block" {
    description = "The CIDR block for the Public Subnet1"
    type = string 
}
variable "aws_subnet_public_subnet2_cidr_block" {
    description = "The CIDR block for the Public Subnet2"
    type = string 
}

variable "aws_subnet_private_subnet1_cidr_block" {
    description = "The CIDR block for the Private Subnet1"
    type = string 
}
variable "aws_subnet_private_subnet2_cidr_block" {
    description = "The CIDR block for the Private Subnet2"
    type = string 
}
variable "availability_zone1" {
    description = "The availabitlity zone 1"
    type = string
}
variable "availability_zone2" {
    description = "The availability zone 2"
    type = string
}