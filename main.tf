#HX Policies
resource "intersight_hyperflex_auto_support_policy" "hx_auto_support_policy-tf" {
  admin_state               = true
  service_ticket_receipient = "zkovacev@cisco.com"
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_auto_support_policy-tf"
}

resource "intersight_hyperflex_local_credential_policy" "hx_local_credential_policy-tf" {
  hxdp_root_pwd               = var.hxdp_password
  hypervisor_admin            = var.esxi_admin
  hypervisor_admin_pwd        = var.esxi_password
  factory_hypervisor_password = false
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_local_credential_policy-tf"
}
output "intersight_hyperflex_local_credential_policy" {
    value = intersight_hyperflex_local_credential_policy.hx_local_credential_policy-tf
    sensitive = true
}
resource "intersight_hyperflex_proxy_setting_policy" "hx_proxy_setting_policy-tf" {
  hostname = var.proxy_hostname
  port     = var.proxy_port
  #username    = ""
  #password    = "ChangeMe"
  description = "Proxy Policy for SJC18 Lab"
  tags {
    key   = "SJC18"
    value = "Proxy"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_proxy_setting_policy-tf"
}
resource "intersight_hyperflex_sys_config_policy" "hx_sys_config_policy-tf" {
  dns_servers     = var.dns_servers
  ntp_servers     = var.ntp_servers
  timezone        = var.timezone
  dns_domain_name = var.dns_domain_name
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_sys_config_policy-tf"
}
resource "intersight_hyperflex_vcenter_config_policy" "hx_vcenter_config_policy-tf" {
  hostname    = var.vcenter_hostname
  username    = var.vcenter_username
  password    = var.vcenter_password
  data_center = var.vcenter_datacenter
  sso_url     = ""
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_vcenter_config_policy-tf-zk"
}
resource "intersight_hyperflex_node_config_policy" "hx_node_config_policy-tf" {
  mgmt_ip_range {
    end_addr   = var.mgmt_ip_end
    gateway    = var.mgmt_gateway
    netmask    = var.mgmt_netmask
    start_addr = var.mgmt_ip_start
  }
  hxdp_ip_range {
    end_addr   = var.hx_ip_end
    gateway    = var.hx_gateway
    netmask    = var.hx_netmask
    start_addr = var.hx_ip_start
  }
  node_name_prefix = var.node_prefix
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_node_config_policy-tf-zk"
}
resource "intersight_hyperflex_cluster_storage_policy" "hx_cluster_storage_policy-notVDI-tf" {
  disk_partition_cleanup = var.disk_partition_cleanup
  vdi_optimization       = var.vdi_optimization
  #could not make this work
  #logical_avalability_zone_config = {
  #   # type = bool
  #   # description = "Enable Logical Availibility Zones"
  #    #default = "false"
  #  auto_config = false
  #}
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_cluster_storage_policy-notVDI-tf-zk"
}
#Create HX Cluster network policy FI Managed

resource "intersight_hyperflex_cluster_network_policy" "hx_cluster_network_policy-fi-tf" {
  mgmt_vlan {
    name    = var.mgmt_vlan_name
    vlan_id = var.mgmt_vlan_id
  }
  vm_migration_vlan {
    name    = var.vm_migration_vlan_name
    vlan_id = var.vm_migration_vlan_id
  }
  # vm_network_vlans {
  #   name    = "VLAN22"
  #   vlan_id = 22
  # }
  vm_network_vlans = var.vm_networks_ids


  kvm_ip_range {
    start_addr = var.kvm_ip_start
    end_addr   = var.kvm_ip_end
    netmask    = var.kvm_netmask
    gateway    = var.kvm_gateway
  }

  jumbo_frame  = var.jumbo_frame
  uplink_speed = "default"

  mac_prefix_range {
    end_addr   = var.mac_prefix
    start_addr = var.mac_prefix
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name        = "hx_cluster_network_policy-fi-tf"
  description = "TF HyperFlex network policy for FI managed deployment "
}
resource "intersight_hyperflex_software_version_policy" "hx_software_version_policy-tf" {
  hxdp_version = var.hxdp_version
  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hx_software_version_policy-tf"
}

### Cluster HX Profile
resource "intersight_hyperflex_cluster_profile" "hyperflex_cluster_profile-cz" {
  #storage_data_vlan = {
  #    name    = "hx-storage-data"
  #    vlan_id = 27
  #}

  mgmt_ip_address    = "10.2.0.230"
  mac_address_prefix = "00:25:B5:D5"

  organization {
    object_type = "organization.Organization"
    moid        = var.organization_organization
  }
  name = "hyperflex_cluster_profile-cz"

  local_credential {
    moid        = intersight_hyperflex_local_credential_policy.hx_local_credential_policy-tf.moid
    object_type = "hyperflex.LocalCredentialPolicy"
    }

  mgmt_platform = "FI"
  replication   = 3
  description   = "This is hyperflex cluster profile"

  sys_config {
    moid        = intersight_hyperflex_sys_config_policy.hx_sys_config_policy-tf.moid
    object_type = "hyperflex.SysConfigPolicy"
  }
  node_config {
    moid        = intersight_hyperflex_node_config_policy.hx_node_config_policy-tf.moid
    object_type = "hyperflex.NodeConfigPolicy"
  }
  cluster_network {
    moid        = intersight_hyperflex_cluster_network_policy.hx_cluster_network_policy-fi-tf.moid
    object_type = "hyperflex.ClusterNetworkPolicy"
  }
  cluster_storage {
    moid        = intersight_hyperflex_cluster_storage_policy.hx_cluster_storage_policy-notVDI-tf.moid
    object_type = "hyperflex.ClusterStoragePolicy"
  }
  vcenter_config {
    moid        = intersight_hyperflex_vcenter_config_policy.hx_vcenter_config_policy-tf.moid
    object_type = "hyperflex.VcenterConfigPolicy"
  }
  hypervisor_type = "ESXi"
  storage_type    = "HyperFlexDp"
  auto_support {
    moid        = intersight_hyperflex_auto_support_policy.hx_auto_support_policy-tf.moid
    object_type = "hyperflex.AutoSupportPolicy"
  }
  proxy_setting {
    moid        = intersight_hyperflex_proxy_setting_policy.hx_proxy_setting_policy-tf.moid
    object_type = "hyperflex.ProxySettingPolicy"
  }
  tags {
    key   = "test"
    value = "ucsback-10G-3nodehx-cluster-"
  }  
  software_version {
    moid        = intersight_hyperflex_software_version_policy.hx_software_version_policy-tf.moid
    object_type = "hyperflex.SoftwareVersionPolicy"
  }

  #storage_data_vlan = {
  #  name    = "hx-storage-data"
  #  vlan_id = 27
  #}

}
  #
  #  storage_data_vlan = {
  #    name    = var.hx_storage_vlan_name
  #    vlan_id = var.hx_storage_vlan_id
  #  }
  #  

#ZK