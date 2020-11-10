locals {

csvdata = csvdecode(file("./network_csv.csv"))

}

resource "aci_bridge_domain" "tfbd" {
        count                       = length(local.csvdata)
        tenant_dn                   = "${aci_tenant.tftenant.id}"
        description                 = local.csvdata[count.index].aci_bd
        name                        = local.csvdata[count.index].aci_bd

        
    }

resource "aci_subnet" "tfsubnet" {
        for_each = { for subnet in local.csvdata : subnet.aci_subnet => subnet }
        
        parent_dn        = "${aci_bridge_domain.each.value.aci_bd.id}"
        description      = each.value.aci_subnet
        ip               = each.value.aci_subnet
       
    } 

    