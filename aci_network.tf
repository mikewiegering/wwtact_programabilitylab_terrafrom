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
        bd_for_subnet    = subnet.aci_bd
        parent_dn        = "${aci_bridge_domain.bd_for_subnet.id}"
        description      = subnet.aci_subnet
        ip               = subnet.aci_subnet
       
    } 

    