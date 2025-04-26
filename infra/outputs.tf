output "vcn_id" {
  description = "OCID of the VCN"
  value       = oci_core_virtual_network.vcn.id
}
output "public_subnet_id" {
  description = "OCID of the public subnet"
  value       = oci_core_subnet.public_subnet.id
}
output "adb_id" {
  description = "OCID of the Autonomous Database"
  value       = oci_database_autonomous_database.adb.id
}
output "app_instance_ip" {
  description = "Public IP of the app compute instance"
  value       = oci_core_instance.app_instance.public_ip
}
output "load_balancer_ip" {
  description = "IP address of the OCI Load Balancer"
  value       = oci_load_balancer_load_balancer.lb.ip_addresses[0].ip_address
}