terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.22"
    }
  }
}

provider "intersight" {

  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = "https://intersight.com"
  #  apikey    = var.api_key
  #  secretkey = var.api_key_file
  #  endpoint  = var.api_endpoint
  #  # Configuration options
}

