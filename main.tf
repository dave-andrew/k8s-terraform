terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = true
}


resource "proxmox_vm_qemu" "k8s-control-planes" {
  # K8s Informations
  for_each    = var.control-planes
  vmid        = each.value["vmid"]
  name        = each.value["name"]
  desc        = each.value["desc"]
  target_node = each.value["target_node"]
  agent       = 1

  # K8s Clone Configuration
  clone      = "k8s-template"
  full_clone = true

  # K8s Resources
  cores   = 2
  sockets = 2
  cpu     = "host"
  memory  = 4096

  os_type = "cloud-init"
  scsihw  = "virtio-scsi-pci"
  boot = "order=scsi0;net0"

  # Cloud Init Configuration
  ipconfig0  = each.value["ipconfig0"]
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys

  # K8s SSH Configuration
  ssh_user = var.ciuser

  # K8s Network Configuration
  network {
    bridge = "vmbr1"
    model  = "virtio"
    firewall = true
  }

  # K8s Disk Configuration
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
          # size = "100G"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size = "100G"
        }
      }
    }
  }
}


resource "proxmox_vm_qemu" "k8s-workers" {
  # K8s Informations
  for_each    = var.workers
  vmid        = each.value["vmid"]
  name        = each.value["name"]
  desc        = each.value["desc"]
  target_node = each.value["target_node"]
  agent       = 1

  # K8s Clone Configuration
  clone      = "k8s-template"
  full_clone = true

  # K8s Resources
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 4096

  os_type = "cloud-init"
  scsihw  = "virtio-scsi-pci"
  boot = "order=scsi0;net0"

  # Cloud Init Configuration
  ipconfig0  = each.value["ipconfig0"]
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys

  # K8s SSH Configuration
  ssh_user = var.ciuser

  # K8s Network Configuration
  network {
    bridge = "vmbr1"
    model  = "virtio"
    firewall = true
  }

  # K8s Disk Configuration
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
          # size = "100G"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size = "100G"
        }
      }
    }
  }
}
