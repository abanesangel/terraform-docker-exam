output "repository_clone_url" {
  description = "Repository HTTP Clone URL"
  value       = gitea_repository.exam_repo.clone_url
}

output "repository_web_url" {
  description = "Repository Web URL"
  value       = gitea_repository.exam_repo.html_url
}