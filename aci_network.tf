locals {

csvdata = csvdecode(file("./network_csv.csv"))

}

resource "aci_bridge_domain" "tfbd" {
        for_each = { for bd in local.csvdata : bd.aci_subnet => bd }
        tenant_dn                   = "${aci_tenant.tftenant.id}"
        description                 = each.value.bd_description
        name                        = each.value.aci_bd

        
    }

resource "aci_subnet" "tfsubnet" {
        for_each = { for subnet in local.csvdata : subnet.aci_subnet => subnet }
        bridge_domain_dn = "uni/tn-tftenant/BD-${each.value.aci_bd}"
        description      = each.value.subnet_description
        ip               = each.value.aci_subnet
       
    } 

resource "aci_application_epg" "tfepg" {
    for_each = { for epg in local.csvdata : epg.aci_epg => epg }
    application_profile_dn  = "uni/tn-tftenant/epg-${each.value.aci_epg}"
    name                              = each.value.aci_epg
    
  }

