module "vault" {
  source       = "../modules/providers/vault/"
  vault_token = var.vault_token
}


resource "null_resource" "k8s_command1" {
  provisioner "local-exec" {
    command = <<-EOT
curl -H "Authorization: Bearer ${var.api_key}" https://api.tailscale.com/api/v2/tailnet/ji-podhead.github/devices > ../../devi.json
    EOT
    }
}
resource "null_resource" "k8s_command2" {
  provisioner "local-exec" {
    command = <<-EOT
      echo ${join(", ", local.device_info["devices"][0]["addresses"])}
    EOT
  }
}

/*
data "tailscale_device" "base" {
  name = "base.taild5be89.ts.net"
  wait_for = "10s"

}
    output "test" {
    value = data.tailscale_device.base
        }







output "all_addresses" {
  value = data.tailscale_device.dc-workshop1.id
  }

resource "tailscale_tailnet_key" "sample_key" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 3600
  description   = "Sample key"
}
provider "github" {
    token = data.vault_kv_secret_v2.github.data["github_token"]
    
  }
resource "tailscale_device_key" "example_key" {
  device_id           = data.tailscale_device.worker1.id
  key_expiry_disabled = true
connection {
    type     = "ssh"
    user     = "worker"
    password = data.vault_kv_secret_v2.tailscale["pass"]
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo whoami"
      #"puppet apply",
      
    ]
  }
}

data "tailscale_device" "example_device" {
  name = "device.example.com"
}


    


  provider "proxmox" {
    pm_api_url    = local.conf.proxmox_api_url
    pm_api_token_id = local.conf.proxmox_api_token_id
    pm_api_token_secret = data.vault_kv_secret_v2.proxmox.data["proxmox_api_token_secret"]
    #var.sec.proxmox_api_token_secret
    pm_tls_insecure = true
  }
 resource "proxmox_vm_qemu" "wef" {
    name        = "wef2"
    target_node = "my-proxmox"
    tags        = "test"
    vmid        = "502"
    # Clone from windows 2k19-cloudinit template
    clone = "rockyBlank"
    os_type = "cloud-init"
  # Cloud init options
    ipconfig0 = "ip=dhcp"
    memory       = 8192
    agent        = 1
    sockets      = 1
    cores        = 7
    # Set the boot disk paramters
    bootdisk     = "virtio"
    scsihw       = "virtio-scsi-pci"
      disks {
          scsi {
              scsi0 {
                  disk {
                      backup             = true
                      cache              = "none"
                      discard            = true
                      emulatessd         = true
                      iothread           = true
                      mbps_r_burst       = 0.0
                      mbps_r_concurrent  = 0.0
                      mbps_wr_burst      = 0.0
                      mbps_wr_concurrent = 0.0
                      replicate          = true
                      size               = 8
                      storage            = "local-lvm"
                  }
              }
          }
      }
    # Set the network
    network {
      model = "virtio"
      bridge = "vmbr0"
    } # end first network block
    lifecycle {
      ignore_changes = [
        network
      ]
    } # end lifecycle

  }
 /*
  data "github_actions_public_key" "example_public_key" {
    repository = "Pod-Shop-App-Configs"
  }
  resource "github_actions_secret" "example_secret" {
    repository       = "Pod-Shop-App-Configs"
    secret_name      = "example_secret_name"
    plaintext_value  = "var.some_secr^et_string"
  }

  */
  #locals {
  #  base_config = jsondecode(file("${path.module}/path_to_your_external_source.json"))
  #  overrides = [
  #    { name = "vm1", memory = 10240, agent = 2 },
  #    { name = "vm2", memory = 20480, agent = 3 },
  #    # Fügen Sie weitere Überschreibungen hinzu, wie benötigt
  #  ]
  #}
  # our external credentials file that thas  an secrets object that holds sensitive data 
