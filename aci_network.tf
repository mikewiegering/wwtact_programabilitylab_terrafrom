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
        count            = length(local.csvdata)
        bridge_domain_dn = aci_bridge_domain."${local.csvdata[count.index].aci_bd}".id
        description      = local.csvdata[count.index].aci_subnet
        ip               = local.csvdata[count.index].aci_subnet
    
    } 