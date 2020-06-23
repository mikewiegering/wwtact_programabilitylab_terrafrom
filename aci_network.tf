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
        bd               = local.csvdata[count.index].aci_bd
        bdid             = "aci_bridge_domain.${var.bd}.id"
        bridge_domain_dn = bdid
        description      = local.csvdata[count.index].aci_subnet
        ip               = local.csvdata[count.index].aci_subnet
    
    } 