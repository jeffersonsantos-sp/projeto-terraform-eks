terraform {
  backend "s3" {
    bucket = "phibro-tfstate"
    key    = "tfstate/dev/terraform.tfstate"
    region = "us-west-2"
  }
}
