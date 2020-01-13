module "gke_cluster" {
  source              = "./modules/gke"
  gcp_project_name    = var.gcp_project_name
  gcp_region          = var.gcp_region
  basic_auth_username = var.basic_auth_username
  basic_auth_password = var.basic_auth_password

}

data "google_client_config" "client" {}


data "google_client_openid_userinfo" "terraform_user" {}
