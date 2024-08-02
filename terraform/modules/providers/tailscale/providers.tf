
  terraform {
    required_providers {
    tailscale = {
      source = "tailscale/tailscale"
      version = "0.16.0"
    }
   }
  }
     variable "tailscale_api_key"{
    type        = string
    sensitive = true

  }
provider "tailscale" {
  base_url="https://tailscale.com/api"
scopes=["all"]
tailnet="ji-podhead.github"
//oauth_client_id = var.TAILSCALE_OAUTH_CLIENT_ID
    api_key = var.tailscale_api_key
    //data.vault_kv_secret_v2.tailscale_api_key.data["key1"]
  //data.vault_kv_secret_v2.tailscale.data["client"]
  //oauth_client_secret =var.TAILSCALE_OAUTH_CLIENT_SECRET
  //data.vault_kv_secret_v2.tailscale.data["secret"]
  }