terraform {
  backend "s3" {
    bucket         = "samh-assets"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}