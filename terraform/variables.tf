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