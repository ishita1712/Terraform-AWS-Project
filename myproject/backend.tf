# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "my-statefile-s3bucket-0103"
    key    = "myproject.tfstate"
    region = "us-east-1"

  }
}

