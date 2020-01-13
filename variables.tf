variable "gcp_project_id" {
  description = "Google project ID"
}

variable "gcp_project_name" {
  description = "Google project name"
}

variable "gcp_region" {
  description = "Google project region"
  default     = ""
}

variable "workspace" {
  description = "Name workspace"
  default     = ""
}

variable "host" {
  description = "Host"
  default     = ""
}

variable "basic_auth_username" {
  description = "Auth username"
  default     = ""
}

variable "basic_auth_password" {
  description = "Auth password"
  default     = ""
}
