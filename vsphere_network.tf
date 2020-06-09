
#data "vsphere_datacenter" "dc" {
 # name = "Datacenter"
#}

# data "vsphere_host" "host" {
#  count         = "${length(var.esxi_hosts)}"
#  name          = "${var.esxi_hosts[count.index]}"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }

data "vsphere_host" "host" {
  name          = "esxi1.lab.local"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


# data "vsphere_host" "host2" {
#   name          = "esxi2.lab.local"
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }


resource "vsphere_distributed_virtual_switch" "dvs" {
  name          = "tf_test_dvs"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

  uplinks         = ["uplink1", "uplink2", "uplink3", "uplink4"]
  active_uplinks  = ["uplink1", "uplink2"]
  standby_uplinks = ["uplink3", "uplink4"]

    host {
    host_system_id = "${data.vsphere_host.host.id}"
    devices        = ["vmnic3", "vmnic4", "vmnic5"]
  }

#   host {
#     host_system_id = "${data.vsphere_host.host.1.id}"
#     devices        = ["vmnic3", "vmnic4", "vmnic5"]
#   }
  
 
    
}