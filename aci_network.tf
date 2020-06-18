locals{

csvdata = csvdecode(network_csv)
}

data "aci_bridge_domain" "bd" {
  foreach = { for bd in local.csvdata : bd.aci_bd => bd }
  
  tenant_dn  = "${aci_tenant.tftenant.id}"
  name       = each.value.aci_bd
}