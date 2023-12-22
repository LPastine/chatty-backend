terraform {
  backend "s3" {
    bucket  = "chatty-server-terraform-state"
    key     = "develop/chatty.tfstate"
    region  = var.aws_region
    encrypt = true
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    ManagedBy   = "Terraform"
    Owner       = "Luciano Pastine"
  }
}
