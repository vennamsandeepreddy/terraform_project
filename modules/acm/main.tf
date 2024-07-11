resource "aws_acm_certificate" "cert" {
  domain_name       = var.aws_acm_certificate_domain_name
  validation_method = var.aws_acm_certificate_validation_method


# this lifecyle helps in replacing the certificate whenever there is an rotation of certificate
  lifecycle {
    create_before_destroy = true
  }
}