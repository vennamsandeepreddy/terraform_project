variable "aws_acm_certificate_domain_name" {
    type = string
    description = "Declaration of domain name to which Certificate is created"
}

variable "aws_acm_certificate_validation_method" {
    type = string
    description = "Declaration of validation method to use to verify certificate"
}