terraform {
  backend "http" {}
  required_providers {
    serverspace = {
      source = "itglobalcom/serverspace"
      version = "0.3.0"
    }
  }
  required_version = ">= 1.0"
}