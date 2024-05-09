terraform {
  backend "s3" {
    bucket         = "terraform-state-mina-lab"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-mina"
  }
}
