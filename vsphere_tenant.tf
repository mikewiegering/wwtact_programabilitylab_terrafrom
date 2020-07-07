
############################################################################
####### Defining vcenter data and querying vcenter for object ids   #######
############################################################################

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "vStorage1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Lab"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#data "vsphere_resource_pool" "pool" {
#  name          = "LabPool"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_network" "network" {
  name          = "Sim-Mgmt"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_distributed_virtual_switch" "tfdvs" {
  name          = "tf_test_dvs"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"

  uplinks         = ["uplink1", "uplink2", "uplink3", "uplink4"]
  active_uplinks  = ["uplink1", "uplink2"]
  standby_uplinks = ["uplink3", "uplink4"]

}

  data "vsphere_host" "host" {
  name          = "esxi1.lab.local"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
