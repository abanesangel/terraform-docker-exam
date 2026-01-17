output "nginx_container_id" {
  value = docker_container.web_server.id
}

output "health_checker_container_id" {
  value = docker_container.health_checker.id
}

output "network_id" {
  value = docker_network.exam_network.id
}

# output "repository_clone_url" {
#   description = "Repository HTTP Clone URL"
#   value       = gitea_repository.exam_repo.clone_url
# }

# output "repository_web_url" {
#   description = "Repository Web URL"
#   value       = gitea_repository.exam_repo.html_url
# }