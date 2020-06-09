variable "vsphere_user" {
  default = "username"
}

variable "vsphere_password" {
  default = "password"
}

variable "vsphere_server" {
  default = "server hostname"
}

variable "aci_username" {
  default = "username"
}

variable "aci_password" {
  default = "password"
}

variable "aci_apic" {
  default = "apic login url"
}

variable "esxi_hosts" {
  default = [
    "esxi1",
    "esxi2",
  ]
}

variable "network_interfaces" {
  default = [
    "vmnic3",
    "vmnic4",
    "vmnic5",
  ]
}

network_interfaces = [ "vmnic3" , "vmnic4" , "vmnic5" ]