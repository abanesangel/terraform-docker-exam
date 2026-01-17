variable "gitea_url" {
  description = "Gitea Server Base URL"
  type        = string
  default     = "http://localhost:3000"
}

variable "gitea_token" {
  description = "Gitea Personal Access Token"
  type        = string
  sensitive   = true
}

variable "repo_name" {
  description = "Repository Name to be created"
  type        = string
  default     = "terraform-docker-exam"
}

variable "gitea_username" {
  description = "Gitea Username"
  type        = string
}

variable "project_label" {
  description = "Project name label"
  type        = string
  default     = "devops-exam"
}

variable "env_label" {
  description = "Environment label"
  type        = string
  default     = "development"
}

variable "managed_by_label" {
  description = "Managed by label"
  type        = string
  default     = "terraform"
}