terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "test-bucket-netology-91nickel"
    encrypt = true
    key    = "terraform.tfstate"
    region = "us-west-2"
//    dynamodb_table = "terraform-locks"
  }
}
