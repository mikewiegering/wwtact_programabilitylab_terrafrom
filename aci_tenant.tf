resource "aci_tenant" "tftenant" {
  name   = "tftenant"
}

resource "aci_vrf" "tfvrf" {
  tenant_dn    = "uni/tn-tftenant"
  name         = "test_vrf_1"
}


resource "aci_application_profile" "tfapp" {
  tenant_dn     = "uni/tn-tftenant"
  name          = "access"
}