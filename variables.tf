variable "apikey" {
  type        = string
  description = "API Key for Intersight"
  sensitive   = true
  default     = "59b323f9f11aa10001496a3b/59b31424f11aa1000146f75e/61a994c67564612d32e8183a"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
  default     = "/Users/zkovacev/Learning/terraform/intersight/zoran-intersight/Intersight-SecretKey.txt"
}
#variable "api_endpoint" {
#  type        = string
#  description = "API Endpoint URL"
#  #default     = "https://www.intersight.com"
#}
#variable "organization_name" {
#  type        = string
#  description = "target organization name"
#  default     = "default"
#}
/*
variable "mac_pool_moid" {
  type        = string
  description = "moid of MAC pool for VNIC use"
}
variable "ip_pool_moid" {
  type        = string
  description = "moid of IP pool for IMC use"
}
*/

variable "organization_organization" {
  type        = string
  description = "moid of default organization"
  default     = "5ddeb4a66972652d3100e678"

}

variable "mgmt_vlan_name" {
  type        = string
  description = "ESXi management VLAN name"
  default     = "hx-mgmt-vlanVLAN-ID"
}

variable "mgmt_vlan_id" {
  type        = number
  description = "ESXi management VLAN ID"
  default     = 301
}


variable "vm_migration_vlan_name" {
  type        = string
  description = "ESXi vmotion VLAN name"
  default     = "vmotion-24"
}

variable "vm_migration_vlan_id" {
  type        = number
  description = "ESXi vmotion VLAN ID"
  default     = 777
}

#}
#variable "vm_networks_name" {
##  type = string
#  description = "ESXi management VLAN name"
#}

variable "vm_networks_ids" {
  type        = list(any)
  description = "ESXi Guest VLAN names and VLAN ID"
  default = [
    {
      name                  = "vlan22",
      vlan_id               = "22"
      additional_properties = null
      class_id              = "hyperflex.NamedVlan"
      object_type           = "hyperflex.NamedVlan"
    },
    {
      name                  = "vm-network-1902",
      vlan_id               = "1902"
      additional_properties = null
      class_id              = "hyperflex.NamedVlan"
      object_type           = "hyperflex.NamedVlan"
    }
  ]
}

variable "kvm_ip_start" {
  type        = string
  description = "KVM management IP start"
  default     = "10.2.0.180"
}
variable "kvm_ip_end" {
  type        = string
  description = "KVM management IP end"
  default     = "10.2.0.189"
}

variable "kvm_netmask" {
  type        = string
  description = "KVM management netmask"
  default     = "255.255.255.0"
}

variable "kvm_gateway" {
  type        = string
  description = "KVM management gateway"
  default     = "10.2.0.254"
}

variable "jumbo_frame" {
  type        = bool
  description = "Enable or disable jumbo frames for HX storage traffic"
  default     = true
}

variable "mac_prefix" {
  type        = string
  description = "mac prefix range"
  default     = "00:25:B5:D3"
}

variable "disk_partition_cleanup" {
  type        = bool
  description = "Enable or skip clean of the existing disks"
  default     = false
}

variable "vdi_optimization" {
  type        = bool
  description = "Enable VDI Optimizaton"
  default     = false
}
variable "hxdp_password" {
  type        = string
  sensitive   = true
  description = "the password set for HX controller & Cluster management"
  default     = "Flexpod123!"
}
variable "esxi_password" {
  type        = string
  sensitive   = false
  description = "ESXi password"
  default     = "Flexpod123!"
}
variable "esxi_admin" {
  type        = string
  description = "The Admin account for ESXi"
  default     = "root"
}
variable "factory_password" {
  type        = bool
  default     = true
  description = "is ESXi hypervisor installed with factory applied password"
}
variable "mgmt_ip_start" {
  type        = string
  description = "ESXi Management IP address range start"
  default     = "10.2.0.2"
}
variable "mgmt_ip_end" {
  type        = string
  description = "ESXi Management IP address range end"
  default     = "10.2.0.9"
}
variable "mgmt_netmask" {
  type        = string
  description = "ESXi Management IP address net"
  default     = "255.255.255.0"
}
variable "mgmt_gateway" {
  type        = string
  description = "Gateway for ESXi"
  default     = "10.2.0.254"
}

variable "hx_ip_start" {
  type        = string
  description = "HX Controller IP address range start"
  default     = "10.2.0.180"
}
variable "hx_ip_end" {
  type        = string
  description = "HX Controller IP address range end"
  default     = "10.2.0.190"
}
variable "hx_netmask" {
  type        = string
  description = "HX Controller IP address net"
  default     = "255.255.255.0"
}
variable "hx_gateway" {
  type        = string
  description = "Gateway for HX Controller"
  default     = "10.2.0.254"
}

variable "node_prefix" {
  type        = string
  description = "Prefix for the names of the nodes assigned to ESXi"
  default     = "hxaf220m5"
}

variable "proxy_enable" {
  type        = bool
  description = "Set to true or false to use a proxy server for internet access"
  default     = "true"
}

variable "proxy_hostname" {
  type        = string
  description = "Proxy server DNS hostname"
  default     = "proxy.esl.cisco.com"
}


variable "proxy_port" {
  description = "Proxy server port number"
  default     = "80"
}
/*
variable "proxy_username" {
  type = string
  description = "Proxy server username"
}

variable "proxy_password" {
  type = string
  sensitive = true
  description = "Proxy server password"
}
*/

variable "timezone" {
  type        = string
  description = "The timezone of the HX Cluster"
  default     = "America/Los_Angeles"
}

variable "dns_domain_name" {
  type        = string
  description = "The base DNS domain name for the nodes in the HX Cluster"
  default     = "plslab.net"
}

variable "dns_servers" {
  type        = list(any)
  description = "The DNS servers"
  default     = ["10.2.2.1", "10.2.2.4", "192.168.2.1"]
}

variable "ntp_servers" {
  type        = list(any)
  description = "The NTP servers"
  default     = ["10.2.2.1", "10.2.2.4", "192.168.2.1"]
}

variable "vcenter_hostname" {
  type        = string
  description = "DNS name or IP address of vCenter Server"
  default     = "vcenter.plslab.net"
}

variable "vcenter_username" {
  type        = string
  description = "Administrative user for vCenter"
  default     = "admnistrator@vsphere.local"
}

variable "vcenter_password" {
  type        = string
  sensitive   = true
  description = "Administrative user password for accessing vCenter"
  default     = "Flexpod1"
}

variable "vcenter_datacenter" {
  type        = string
  description = "Name of the vCenter Datacenter where the HX cluster will be placed"
  default     = "PLSLAB"
}

variable "hxdp_version" {
  type        = string
  description = "The version of HX to install"
  #default = "4.5(2b)"
  default = "5.0(1a)"
}
variable "server_firmware_version" {
  type        = string
  description = "ucs server firmware version"
  default     = "4.2(1i)"
}

# Storage Data VLAN
variable "hx_storage_vlan_name" {
  type        = string
  description = "The name of the HX storage VLAN in the UCSM configuration"
  default     = "hx-storage-930"
}

variable "hx_storage_vlan_id" {
  type        = string
  description = "The VLAN ID of the HX storage VLAN"
  default     = "930"
}





