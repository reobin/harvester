terraform {
  backend "s3" {
    bucket = "harvester-terraform-backend"
    region = "us-east-1"
    key    = "main"
  }
}
