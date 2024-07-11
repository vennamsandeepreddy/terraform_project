# This is only a desired format for backend configuration, by default terraform doesn't allow to use variables....
# .. in backend configuration, use environment variables to declare neccessary values or create ...
# .. backend-config.hcl file to directly declare values to create backend configuration

/*terraform {
backend "s3" {
    bucket         = var.s3_bucket_name
    key            = "terraform.tfstate"
    region         = var.s3_bucket_region
    dynamodb_table = var.dynamodb_table_name
  }
}*/  