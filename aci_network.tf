# locals{

# csvdata = csvdecode(network_csv)
# }

data "aci_bridge_domain" "bd" {
  count = "${length(slice(split("\n", lookup(data.local_file.network_csv.outputs, "filedata")), 1, length(split("\n", lookup(data.local_file.network_csv.outputs, "filedata")))))}"
  
  tenant_dn  = "${aci_tenant.tftenant.id}"
  name       = local.network_csv[count.index].aci_bd
}