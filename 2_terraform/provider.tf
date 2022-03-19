terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.2"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url      = var.pm_api_url
  pm_tls_insecure = true
  pm_user         = var.pm_user
  pm_password     = var.pm_password

  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = "test"
  }
}
