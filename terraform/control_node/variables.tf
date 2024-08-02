  variable "vault_token"{
    type        = string
    sensitive = true
  }
  variable "vault_role_id"{
    type        = string
    sensitive = true

  }
  variable "vault_role_secret_id"{
    type        = string
    sensitive = true

  }
  variable "api_key"{
    type        = string
    sensitive = true

  }
 
  data "vault_kv_secret_v2" "github" {
  mount = "keyvalue"
  name  = "terraform/github"
}
  data "vault_kv_secret_v2" "proxmox" {
  mount = "keyvalue"
  name  = "terraform/proxmox"
}
data "vault_kv_secret_v2" "tailscale_oauth" {
  mount = "keyvalue"
  name  = "terraform/tailscale/oauth1"
}
data "vault_kv_secret_v2" "tailscale_api_key" {
  mount = "keyvalue"
  name  = "terraform/tailscale/api_key"
}


locals {
  // conf = data.external.config.result.login
    dir = "${path.module}"
    conf = jsondecode(file("${path.module}/../../config/proxmox/vm_config_1.json"))
   // device_info = jsondecode(file("${path.module}/devi.json"))
    repo = "Pod-Shop-App-Configs"
    owner="ji-podhead"
    
  }