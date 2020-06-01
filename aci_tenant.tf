resource "aci_tenant" "tftenant" {
  description = "New tenant created by terraform"
  name        = "tftenant"
  annotation  = "terraform"
  name_alias  = "tftenant"
}