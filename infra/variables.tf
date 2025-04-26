variable "tenancy_ocid" {
  description = "OCID of the OCI tenancy"
  type        = string
}
variable "user_ocid" {
  description = "OCID of the user"
  type        = string
}
variable "fingerprint" {
  description = "Fingerprint for the API key"
  type        = string
}
variable "private_key_path" {
  description = "Path to the OCI API private key file"
  type        = string
}
variable "region" {
  description = "OCI region"
  type        = string
  default     = "us-ashburn-1"
}
variable "compartment_ocid" {
  description = "OCID of the compartment"
  type        = string
}
variable "db_admin_password" {
  description = "Admin password for the Autonomous Database"
  type        = string
  sensitive   = true
}
variable "arm_image_ocid" {
  description = "OCID of the Ampere A1 instance image"
  type        = string
}