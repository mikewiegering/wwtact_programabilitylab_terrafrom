locals {

csvdata = csvdecode(file("./network_csv.csv"))

}



resource "aci_application_profile" "tfapp" {
  count      = length(local.csvdata)
  tenant_dn  = "uni/tn-tftenant/ap-${local.csvdata[count.index].aci_app_profile}"
  name       = local.csvdata[count.index].aci_app_profile

}

resource "aci_vrf" "tfvrf" {
  count                  = length(local.csvdata)
  tenant_dn              = "uni/tn-tftenant/ctx-${local.csvdata[count.indext].aci_vrf}"
  name                   = local.csvdata[count.index].aci_vrf
  
}

resource "aci_bridge_domain" "tfbd" {
        count                       = length(local.csvdata)
        tenant_dn                   = "${aci_tenant.tftenant.id}"
        description                 = local.csvdata[count.index].aci_bd
        name                        = local.csvdata[count.index].aci_bd

        
    }

resource "aci_subnet" "tfsubnet" {
        count            = length(local.csvdata)
        bridge_domain_dn = "uni/tn-tftenant/BD-${local.csvdata[count.index].aci_bd}"
        description      = local.csvdata[count.index].aci_subnet
        ip               = local.csvdata[count.index].aci_subnet
    
    } 