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

#data "vsphere_datacenter" "dc" {
 # name = "Datacenter"
#}

data "vsphere_host" "host" {
  count         = "${length(var.esxi_hosts)}"
  name          = "${var.esxi_hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_distributed_virtual_switch" "dvs" {
  name          = "terraform-test-dvs"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

  uplinks         = ["uplink1", "uplink2", "uplink3"]
  active_uplinks  = ["uplink1", "uplink2"]
  standby_uplinks = ["uplink2", "uplink3"]

  host {
    host_system_id = "${data.vsphere_host.host.0.id}"
    devices        = ["${var.network_interfaces}"]
  }

  host {
    host_system_id = "${data.vsphere_host.host.1.id}"
    devices        = ["${var.network_interfaces}"]
  }
    
}