provider "aws" {
  default_tags {
    tags = {
      Environment = local.environment
      Module      = local.module
    }
  }
}