terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "state/path/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-lock-table"
    encrypt        = true
  }
}
