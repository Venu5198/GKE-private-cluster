terraform {
  backend "gcs" {
    bucket = "kxnwork-tf-state"
    prefix = "vpc"
  }
}

