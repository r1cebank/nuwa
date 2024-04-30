terraform {
  required_providers {
    # xenorchestra = {
    #   source = "terra-farm/xenorchestra"
    #   version = "0.24.1"
    # }
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# provider "xenorchestra" {
#   url      = data.external.env.result.XOA_URL
#   username = data.external.env.result.XOA_USER
#   password = data.external.env.result.XOA_PASSWORD
# }

provider "proxmox" {
  # Configuration options
  pm_api_url = data.external.env.result.PROXMOX_URL
  pm_api_token_id = data.external.env.result.PROXMOX_TOKEN_ID
  pm_api_token_secret = data.external.env.result.PROXMOX_TOKEN_SECRET
}