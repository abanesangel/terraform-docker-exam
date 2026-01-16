terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"
    }
  }
}

provider "gitea" {
  base_url = var.gitea_url
  token    = var.gitea_token
}

# Repository Creation
resource "gitea_repository" "exam_repo" {
  name             = var.repo_name
  username         = var.gitea_username
  private          = true
  auto_init        = true
  default_branch   = "main"
}

# # 2. Branch Protection Configuration
# resource "gitea_repository_branch_protection" "main_protection" {
#   username   = var.gitea_username
#   #repository = gitea_repository.exam_repo.name
  
#   name      = "main"
#   rule_name = "main" 

#   #no_force_push  = true
#   enable_push    = true

#   depends_on = [gitea_repository.exam_repo]
# }