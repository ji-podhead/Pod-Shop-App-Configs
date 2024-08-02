variable "vault_token"{
    type        = string
    sensitive = true
    }
provider "vault" {
    address = "http://127.0.0.1:8200"
    token = var.vault_token
    add_address_to_env = true
    skip_child_token = true
}