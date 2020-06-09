provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

############################################################################
####### Defining vcenter data and querying vcenter for object ids   #######
############################################################################

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "vStorage1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Lab"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#data "vsphere_resource_pool" "pool" {
#  name          = "LabPool"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_network" "network" {
  name          = "Sim-Mgmt"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#data "vsphere_host" "host" {
 # name          = "esxi1.lab.local"
  #datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

#data "vsphere_host" "host" {
 # name          = "esxi2.lab.local"
 # datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}