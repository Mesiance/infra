# TF state management creds
#==================================
variable "gitlab_username" {
  type = string
  description = "Gitlab username to query remote state"
}

variable "gitlab_access_token" {
  type = string
  description = "GitLab access token to query remote state"
}

variable "gitlab_project_id" {
  type = string
  description = "GitLab project ID where state-file stores"
}

variable "gitlab_tf_state_name" {
  type = string
  description = "TF state file name"
}

# Serverspace vars
#===================================

variable "serverspace_terraform_api_key" {
  description = "Main API-key for serverspace account. Name: Terraform"
  type = string
  sensitive = true
}

variable "ssh_public_key" {
  description = "Main SSH key to put to created VMs"
  type = string
  sensitive = true
}

variable "ssh_private_key_path" {
  description = "Path to private key of ssh_public_key to connect to created vm"
  type = string
  sensitive = true
}

variable "ssh_new_port" {
  description = "SSH port to change on"
  type = string
}