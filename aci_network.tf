locals {

csvdata = csvdecode(file("./network_csv.csv"))

}

resource "aci_bridge_domain" "tfbd" {
        for_each = { for bd in local.csvdata : bd.aci_subnet => bd }
        tenant_dn                   = "${aci_tenant.tftenant.id}"
        description                 = each.value.aci_bd
        name                        = each.value.aci_bd

        
    }

resource "aci_subnet" "tfsubnet" {
        for_each = { for subnet in local.csvdata : subnet.aci_subnet => subnet }
        
        parent_dn        = "uni/tn-tftenant/BD-${csvdata.aci_bd}"
        description      = csvdata.aci_subnet
        ip               = csvdata.aci_subnet
       
    } 



