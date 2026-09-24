resource "docker_image" "backend" {
  name = "terraform-backend:latest"

  build {
    context    = "${path.module}/backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "backend" {
  name  = "terraform-backend"
  image = docker_image.backend.image_id

  env = [
    "DB_HOST=terraform-postgres",
    "DB_NAME=${var.postgres_db}",
    "DB_USER=${var.postgres_user}",
    "DB_PASSWORD=${var.postgres_password}"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 5000
    external = 5000
  }
}