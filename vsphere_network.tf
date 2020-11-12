

# locals {

# csvdata = csvdecode(file("./network_csv.csv"))

# }


# data "vsphere_distributed_virtual_switch" "tfdvs" {
#   name          = "tf_test_dvs"
#   datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
# }

# data "vsphere_datacenter" "dc" {
#   name = "Datacenter"
# }

resource "vsphere_distributed_port_group" "tfpg" {
  for_each = { for pg in local.csvdata : pg.dist_pg => pg }
  name                            = each.value.dist_pg
  distributed_virtual_switch_uuid = "${vsphere_distributed_virtual_switch.tfdvs.id}"

  vlan_id = each.value.vlan_id
}

