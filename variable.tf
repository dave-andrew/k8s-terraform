# Variable for communicating with Proxmox API Server
# If you are using root user please uncheck Previlege Seperation!
# Privilege Seperation will not return the state of the VM State back to Terraform 
# variable "proxmox_api" {
#     type = object({
#         # Proxmox API Server URL
#         url = string
#         # Token ID to access Proxmox API Server
#         token_id = string
#         # Token ID to access Proxmox API Server
#         token_secret = string
#     })
# }


# Define The Control Plane/Master Nodes and IP address
variable "control-planes" {
  type = map(object({
    # vmid: The VM ID Number
    # ex  : '100'
    vmid        = string
    # name: The VM Name. ex: Control Plane
    # ex  : 'master-node-X' 
    name        = string
    # desc: VM Description
    # ex  : 'master-node-X for XYZ cluster'
    desc        = string
    # target_node: The destination of the VM 
    target_node = string
    # ipconfig0: state the ip address and gateway
    # format: 'ip=XX.XX.XX.XX/SUBNET,gw=XX.XX.XX.XX;'
    # ex    : 'ip=10.35.10.20/24,gw=10.35.10.1'
    ipconfig0   = string
    # memory: The memory allocation for the VM
    # ex    : 2048
    memory      = number
  }))
}

# Define The Workers/Slave Nodes and IP address
variable "workers" {
  type = map(object({
    # vmid: The VM ID Number
    # ex  : '100'
    vmid        = string
    # name: The VM Name. ex: Control Plane
    # ex  : 'master-node-X' 
    name        = string
    # desc: VM Description
    # ex  : 'master-node-X for XYZ cluster'
    desc        = string
    # target_node: The destination of the VM 
    target_node = string
    # ipconfig0: state the ip address and gateway
    # format: 'ip=XX.XX.XX.XX/SUBNET,gw=XX.XX.XX.XX;'
    # ex    : 'ip=10.35.10.20/24,gw=10.35.10.1'
    ipconfig0   = string
    # memory: The memory allocation for the VM
    # ex    : 2048
    memory      = number
  }))
}



# =============
# Secrets
# 
# Once the VM successfully deployed
# All VM Can be accessed by using SSH connection
# to authenticate you can use password or SSH keys

variable "proxmox_api_url" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

# Cloud Init User: The User for accessing server
variable "ciuser" {
  type      = string
  sensitive = true
}

# Cloud Init User: The Password for accessing server
variable "cipassword" {
  type      = string
  sensitive = true
}

# Cloud Init User: The keys for accessing server
variable "sshkeys" {
  type      = string
  sensitive = true
}

