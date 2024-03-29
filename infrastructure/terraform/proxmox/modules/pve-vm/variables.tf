# ---------------------------------------------------------------------------------------------------
# Reference: github.com/Telmate/terraform-provider-proxmox/blob/master/docs/resources/vm_qemu.md
# ---------------------------------------------------------------------------------------------------

variable "vm_name" {
  description = "The name of the VM within Proxmox."
  type        = string
}

variable "vmid" {
  description = "The VMID of the VM within promxox"
  type        = number
}

variable "target_node" {
  description = "The name of the Proxmox node on which to place the VM"
  type        = string
}

variable "clone" {
  description = "The base VM from which to clone to create the new VM."
  type        = string
}

variable "full_clone" {
  description = "Set to true to create a full clone, or false to create a linked clone."
  type        = bool
  default     = true
}

variable "hotplug" {
  description = "Comma delimited list of hotplug features to enable"
  type        = string
  default     = "network,disk,usb"	
}


variable "desc" {
  description = "Sets the description seen in the web interface"
  type        = string
  default     = "Terraform created VM"
}

variable "sockets" {
  description = "The number of CPU sockets to allocate to the VM."
  type        = number
  default     = 1
}

variable "cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM."
  type        = number
  default     = 1
}

variable "memory" {
  description = "A number containing the amount of RAM to assign to the container (in MB)."
  type        = string
  default     = "1024"
}

variable "vm_network" {
  description = "Specify network devices"
  type = list(object({
    model  = string
    bridge = string
    tag    = number
  }))
  default = [
    {
      model  = "virtio"
      bridge = "vmbr0"
      tag    = null
    }
  ]
}

variable "vm_disk" {
  description = "Specify disk variables"
  type = list(object({
    type    = string
    storage = string
    size    = string
    format  = string
    ssd     = number
  }))
  default = [
    {
      type    = "scsi"
      storage = "vm-store"
      size    = "32G"
      format  = "raw"
      ssd     = 0
    }
  ]
}

variable "onboot" {
  description = "A boolean that determines if the container will start on boot."
  type        = bool
  default     = false
}

variable "ipconfig0" {
  description = "The first IP address to assign to the guest. Format ref: github.com/Telmate/terraform-provider-proxmox/blob/master/docs/resources/vm_qemu.md"
  type        = string
}

variable "ip_address" {
  description = "IP address of the VM"
  type        = string
}

variable "nameserver" {
  description = "The DNS server IP address used by the container"
  type        = string
  default     = "8.8.8.8"
}

variable "searchdomain" {
  description = "Sets the DNS search domains for the container"
  type        = string
  default     = ".local"
}

variable "boot" {
  description = "VM boot order. The Telmate provider has a bug, this module implements the workaround. Ref: https://github.com/Telmate/terraform-provider-proxmox/issues/282."
  type        = string
  default     = "order=virtio0;ide2;net0"
}

variable "agent" {
  description = "1 enables QEMU Guest Agent, 0 disables. Must run the qemu-guest-agent daemon in the quest for this to have any effect."
  type        = number
  default     = 1
}

variable "ssh_public_keys" {
  description = "Temp SSH public key that will be added to the container"
  type        = string
}

# variable "private_key" {
#     description = "Temp SSH private key for provisioning"
#     type = string
# }

variable "default_image_username" {
  description = "Username baked into template image, used for initial connection for configuration"
  type        = string
}

variable "default_image_password" {
  description = "Password for default user baked into template image, used for initial connection for configuration"
  type        = string
  default     = ""
}

variable "provisioner_type" {
  description = "Connection type that should be used by Terraform. Valid types are ssh and winrm"
  type        = string
  default     = "ssh"
}

variable "target_platform" {
  description = "Target platform Terraform provisioner connects to. Valid values are windows and unix"
  type        = string
  default     = "unix"
}

variable "serial" {
  description = "Create a serial device inside the VM. Serial interface of type socket is used by xterm.js. Using a serial device as terminal"
  type = object({
    id   = number
    type = string
  })
  default = {
    id   = 0
    type = "socket"
  }
}

variable "tablet" {
  description = "Enable/disable the USB tablet device. This device is usually needed to allow absolute mouse positioning with VNC."
  type        = bool
  default     = false
}

variable "balloon" {
  description = "The minimum amount of memory to allocate to the VM in Megabytes, when Automatic Memory Allocation is desired. Proxmox will enable a balloon device on the guest to manage dynamic allocation. See the docs about memory for more info."
  type        = number
  default     = 0
}

variable "vcpus" {
  description = "The number of vCPUs plugged into the VM when it starts. If 0, this is set automatically by Proxmox to sockets * cores."
  type        = number
  default     = 0
}

variable "numa" {
  description = "Whether to enable Non-Uniform Memory Access in the guest."
  type        = bool
  default     = false
}

variable "cpu" {
  description = "The type of CPU to emulate in the Guest. See the docs about CPU Types for more info."
  type        = string
  default     = "host"
}

variable "pool" {
  description = "The resource pool to which the VM will be added."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags of the VM. This is only meta information."
  type        = string
  default     = ""
}

# variable "machine" {
#   description = "Definition of the virtual machine"
#   type        = string
#   default     = "i440fx"
# }

# variable "vm_hostpci" {
#   description = "List of PCI devices to pass through to the virtual machine"
#   type        = any
# }