

locals {

csvdata = csvdecode(file("./network_csv.csv"))

}

data "vsphere_host" "host" {
  name          = "esxi1.lab.local"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_distributed_virtual_switch" "tfdvs" {
  name          = "tf_test_dvs"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

resource "vsphere_distributed_port_group" "tfpg" {
  count                           = length(local.csvdata)
  name                            = local.csvdata[count.index].dist_pg
  distributed_virtual_switch_uuid = "${vsphere_distributed_virtual_switch.tfdvs.id}"

  vlan_id = local.csvdata[count.index].vlan_id
}

