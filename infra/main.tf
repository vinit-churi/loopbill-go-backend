# Networking
resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  display_name   = "loopbill-vcn"
  cidr_block     = "10.0.0.0/16"
}
resource "oci_core_subnet" "public_subnet" {
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.vcn.id
  display_name        = "loopbill-public"
  cidr_block          = "10.0.1.0/24"
  prohibit_public_ip_on_vnic = false
}

# Autonomous Database
resource "oci_database_autonomous_database" "adb" {
  compartment_id             = var.compartment_ocid
  display_name               = "loopbill-adb"
  db_name                    = "LOOPBILLDB"
  cpu_core_count             = 1
  data_storage_size_in_tbs   = 1
  admin_password             = var.db_admin_password
  db_workload                = "OLTP"
  license_model              = "LICENSE_INCLUDED"
  is_auto_scaling_enabled    = false
}

# Compute Instance
# resource "oci_core_instance" "app_instance" {
#   compartment_id = var.compartment_ocid
#   display_name   = "loopbill-app-instance"
#   shape          = "Ampere_A1_Flex"
#   availability_domain = var.availability_domain
#   source_details {
#     source_type = "image"
#     image_id    = var.arm_image_ocid
#   }
#   create_vnic_details {
#     subnet_id = oci_core_subnet.public_subnet.id
#     assign_public_ip = true
#   }
# }

# Load Balancer
resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id = var.compartment_ocid
  display_name   = "loopbill-lb"
  shape          = "100Mbps"
  is_private     = false
  subnet_ids     = [oci_core_subnet.public_subnet.id]
}