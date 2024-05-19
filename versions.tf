terraform {
  required_providers {
    serverspace = {
      source = "itglobalcom/serverspace"
      version = "0.3.0"
    }
  }
  required_version = ">= 1.0"
}

data "terraform_remote_state" "gitlab_remote_state" {
  backend = "http"
  config = {
    address        = "https://gitlab.com/api/v4/projects/${var.gitlab_project_id}/terraform/state/${var.gitlab_tf_state_name}"
    lock_address   = "https://gitlab.com/api/v4/projects/${var.gitlab_project_id}/terraform/state/${var.gitlab_tf_state_name}/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/${var.gitlab_project_id}/terraform/state/${var.gitlab_tf_state_name}/lock"
    username       = var.gitlab_username
    password       = var.gitlab_access_token
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}