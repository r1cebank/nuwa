terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
      version = "0.24.1"
    }
  }
}

provider "xenorchestra" {
  url      = data.external.env.result.XOA_URL
  username = data.external.env.result.XOA_USER
  password = data.external.env.result.XOA_PASSWORD
}