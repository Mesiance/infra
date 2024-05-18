provider "serverspace" {
  key = var.serverspace_terraform_api_key
}

module "serverspace_k8s_cluster" {
  providers = {
    serverspace = serverspace
  }
  source = "./modules/serverspace_k8s_cluster"
  ssh_public_key = var.ssh_public_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_new_port = var.ssh_new_port
}