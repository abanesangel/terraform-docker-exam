terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"
    }
    docker = {
        source = "kreuzwerker/docker"
        version = "3.0.2"
    }
  }
}

provider "gitea" {
  base_url = var.gitea_url
  token    = var.gitea_token # This MUST have a value
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

# Docker Network Creation
resource "docker_network" "exam_network" {
  name = "exam-network"
  labels {
    label = "project"
    value = var.project_label
  }
  labels {
    label = "environment"
    value = var.env_label
  }
}

# Pull Nginx Image
resource "docker_image" "nginx_img" {
  name = "nginx:1.27.4"
  keep_locally = false
}

# Start Nginx Container
resource "docker_container" "web_server" {
    name = "exam-web-server"
    image = docker_image.nginx_img.image_id

    networks_advanced {
        name = docker_network.exam_network.name
    }

    ports {
        internal = 80
        external = 8080
    }

    labels {
        label = "project"
        value = var.project_label
    }
    labels {
        label = "environment"
        value = var.env_label
    }
    labels {
        label = "managed_by"
        value = var.managed_by_label
    }
}

# Pull Curl Image
resource "docker_image" "curl_img" {
  name = "curlimages/curl:8.17.0"
  keep_locally = false
}

# Start Health Checker Container
resource "docker_container" "health_checker" {
  name  = "exam-health-checker"
  image = docker_image.curl_img.image_id

  command = [
    "sh",
    "-c", "while true; do curl -sf http://exam-web-server:80 || echo 'Health check failed'; sleep 30; done"
  ]

  networks_advanced {
    name = docker_network.exam_network.name
  }

  labels {
    label = "project"
    value = var.project_label
  }
  labels {
    label = "environment"
    value = var.env_label
  }
  labels {
    label = "managed_by"
    value = var.managed_by_label
  }

  depends_on = [docker_container.web_server]
}

# # Repository Creation
# resource "gitea_repository" "exam_repo" {
#   name             = var.repo_name
#   username         = var.gitea_username
#   private          = true
#   auto_init        = true
#   default_branch   = "main"
# }

# # Branch Protection Configuration
# resource "gitea_repository_branch_protection" "main_protection" {
#   username   = var.gitea_username
#   name = gitea_repository.exam_repo.name
#   rule_name = "main"

#   enable_push = true

#   depends_on = [gitea_repository.exam_repo]
# }