terraform {
  backend "s3" {
    bucket = "primus-learning-terraform-bk"
    key = "mydemo-app/terraform.tfstate"
    region = "ap-south-1"

  }
}