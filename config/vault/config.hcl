storage "file" {
  path = "/var/vault/data"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}

api_addr = "https://127.0.0.1:8200"
ui = true