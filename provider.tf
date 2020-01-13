provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_region
  credentials = "services_account.json"
}

provider "kubernetes" {
  host                   = data.template_file.gke_host_endpoint.rendered
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered

  #   username = var.basic_auth_username
  #   password = var.basic_auth_password

}

data "google_client_config" "client" {}

data "google_client_openid_userinfo" "terraform_user" {}

data "template_file" "gke_host_endpoint" {
  template = module.gke_cluster.endpoint
}

data "template_file" "access_token" {
  template = data.google_client_config.client.access_token
}

data "template_file" "cluster_ca_certificate" {
  template = module.gke_cluster.cluster_ca_certificate
}
